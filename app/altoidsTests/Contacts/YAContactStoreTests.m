//
//  YAContactStoreTests.m
//  altoids
//
//  Created by Derrick Whittle on 2/23/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YATestCase.h"
#import "YAContactStore.h"

@interface YAContactStoreTests : YATestCase
{
    YAContactStore* contactStore;
}
@end


@implementation YAContactStoreTests

- (void) setUp
{
    contactStore = [[YAContactStore alloc] init];
}


- (void) testSetContactsShouldSetStalenessFlagToNo
{
    [contactStore setStale:YES];
    [contactStore setContacts:[NSArray array]];
    STAssertFalse([contactStore stale], nil);

    [contactStore setStale:NO];
    [contactStore setContacts:[NSArray array]];
    STAssertFalse([contactStore stale], nil);
}

- (void) testSetContactsShouldSetContactsPropertyToGivenContacts
{
    NSArray* contacts = [NSArray array];
    
    [contactStore setContacts:contacts];
    STAssertEquals(contacts, [contactStore contacts], nil);
    
    NSArray* otherContacts = [NSMutableArray arrayWithCapacity:2];
    [contactStore setContacts:otherContacts];
    STAssertEquals(otherContacts, [contactStore contacts], nil);
}

@end
