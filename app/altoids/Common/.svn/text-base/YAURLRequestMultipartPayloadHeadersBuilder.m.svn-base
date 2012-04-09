//
//  YAURLRequestMultipartPayloadHeadersBuilder.m
//  altoids
//
//  Created by Anand Biligiri on 12/17/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAURLRequestMultipartPayloadHeadersBuilder.h"

// Private class extension
@interface YAURLRequestMultipartPayloadHeadersBuilder ()

// @property definitions
// methods

@end

@implementation YAURLRequestMultipartPayloadHeadersBuilder

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize urlRequestStandardHeadersBuilder = urlRequestStandardHeadersBuilder_;

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
#pragma mark URLRequestMultipartPayloadHeadersBuilder methods
- (NSMutableURLRequest *)buildRequestHeadersForURLRequest:(NSMutableURLRequest *)aURLRequest
{
    NSString *contentLength = nil;
    
    aURLRequest = [[self urlRequestStandardHeadersBuilder] buildRequestHeadersForURLRequest:aURLRequest];
    
    contentLength = [NSString stringWithFormat:@"%d", [[aURLRequest HTTPBody] length]];
    
    [aURLRequest setValue:@"multipart/form-data, boundary=e02449e6f1f9" forHTTPHeaderField:@"Content-Type"];
    [aURLRequest setValue:contentLength forHTTPHeaderField:@"Content-Length"];
    
    return aURLRequest;
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
#pragma mark YAURLRequestMultipartPayloadHeadersBuilder ()

@end
