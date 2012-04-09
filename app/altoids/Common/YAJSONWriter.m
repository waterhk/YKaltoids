//
//  YAJSONWriter.m
//  altoids
//
//  Created by Jon Herron on 10/4/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAJSONWriter.h"

// Private class extension
@interface YAJSONWriter ()

// @property definitions

// methods

@end

@implementation YAJSONWriter

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize sbJSONWriter = sbJSONWriter_;

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark JSONWriter delegate methods

- (NSData *)dataFromDictionary:(NSDictionary *)theDictionary
{
    return [[self sbJSONWriter] dataWithObject:theDictionary];
}

// Public methods
#pragma mark -
#pragma mark Public methods

// Protected methods
#pragma mark -
#pragma mark Protected methods

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods
#pragma mark -
#pragma mark YAJSONWriter ()

@end
