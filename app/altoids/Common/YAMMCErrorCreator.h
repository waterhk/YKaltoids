//
//  YAMMCErrorCreator.h
//  altoids
//
//  Created by Jon Herron on 11/14/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMCErrorCreator.h"
#import "ErrorCreator.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAMMCErrorCreator : NSObject <MMCErrorCreator>

#pragma mark @property declarations
@property (strong, nonatomic) id<ErrorCreator> errorCreator;

#pragma mark  Class methods

#pragma mark Instance methods

@end
