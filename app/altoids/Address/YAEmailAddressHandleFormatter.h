//
//  YAEmailAddressHandleFormatter.h
//  altoids
//
//  Created by Jon Herron on 11/2/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddressHandleFormatter.h"
@protocol AddressHandler;

@interface YAEmailAddressHandleFormatter : NSObject <AddressHandleFormatter>

@property (nonatomic, strong) id<AddressHandler> addressHandler;

@end
