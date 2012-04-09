//
//  YAAddressBookObserver.m
//  altoids
//
//  Created by Derrick Whittle on 2/9/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAAddressBookObserver.h"
#import "AddressBookObserverDelegate.h"
#import "AddressBook/ABAddressBook.h"


void addressBookCallback(ABAddressBookRef addressBook, CFDictionaryRef info, void *context);

@interface YAAddressBookObserver()
@property (nonatomic, assign) ABAddressBookRef addressBook;
- (void) unregisterForNotifications;
@end


@implementation YAAddressBookObserver

@synthesize delegate = delegate_;
@synthesize addressBook = addressBook_;


- (void) dealloc
{
    [self clearDelegate:[self delegate]];
}

- (void) clearDelegate:(id)delegate
{
    [self unregisterForNotifications];

    if([self delegate] == delegate)
    {
        [self setDelegate:nil];
    }
}

- (void) unregisterForNotifications
{
    if(addressBook_)
    {
        ABAddressBookUnregisterExternalChangeCallback(addressBook_, addressBookCallback, (__bridge void*)self);
        
        CFRelease(addressBook_);
        addressBook_ = nil;
    }
}

- (void) observeAddressBookForDelegate:(id<AddressBookObserverDelegate>)delegate
{
    if([self delegate] == delegate)
    {
        return;
    }
    
    [self unregisterForNotifications];
    [self setDelegate:delegate];

    addressBook_ = ABAddressBookCreate();
    ABAddressBookRegisterExternalChangeCallback(addressBook_, addressBookCallback, (__bridge void*)self);
}

void addressBookCallback(ABAddressBookRef addressBook, CFDictionaryRef info, void *context)
{
    YAAddressBookObserver* observer = (__bridge YAAddressBookObserver*)context;
    [[observer delegate] addressBookObserverDidObserveChanges:observer];
}

@end
