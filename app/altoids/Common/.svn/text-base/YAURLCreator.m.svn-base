//
//  YAURLCreator.m
//  altoids
//
//  Created by Jon Herron on 9/15/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//
//  http://twiki.corp.yahoo.com/view/Devel/AltoidsiOSClientURLAndURLRequestHandling
//

#import "YAURLCreator.h"

// Private class extension
@interface YAURLCreator ()

// @property definitions

// methods

@end

@implementation YAURLCreator

// Class methods
#pragma mark -
#pragma mark Class methods

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

- (id)init
{
  self = [super init];
  if (self) {
    // Initialization code here.
  }
  
  return self;
}

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark URLCreator delegate methods

- (NSURL *)createWithScheme:(NSString *)aScheme server:(NSString *)aServer relativeURI:(NSString *)aRelativeURI params:(NSDictionary *)aParams
{
    __block NSMutableString *paramString = [NSMutableString stringWithString:@"?"];
    
    [aParams enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
     {
         [paramString appendFormat:@"%@=%@&", key, obj];
     }];
    
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@://%@/%@%@", aScheme, aServer, aRelativeURI, [paramString substringToIndex:[paramString length] - 1]]];
}

- (NSURL *)createWithString:(NSString *)theURLString
{
    return [NSURL URLWithString:theURLString];
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
#pragma mark YAURLCreator ()

@end
