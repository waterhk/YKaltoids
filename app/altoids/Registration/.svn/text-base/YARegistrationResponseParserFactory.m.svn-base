//
//  YARegistrationResponseParserFactory.m
//  altoids
//
//  Created by Lei Cai on 9/1/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YARegistrationResponseParserFactory.h"
#import <SBJson/SBJson.h>
#import "YARegistrationGetTokenResponse.h"
#import "YARegistrationVerifyTokenResponse.h"
#import "YARegistrationRenewResponse.h"

// Private class extension
@interface YARegistrationResponseParserFactory ()

// methods

@end

@implementation YARegistrationResponseParserFactory
static NSString* const kRegistrationErrorDomain = @"RegistrationErrorDomain";
// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize errorResponseParser = errorResponseParser_;

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// Overrides
#pragma mark -
#pragma mark Overrides
- (id)parseRegistrationGetTokenResponse:(id<HTTPURLResponse>)response data:(NSData *)data error:(NSError *)error
{
    YARegistrationGetTokenResponse *getTokenResponse = [[YARegistrationGetTokenResponse alloc] init];
    if (error) {
        getTokenResponse.error = error;
        return getTokenResponse;
    }
    
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *jsonResults = [parser objectWithData:data];

    NSError *appError = [[self errorResponseParser] errorWithHTTPURLResponse:response jsonDict:jsonResults];
    
    if (appError) {
        getTokenResponse.error = appError;
        return getTokenResponse;
    }
    
    NSString *bindToken = [jsonResults valueForKeyPath:@"bindToken"];
    NSString *shortCode = [jsonResults valueForKeyPath:@"shortCode"];
    
    getTokenResponse.bindToken = bindToken;
    getTokenResponse.shortCode = shortCode;
    
    return getTokenResponse;
}

- (id)parseRegistrationVerifyResponse:(id<HTTPURLResponse>)response data:(NSData *)data error:(NSError *)error
{
    YARegistrationVerifyTokenResponse *verifyTokenResponse = [[YARegistrationVerifyTokenResponse alloc] init];
    
    if (error) {
        verifyTokenResponse.error = error;
        return verifyTokenResponse;
    }
    
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *jsonResults = [parser objectWithData:data];

    NSError *appError = [[self errorResponseParser] errorWithHTTPURLResponse:response jsonDict:jsonResults];
    if (appError) {
        verifyTokenResponse.error = appError;
        return verifyTokenResponse;
    }
    
    NSNumber *statusCode = [jsonResults valueForKey:@"statusCode"];
    if ([statusCode intValue]!=0) {
        verifyTokenResponse.error = [NSError errorWithDomain:@"mws" code:[statusCode intValue] userInfo:nil];
        return verifyTokenResponse;
    }
    
    NSString *number = [jsonResults valueForKeyPath:@"number"];
    NSInteger remainingTime = [[jsonResults valueForKeyPath:@"remainingTime"] intValue];
    
    verifyTokenResponse.number = number;
    verifyTokenResponse.remainingTime = remainingTime;
    
    return verifyTokenResponse;
}

- (id)parseRegistrationRenewResponse:(NSData *)response error:(NSError *)error
{
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    YARegistrationRenewResponse *renewResponse = [[YARegistrationRenewResponse alloc] init];
    NSDictionary *jsonResults = [parser objectWithData:response];
    renewResponse.body = jsonResults;
    if (error) // we will not bother SBJson if there are network errors
    {
        renewResponse.error = error;
        return renewResponse;
    }
    
    NSString *status = [jsonResults valueForKeyPath:@"status"];
    NSInteger statusCode = [[jsonResults valueForKeyPath:@"statusCode"] intValue];
    NSInteger remainingTime = [[jsonResults valueForKeyPath:@"remainingTime"] intValue];
    if (![status isEqualToString:@"OK"])
    {
        renewResponse.error = [NSError errorWithDomain:kRegistrationErrorDomain
                                                        code:statusCode
                                                    userInfo:nil]; // Todo : userInfo may need to generate here
        return renewResponse;
    }
    
    renewResponse.statusCode = statusCode;
    renewResponse.remainingTime = remainingTime;
    
    return renewResponse;
}

// Delegate methods
#pragma mark -
#pragma mark <Protocol Name> delegate methods

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
#pragma mark YARegistrationResponseParserFactory ()

@end
