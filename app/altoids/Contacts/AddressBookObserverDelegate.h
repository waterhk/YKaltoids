//
//  AddressBookObserverDelegate.h
//  altoids
//
//  Created by Derrick Whittle on 2/9/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol AddressBookObserver;


// intended for use only by ContactRepository (see docs/design/ContactRepository.md)

@protocol AddressBookObserverDelegate <NSObject>

@required
- (void) addressBookObserverDidObserveChanges:(id<AddressBookObserver>)observer;

@end
