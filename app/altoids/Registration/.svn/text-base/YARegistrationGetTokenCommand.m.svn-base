//
//  YARegistrationGetTokenCommand.m
//  altoids
//
//  Created by Lei Cai on 8/31/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YARegistrationGetTokenCommand.h"


@interface YARegistrationGetTokenCommand ()

@property (nonatomic, strong) id<Transport> transport;
@property (nonatomic, strong) id<RegistrationRequestBuilder> requestBuilderFactory;
@property (nonatomic, strong) id<RegistrationResponseParser> responseParserFactory;
@property (nonatomic, strong) id<RegistrationResponseHandler> responseHandler;
@property (nonatomic, strong) id context;

@property (nonatomic, copy) NSString *countryCode;
@property (nonatomic, copy) NSString *networkCode;
@property (nonatomic, copy) NSString *subscriberID;

@end

@implementation YARegistrationGetTokenCommand

@synthesize transport = transport_;
@synthesize requestBuilderFactory = requestBuilderFactory_;
@synthesize responseParserFactory = responseParserFactory_;
@synthesize responseHandler = responseHandler_;

@synthesize countryCode = countryCode_;
@synthesize networkCode = networkCode_;
@synthesize subscriberID = subscriberID_;
@synthesize context = context_;

- (id)initWithCountryCode:(NSString *)countryCode
              networkCode:(NSString *)networkCode
             subscriberID:(NSString *)subscriberID
                transport:(id<Transport>)transport
    requestBuilderFactory:(id<RegistrationRequestBuilder>)requestBuilderFactory
    responseParserFactory:(id<RegistrationResponseParser>)responseParserFactory
          responseHandler:(id<RegistrationResponseHandler>)responseHandler
                  context:(id)context
{
    self = [super init];
    if (self) {
        countryCode_ = [countryCode copy];
        networkCode_ = [networkCode copy];
        subscriberID_ = [subscriberID copy];
        
        transport_ = transport;
        requestBuilderFactory_ = requestBuilderFactory;
        responseParserFactory_ = responseParserFactory;
        responseHandler_ = responseHandler;
        context_ = context;
    }
    return self;
}


- (NSError*)execute {
    NSURLRequest *request = [[self requestBuilderFactory] buildGetTokenRequestWithMCC:self.countryCode andMNC:self.networkCode andMSID:self.subscriberID];
    NSError *error = nil;
    NSData *data = nil;
    id<HTTPURLResponse> urlResponse = nil;
    [[self transport] sendSynchronousRequest:request returningResponse:&urlResponse data:&data error:&error];
    [[self responseHandler] handleGetTokenResponse:[[self responseParserFactory] parseRegistrationGetTokenResponse:urlResponse data:data error:error]
                                           context:[self context]];
    
    return error;
}

@end
