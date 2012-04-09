//
//  YAURLRequestPostJSONPayloadHeadersBuilder.m
//  altoids
//
//  Created by Jon Herron on 10/10/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAURLRequestJSONPayloadHeadersBuilder.h"

#define kConversationCreateContentLengthKey @"Content-Length"
#define kConversationCreateContentTypeKey @"Content-Type"
#define kConversationCreateContentType @"application/json;charset=utf-8"

// Private class extension
@interface YAURLRequestJSONPayloadHeadersBuilder ()

// @property definitions

// methods

@end

@implementation YAURLRequestJSONPayloadHeadersBuilder

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
#pragma mark URLRequestPostJSONPayloadHeadersBuilder delegate methods

- (NSMutableURLRequest *)buildRequestHeadersForURLRequest:(NSMutableURLRequest *)aURLRequest
{
    NSString *contentLength = nil;
    
    aURLRequest = [[self urlRequestStandardHeadersBuilder] buildRequestHeadersForURLRequest:aURLRequest];
    
    contentLength = [NSString stringWithFormat:@"%d", [[aURLRequest HTTPBody] length]];
    
    [aURLRequest setValue:kConversationCreateContentType forHTTPHeaderField:kConversationCreateContentTypeKey];
    [aURLRequest setValue:contentLength forHTTPHeaderField:kConversationCreateContentLengthKey];
    
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
#pragma mark YAURLRequestPostJSONPayloadHeadersBuilder ()

@end
