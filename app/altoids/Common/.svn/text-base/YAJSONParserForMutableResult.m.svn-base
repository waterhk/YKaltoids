//
//  YAJSONParserForMutableResult.m
//  altoids
//
//  Created by Jon Herron on 10/17/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAJSONParserForMutableResult.h"

// Private class extension
@interface YAJSONParserForMutableResult ()

// @property definitions

// methods

@end

@implementation YAJSONParserForMutableResult

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize sbJSONParser = sbJSONParser_;

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
#pragma mark JSONParserForMutableResult delegate methods

- (NSMutableDictionary *)parseJSONDataForMutableResult:(NSData *)theData
{
    return [[self sbJSONParser] objectWithData:theData];
}

- (NSMutableDictionary *)parseJSONStringForMutableResult:(NSString *)theString
{
    return [[self sbJSONParser] objectWithString:theString];
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
#pragma mark YAJSONParserForMutableResult ()

@end
