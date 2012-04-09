//
//  YAAddressBookLoadCommand.h
//  altoids
//
//  Created by Derrick Whittle on 2/10/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddressBookLoadCommand.h"
@protocol AddressBookLoadCommandDelegate, AddressBookLoader, Threader;


@interface YAAddressBookLoadCommand : NSObject <AddressBookLoadCommand>

@property (nonatomic, strong) id<AddressBookLoader> addressBookLoader;
@property (nonatomic, strong) id<Threader> mainThreader;
@property (nonatomic, strong) id<AddressBookLoadCommandDelegate> delegate;

- (id) initWithDelegate:(id<AddressBookLoadCommandDelegate>)delegate;

@end
