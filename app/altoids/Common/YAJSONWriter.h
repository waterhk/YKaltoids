//
//  YAJSONWriter.h
//  altoids
//
//  Created by Jon Herron on 10/4/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SBJson/SBJson.h>
#import "JSONWriter.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAJSONWriter : NSObject <JSONWriter>

#pragma mark @property declarations
@property (strong, nonatomic, setter=setSBJSONWriter:) SBJsonWriter *sbJSONWriter;

#pragma mark  Class methods

#pragma mark Instance methods

@end
