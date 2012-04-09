//
//  YARegistrationVerifyTokenCommand.m
//  altoids
//
//  Created by Lei Cai on 8/31/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YARegistrationVerifyTokenCommand.h"
#import "RegistrationRequestBuilder.h"

@interface YARegistrationVerifyTokenCommand ()

@property (nonatomic, strong) id<Transport> transport;
@property (nonatomic, strong) id<RegistrationRequestBuilder> requestBuilderFactory;
@property (nonatomic, strong) id<RegistrationResponseParser> responseParserFactory;
@property (nonatomic, strong) id<RegistrationResponseHandler> responseHandler;
@property (nonatomic, strong) id context;
@property (nonatomic, copy) NSString *bindToken;

@end

@implementation YARegistrationVerifyTokenCommand

@synthesize transport = transport_;
@synthesize requestBuilderFactory = requestBuilderFactory_;
@synthesize responseParserFactory = responseParserFactory_;
@synthesize responseHandler = responseHandler_;

@synthesize bindToken = bindToken_;
@synthesize context = context_;

- (id)initWithToken:(NSString *)bindToken
          transport:(id<Transport>)transport
requestBuilderFactory:(id<RegistrationRequestBuilder>)requestBuilderFactory
responseParserFactory:(id<RegistrationResponseParser>)responseParserFactory
    responseHandler:(id<RegistrationResponseHandler>)responseHandler
            context:(id)context
{
    self = [super init];
    if (self) {
        bindToken_ = [bindToken copy];
        
        transport_ = transport;
        requestBuilderFactory_ = requestBuilderFactory;
        responseParserFactory_ = responseParserFactory;
        responseHandler_ = responseHandler;
        context_ = context;
    }
    return self;
}

- (NSError*)execute {
    NSURLRequest *request = [[self requestBuilderFactory] buildVerifyTokenRequestWithBindToken:self.bindToken];
    NSError *error = nil;
    NSData *data = nil;
    id<HTTPURLResponse> urlResponse = nil;
    [[self transport] sendSynchronousRequest:request returningResponse:&urlResponse data:&data error:&error];
    [[self responseHandler] handleVerifyTokenResponse:[[self responseParserFactory] parseRegistrationVerifyResponse:urlResponse data:data error:error]
                                              context:[self context]];

    return error;
}

@end
