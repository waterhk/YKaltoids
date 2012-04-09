//
//  RegistrationInfoCommandCreator.h
//  altoids
//
//  Created by Jon Herron on 1/27/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Command.h"
#import "RegistrationInfoCommandDelegate.h"

@class YAAddressInfo;

@protocol RegistrationInfoCommandCreator <NSObject>

- (id<Command>)createWithAddress:(YAAddressInfo *)address delegate:(id<RegistrationInfoCommandDelegate>)delegate;

@end
