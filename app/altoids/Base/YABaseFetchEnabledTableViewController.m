//
//  YABaseFetchEnabledTableViewController.m
//  altoids
//
//  Created by Srinivas Raovasudeva on 9/13/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YABaseFetchEnabledTableViewController.h"
#import "YAManagedObjectContextFactory.h"
#import "YAPersistentStoreURLGenerator.h"

// Private class extension
@interface YABaseFetchEnabledTableViewController ()

// @property definitions
@property (strong, nonatomic, readwrite) id<FetchedResultsControllerFactory> fetchedResultsControllerFactory;
@property (strong, nonatomic, readwrite) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic, readwrite) UITableView *tableView;

@property (strong, nonatomic) id<ManagedObjectContextFactory> managedObjectContextFactory;
// methods

@end

@implementation YABaseFetchEnabledTableViewController

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize fetchedResultsControllerFactory=fetchedResultsControllerFactory_;
@synthesize fetchedResultsController=fetchedResultsController_;
@synthesize context=context_;
@synthesize tableView=tableView_;
@synthesize updateMode=updateMode_;
@synthesize maxInsertedRowIndexPath=maxInsertedRowIndexPath_;
@synthesize managedObjectContextFactory=managedObjectContextFactory_;

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

- (id)initWithFetchedResultsControllerFactory:(id<FetchedResultsControllerFactory>)aFetchedResultsControllerFactory 
                  managedObjectContextFactory:(id<ManagedObjectContextFactory>)theManagedObjectContextFactory
                                      nibName:(NSString *)nibNameOrNil 
                                       bundle:(NSBundle *)nibBundleOrNil;
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        fetchedResultsControllerFactory_ =aFetchedResultsControllerFactory;
        managedObjectContextFactory_ = theManagedObjectContextFactory;
        updateMode_ = UpdateAll;
    }
    
    return self;
}

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

#pragma mark -
#pragma mark Memory warning

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(managedObjectContextDidSave:) 
                                                 name:NSManagedObjectContextDidSaveNotification 
                                               object:nil];
    
    NSError *error = nil;
    [[self fetchedResultsController] performFetch:&error];
    
    NSAssert(!error, @"Error occurred during performFetch: %@", [error localizedFailureReason]);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:NSManagedObjectContextDidSaveNotification
                                                  object:nil];
    
    context_ = NULL;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [[[self fetchedResultsController] sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [(id<NSFetchedResultsSectionInfo>)[[[self fetchedResultsController] sections] objectAtIndex:section] numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [[self tableView] dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

#pragma mark -
#pragma mark NSFetchedResultsControllerDelegate methods

#pragma mark -
#pragma mark NSFetchedResultsControllerDelegate methods
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
 //   [[self tableView] beginUpdates];
 //   [self setMaxInsertedRowIndexPath:nil];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
        
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
        {
            [[self tableView] insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];

            if (![self maxInsertedRowIndexPath]) {
                [self setMaxInsertedRowIndexPath:newIndexPath];
            }
            else if ([self maxInsertedRowIndexPath] &&
                ([newIndexPath compare:[self maxInsertedRowIndexPath]]==NSOrderedDescending)) {
                [self setMaxInsertedRowIndexPath:newIndexPath];
            }
            
            break;
        }
            
        case NSFetchedResultsChangeDelete:
        {
            [[self tableView] deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        case NSFetchedResultsChangeUpdate:
        {       
            if ([self updateMode]!=IgnoreUpdates) {
                [self configureCell:[[self tableView] cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            }
            break;
        }   
        case NSFetchedResultsChangeMove:
        {
            [[self tableView] deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            [[self tableView] insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
        }
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
 
    [[self tableView] endUpdates];
    
    if ([self maxInsertedRowIndexPath]) {
        [[self tableView] scrollToRowAtIndexPath:[self maxInsertedRowIndexPath] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        [self setMaxInsertedRowIndexPath:nil];
    }
     
}

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark Delegate methods

- (UIViewController *)viewController
{
    return self;
}

// Public methods
#pragma mark -
#pragma mark Public methods

// Protected methods
#pragma mark -
#pragma mark Protected methods
- (NSFetchedResultsController *)fetchedResultsController
{
    return nil;
}

- (NSManagedObjectContext *)context
{
    if (!context_)
    {
        context_ = [[self managedObjectContextFactory] createWithStalenessInterval:0];
    }
    
    return context_;
}

- (void)managedObjectContextDidSave:(NSNotification*)aNotification
{
    if ([aNotification object] == [self context]) return;
    
    if (![NSThread isMainThread]) {
        [self performSelectorOnMainThread:@selector(managedObjectContextDidSave:) withObject:aNotification waitUntilDone:YES];
        return;
    }
    
    [[self context] mergeChangesFromContextDidSaveNotification:aNotification];
    
    [[self tableView] reloadData];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    [self doesNotRecognizeSelector:@selector(configureCell:atIndexPath:)];
}

- (UITableView *)tableView
{
    return nil;
}

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods
#pragma mark -
#pragma mark YABaseFetchEnabledTableViewController ()

@end
