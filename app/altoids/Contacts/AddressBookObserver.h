//
//  AddressBookObserver.h
//  altoids
//
//  Created by Derrick Whittle on 2/9/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Delegater.h"
@protocol AddressBookObserverDelegate;


// intended for use only by ContactRepository (see docs/design/ContactRepository.md)

@protocol AddressBookObserver <NSObject, Delegater>

- (void) observeAddressBookForDelegate:(id<AddressBookObserverDelegate>)delegate;

@end
