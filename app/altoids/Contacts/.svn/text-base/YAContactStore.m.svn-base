//
//  YAContactStore.m
//  altoids
//
//  Created by Derrick Whittle on 2/10/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAContactStore.h"
#import "YAContact.h"

@implementation YAContactStore

@synthesize contacts = contacts_,
            contactsByRecordID = contactsByRecordID_,
            stale = stale_;


- (void) setContacts:(NSArray*)contacts
{
    contacts_ = contacts;

    // performance note: this contactsByRecordID map is currently only used by YAContactDetailTableViewDataSource;
    // if building the map becomes expensive for large address books, we can move it into the data source (or build it only on demand)
    NSMutableDictionary* contactsByRecordID = [NSMutableDictionary dictionaryWithCapacity:[contacts count]];
    for(YAContact* contact in contacts)
    {
        [contactsByRecordID setObject:contact forKey:[contact recordID]];
    }
    contactsByRecordID_ = contactsByRecordID;

    stale_ = NO;
}

- (BOOL) empty
{
    return contacts_ == nil;
}


@end
