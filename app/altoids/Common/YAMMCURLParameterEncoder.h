//
//  YAMMCURLParameterEncoder.h
//  altoids
//
//  Created by Jon Herron on 10/13/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMCURLParameterEncoder.h"
#import "URLParameterEncoder.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAMMCURLParameterEncoder : NSObject <MMCURLParameterEncoder>

#pragma mark @property declarations
@property (strong, nonatomic) id<URLParameterEncoder> urlParameterEncoder;

#pragma mark  Class methods

#pragma mark Instance methods

@end
