//
//  YAMessageErrorCreator.h
//  altoids
//
//  Created by Jon Herron on 11/15/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageErrorCreator.h"
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
@interface YAMessageErrorCreator : NSObject <MessageErrorCreator>

#pragma mark @property declarations
@property (strong, nonatomic) id<ErrorCreator> errorCreator;

#pragma mark  Class methods

#pragma mark Instance methods

@end
