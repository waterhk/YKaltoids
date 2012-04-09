//
//  ConnectionWrapper.m
//  SessionManager3
//
//  Created by Lei Cai on 8/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "YSMConnectionWrapper.h"

@implementation YSMConnectionWrapper

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)executeWithRequest:(NSURLRequest *)aRequest
{
    [self disposeCurrentRequest];
    self.connection = [NSURLConnection connectionWithRequest:aRequest delegate:self];
}

- (void)disposeCurrentRequest
{
    [self.connection cancel];
    self.connection = nil;
    self.data = nil;
    self.response = nil;
}

#pragma mark -
#pragma mark NSURLConnectionDataDelegate

- (void)connection:(NSURLConnection *)inConnection didReceiveResponse:(NSURLResponse *)inResponse {
    response_ = inResponse;
}

- (void)connection:(NSURLConnection *)inConnection didReceiveData:(NSData *)inData {
	if (inConnection == self.connection) {
		if (!self.data) {
			self.data = [[NSMutableData alloc] init];
		}
		[self.data appendData:inData];
	}
}

- (void)connectionDidFinishLoading:(NSURLConnection *)inConnection {
	if (inConnection == self.connection) {
        [self.delegate connectionWrapper:self didSucceedWithData:self.data andURLResponse:self.response];
	}
}

- (void)connection:(NSURLConnection *)inConnection didFailWithError:(NSError *)inError {
	if (inConnection == self.connection) {
        [self.delegate connectionWrapper:self didFailWithData:inError andURLResponse:self.response];
	}
}

@synthesize delegate = delegate_;
@synthesize connection = connection_;
@synthesize data = data_;
@synthesize response = response_;
@end
