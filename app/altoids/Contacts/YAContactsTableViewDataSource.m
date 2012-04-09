//
//  YAContactsTableViewDataSource.m
//  altoids
//
//  Created by Derrick Whittle on 2/14/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAContactsTableViewDataSource.h"
#import "ContactsTableViewDataSourceDelegate.h"
#import "ContactRepository.h"
#import "MutableDictionaryCreator.h"
#import "MutableArrayCreator.h"
#import "TableViewCellCreator.h"
#import "YAContact.h"

@implementation YAContactsTableViewDataSource

@synthesize contactRepository = contactRepository_,
            mutableDictionaryCreator = mutableDictionaryCreator_,
            mutableArrayCreator = mutableArrayCreator_,
            tableViewCellCreator = tableViewCellCreator_,
            sectionIndexTitles = sectionIndexTitles_,
            sectionIndexTitlesDelimiter = sectionIndexTitlesDelimiter_,
            sectionIndexTitlesNonAlphabeticSection = sectionIndexTitlesNonAlphabeticSection_;
@synthesize delegate = delegate_,
            sectionIndexes = sectionIndexes_,
            contactsBySection = contactsBySection_;



- (id) initWithDelegate:(id<ContactsTableViewDataSourceDelegate>)delegate
{
    self = [super init];
    if(self)
    {
        delegate_ = delegate;
    }
    return self;
}

- (void) dealloc
{
    [self unload];
}

- (void) loadContacts:(NSArray*)contacts
{
    // TODO if profiling says this bucketing by alphabetic section is slow, move it to a background thread (probably by simply moving it into the contact loader command object itself)

    // TODO this code will be refactored into something more testable (after profiling results)

    NSUInteger sectionCount = [sectionIndexes_ count];
    NSMutableArray* contactsBySection = [mutableArrayCreator_ mutableArrayWithCapacity:sectionCount];
    NSNumber* nonAlphabeticSectionIndex;

    // build a dictionary of section titles (lower and upper case variants) mapped to section index
    NSMutableDictionary* sectionByTitle = [mutableDictionaryCreator_ mutableDictionaryWithCapacity:(sectionCount * 2)];
    for(NSUInteger sectionIndex = 0; sectionIndex < sectionCount; ++sectionIndex)
    {
        NSString* sectionTitle = [sectionIndexes_ objectAtIndex:sectionIndex];
        NSNumber* sectionIndexNumber = [NSNumber numberWithUnsignedInt:sectionIndex];
        [sectionByTitle setObject:sectionIndexNumber forKey:[sectionTitle lowercaseString]];
        [sectionByTitle setObject:sectionIndexNumber forKey:[sectionTitle uppercaseString]];
        
        if(!nonAlphabeticSectionIndex && [sectionTitle isEqualToString:sectionIndexTitlesNonAlphabeticSection_])
        {
            nonAlphabeticSectionIndex = [NSNumber numberWithUnsignedInt:sectionIndex];
        }

        [contactsBySection addObject:[mutableArrayCreator_ mutableArrayWithCapacity:2]];   // TODO: profiling opportunity?
    }

    // now walk the contacts and put them into the right sections
    for(YAContact* contact in contacts)
    {
        NSString* name = [contact compositeName];
        if([name length] < 1)
        {
            name = [contact familyName];
            if([name length] < 1)
            {
                name = sectionIndexTitlesNonAlphabeticSection_; // force the unnamed contact to the non-alphabetic section
            }
        }
        name = [name substringToIndex:1];   // get just the first character, to look up the section index for it
        
        NSNumber* sectionIndexForContact = [sectionByTitle objectForKey:name];
        if(sectionIndexForContact == nil)
        {
            sectionIndexForContact = nonAlphabeticSectionIndex;
        }

        NSMutableArray* sectionArray = [contactsBySection objectAtIndex:[sectionIndexForContact unsignedIntValue]];
        [sectionArray addObject:contact];
    }

    contactsBySection_ = contactsBySection;
    [delegate_ contactsTableViewDataSourceDidLoadContacts:self];
}

- (void) reload
{
    [self loadContacts:[contactRepository_ contacts]];
}


# pragma mark TableViewDataSource methods

- (void) load
{
    if(contactsBySection_)
    {
        return;
    }

    [contactRepository_ addSubscriber:self];
    sectionIndexes_ = [sectionIndexTitles_ componentsSeparatedByString:@","];
    [self loadContacts:[contactRepository_ contacts]];
}

- (void) unload
{
    [contactRepository_ removeSubscriber:self];
}

- (void) didReceiveMemoryWarning
{
    contactsBySection_ = nil;
}


# pragma mark ContactsTableViewDataSource methods

- (YAContact*) contactAtIndexPath:(NSIndexPath*)indexPath
{
    if(!contactsBySection_)
    {
        [self reload];
    }
    
    NSArray* contactsForSection = [contactsBySection_ objectAtIndex:[indexPath section]];
    return [contactsForSection objectAtIndex:[indexPath row]];
}


#pragma mark Delegater methods

- (void) clearDelegate:(id)delegate
{
    if(delegate_ == delegate)
    {
        delegate_ = nil;
    }
}


#pragma mark UITableViewDataSource methods

- (NSInteger) numberOfSectionsInTableView:(UITableView*)tableView
{
    return [sectionIndexes_ count];
}

- (NSInteger) tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    if(!contactsBySection_)
    {
        [self reload];
    }

    NSArray* contactsForSection = [contactsBySection_ objectAtIndex:section];
    return [contactsForSection count];
}

- (NSArray*) sectionIndexTitlesForTableView:(UITableView*)tableView
{
    return sectionIndexes_;
}

- (NSInteger) tableView:(UITableView*)tableView sectionForSectionIndexTitle:(NSString*)title atIndex:(NSInteger)index
{
    return index;
}

- (NSString*) tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section
{
    if(!contactsBySection_)
    {
        [self reload];
    }

    NSArray* contactsForSection = [contactsBySection_ objectAtIndex:section];
    if([contactsForSection count] < 1)
    {
        return nil; // suppresses section header for empty sections
    }
    
    return [sectionIndexes_ objectAtIndex:section];
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    // TODO if the design for this table becomes richer than a simple standard table,
    //      we should create a cell class/xib instead of manually configuring a cell here
        
    YAContact* contact = [self contactAtIndexPath:indexPath];
    
    UITableViewCell* cell = [tableViewCellCreator_ createForTableView:tableView withStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    [[cell textLabel] setText:[contact compositeName]];

    return cell;
}


#pragma mark ContactRepositorySubscriber methods

- (void) contactRepositoryDidLoadContacts:(id<ContactRepository>)contactRepository
{
    if(contactsBySection_)
    {
        // only reload if we are already loaded; otherwise, we'll lazily pick up the new contacts next time we are loaded
        // (this prevents us from responding to NAB change notification when we have been unloaded due to memory pressure)
        [self reload];
    }
}


@end
