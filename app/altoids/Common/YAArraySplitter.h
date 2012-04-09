//
//  YAArraySplitter.h
//  altoids
//
//  Created by Jon Herron on 12/1/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArraySplitter.h"
#import "MutableArrayCreator.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAArraySplitter : NSObject <ArraySplitter>

#pragma mark @property declarations
@property (strong, nonatomic) id<MutableArrayCreator> mutableArrayCreator;

#pragma mark  Class methods

#pragma mark Instance methods

@end
