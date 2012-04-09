//
//  YAAddressBookLoadCommandTests.m
//  altoids
//
//  Created by Derrick Whittle on 2/23/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <OCMock/OCMock.h>
#import "YAAddressBookLoadCommand.h"
#import "AddressBookLoadCommandDelegate.h"
#import "AddressBookLoader.h"
#import "Threader.h"

@interface YAAddressBookLoadCommandTests : SenTestCase
{
    YAAddressBookLoadCommand* loadCommand;
    id delegate;
    id loader;
    id mainThreader;
}
@end

@implementation YAAddressBookLoadCommandTests

- (void) setUp
{
    loader = [OCMockObject mockForProtocol:@protocol(AddressBookLoader)];
    mainThreader = [OCMockObject mockForProtocol:@protocol(Threader)];
    delegate = [OCMockObject mockForProtocol:@protocol(AddressBookLoadCommandDelegate)];
    
    loadCommand = [[YAAddressBookLoadCommand alloc] initWithDelegate:delegate];
    [loadCommand setAddressBookLoader:loader];
    [loadCommand setMainThreader:mainThreader];
}


- (void) testExecuteShouldLoadContactsFromNativeAddressBookAndUponSuccessNotifyDelegateOnMainThreadWithLoadedContacts
{
    id contacts = [OCMockObject mockForClass:[NSArray class]];  // use a mock instead of a real NSArray because NSArray plays tricks with pointers, making equality testing difficult

    [[[loader expect] andReturn:contacts] contactsFromAddressBook];
    [[mainThreader expect] performSelector:@selector(addressBookLoadCommand:didLoadContacts:) onTarget:delegate withObject:loadCommand andObject:contacts];

    [loadCommand execute];    
    [loader verify];
    [mainThreader verify];
}

- (void) testExecuteShouldLoadContactsFromNativeAddressBookAndUponFailureNotifyDelegateOnMainThread
{
    [[[loader expect] andReturn:nil] contactsFromAddressBook];
    [[mainThreader expect] performSelector:@selector(addressBookLoadCommandDidFail:) onTarget:delegate withObject:loadCommand];
    
    [loadCommand execute];    
    [loader verify];
    [mainThreader verify];
}


@end
