//
//  YAAddressBookLoadCommand.m
//  altoids
//
//  Created by Derrick Whittle on 2/10/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAAddressBookLoadCommand.h"
#import "AddressBookLoadCommandDelegate.h"
#import "AddressBookLoader.h"
#import "Threader.h"

@implementation YAAddressBookLoadCommand

@synthesize addressBookLoader = addressBookLoader_,
            mainThreader = mainThreader_,
            delegate = delegate_;


- (id) initWithDelegate:(id<AddressBookLoadCommandDelegate>)delegate
{
    self = [super init];
    if(self)
    {
        delegate_ = delegate;
    }
    return self;
}

- (NSError*) execute
{
    NSArray* contacts = [addressBookLoader_ contactsFromAddressBook];

    if(contacts)
    {
        [mainThreader_ performSelector:@selector(addressBookLoadCommand:didLoadContacts:) onTarget:delegate_ withObject:self andObject:contacts];
    }
    else
    {
        [mainThreader_ performSelector:@selector(addressBookLoadCommandDidFail:) onTarget:delegate_ withObject:self];
    }
    
    return nil;
}

@end
