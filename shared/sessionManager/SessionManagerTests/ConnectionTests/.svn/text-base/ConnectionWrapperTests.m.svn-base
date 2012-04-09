//
//  ConnectionWrapperTests.m
//  SessionManager3
//
//  Created by Lei Cai on 8/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "ConnectionWrapperTests.h"

@implementation ConnectionWrapperTests

- (void)setUp
{
    connectionWrapperDelegateMock = [OCMockObject mockForProtocol:@protocol(ConnectionWrapperDelegate)];
    connectionWrapper = [[ConnectionWrapper alloc] init];
    // There is a problem with OCMock currently (not able to set to assign property)
    //connectionWrapper.delegate = connectionWrapperDelegateMock;
    connectionWrapper.delegate = self;
}

- (void)tearDown
{
}

- (void)testWithCorrectUrl
{
    NSURL *url;
    url = [NSURL URLWithString:@"http://www.yahoo.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [connectionWrapper executeWithRequest:request];
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    
    //the succeed delegate should be called
}

- (void)testWithErrorUrl
{
    NSURL *url;
    url = [NSURL URLWithString:@"http://abc.def.ghi"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [connectionWrapper executeWithRequest:request];
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    
    //the fail delegate should be called
}


- (void)connectionWrapper:(id<ConnectionWrapperProtocol>)aConnectionWrapper didSucceedWithData:(NSData*)aData andURLResponse:(NSURLResponse*)aResponse
{
    NSLog(@"succeed case is called!");
}
- (void)connectionWrapper:(id<ConnectionWrapperProtocol>)aConnectionWrapper didFailWithData:(NSError*)aError andURLResponse:(NSURLResponse*)aResponse
{
    NSLog(@"fail case is called!");
}

@end
