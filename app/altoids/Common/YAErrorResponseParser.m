//
//  YAErrorResponseParser.m
//  altoids
//
//  Created by Anand Subba Rao on 9/9/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAErrorResponseParser.h"

// Private class extension
@interface YAErrorResponseParser ()

// @property definitions

// methods

@end

@implementation YAErrorResponseParser

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
#pragma mark <ErrorParser>
- (NSError *)errorWithHTTPURLResponse:(id<HTTPURLResponse>)urlResponse jsonDict:(NSDictionary *)jsonDict
{
    if ([urlResponse statusCode] == YAHTTPStatusOk) {
        return nil;
    }
    
    NSArray *errors = [jsonDict valueForKey:@"errors"];
    
    NSEnumerator *errorEnumerator = [errors reverseObjectEnumerator];
    
    NSError *error = nil, *prevError = nil;
    NSDictionary *errorDict = nil;
    while (errorDict = [errorEnumerator nextObject]) {
        NSDictionary *userInfo = nil;
        
        if (prevError) {
            userInfo = [NSDictionary dictionaryWithObjectsAndKeys:prevError, NSUnderlyingErrorKey, nil];
        }
        error = [NSError errorWithDomain:[errorDict valueForKeyPath:@"error.ns"]
                                    code:[[errorDict valueForKeyPath:@"error.code"] intValue]
                                userInfo:userInfo];
        prevError = error;
    }

    return error;
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
#pragma mark YAErrorResponseParser ()

@end
