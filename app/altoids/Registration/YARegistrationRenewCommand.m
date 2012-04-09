//
//  YARegistrationRenewCommand.m
//  altoids
//
//  Created by Lei Cai on 8/31/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YARegistrationRenewCommand.h"
#import "RegistrationRequestBuilder.h"

@interface YARegistrationRenewCommand ()

@property (nonatomic, strong) id<Transport> transport;
@property (nonatomic, strong) id<RegistrationRequestBuilder> requestBuilderFactory;
@property (nonatomic, strong) id<RegistrationResponseParser> responseParserFactory;
@property (nonatomic, strong) id<RegistrationResponseHandler> responseHandler;
@property (nonatomic, strong) id context;
@property (nonatomic, copy) NSString *phoneNumber;

@end

@implementation YARegistrationRenewCommand

@synthesize transport = transport_;
@synthesize requestBuilderFactory = requestBuilderFactory_;
@synthesize responseParserFactory = responseParserFactory_;
@synthesize responseHandler = responseHandler_;
@synthesize context = context_;

@synthesize phoneNumber = phoneNumber_;

- (id)initWithPhoneNumber:(NSString *)phoneNumber
                transport:(id<Transport>)transport
    requestBuilderFactory:(id<RegistrationRequestBuilder>)requestBuilderFactory
    responseParserFactory:(id<RegistrationResponseParser>)responseParserFactory
          responseHandler:(id<RegistrationResponseHandler>)responseHandler
                  context:(id)context
{
    self = [super init];
    if (self) {
        phoneNumber_ = [phoneNumber copy];
        
        transport_ = transport;
        requestBuilderFactory_ = requestBuilderFactory;
        responseParserFactory_ = responseParserFactory;
        responseHandler_ = responseHandler;
        context_ = context;
    }
    return self;
}

- (NSError*)execute {
    NSURLRequest *request = [[self requestBuilderFactory] buildRenewRequestWithNumber:self.phoneNumber];
    NSError *error = nil;
    NSData *data = nil;
    id<HTTPURLResponse> urlResponse = nil;
    [[self transport] sendSynchronousRequest:request returningResponse:&urlResponse data:&data error:&error];
    [[self responseHandler] handleRenewResponse:[[self responseParserFactory] parseRegistrationRenewResponse:data error:error]
                                        context:[self context]];
    return error;
}

@end
