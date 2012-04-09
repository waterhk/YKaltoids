//
//  YAJSONParser.h
//  altoids
//
//  Created by Jon Herron on 9/16/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SBJson/SBJson.h>
#import "JSONParser.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAJSONParser : NSObject <JSONParser>

#pragma mark @property declarations
@property (strong, nonatomic, setter=setSBJSONParser:) SBJsonParser *sbJSONParser;

#pragma mark  Class methods

#pragma mark Instance methods

@end
