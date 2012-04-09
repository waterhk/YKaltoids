//
//  YARegistrationInfoCommandCreator.m
//  altoids
//
//  Created by Jon Herron on 1/27/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YARegistrationInfoCommandCreator.h"
#import "AppFactory.h"
#import "RegistrationInfoParsedJSONResponseHandler.h"
#import "CommandErrorHandlerCreator.h"
#import "RegistrationInfoErrorHandler.h"
#import "RegistrationInfoRequestDataBuilder.h"
#import "RegistrationInfoURLRequestBuilderCreator.h"
#import "Command.h"

@implementation YARegistrationInfoCommandCreator

@synthesize mmcCommandInstanceFactory = mmcCommandInstanceFactory_;
@synthesize jsonParser = jsonParser_;
@synthesize commandErrorHandlerCreator = commandErrorHandlerCreator_;
@synthesize registrationInfoErrorHandler = registrationInfoErrorHandler_;
@synthesize registrationInfoParsedJSONResponseHandlerInstanceFactory = registrationInfoParsedJSONResponseHandlerInstanceFactory_;
@synthesize registrationInfoRequestDataBuilder = registrationInfoRequestDataBuilder_;
@synthesize registrationInfoURLRequestBuilderCreator = registrationInfoURLRequestBuilderCreator_;
@synthesize urlRequestParameters = urlRequestParameters_;


- (id<Command>)createWithAddress:(YAAddressInfo *)address delegate:(id<RegistrationInfoCommandDelegate>)delegate
{
    id<RegistrationInfoParsedJSONResponseHandler> parsedJSONResponseHandler;
    
    parsedJSONResponseHandler = [[self registrationInfoParsedJSONResponseHandlerInstanceFactory] createRegistrationInfoParsedJSONResponseHandlerWithDelegate:delegate];
    
    NSDictionary *requestData = [[self registrationInfoRequestDataBuilder] requestDataForAddress:address];
    
    id<URLRequestBuilder> urlRequestBuilder = [[self registrationInfoURLRequestBuilderCreator] createRegistrationInfoCreateURLRequestBuilder];
    
    id<CommandErrorHandler> errorHandler = [[self commandErrorHandlerCreator] createWithErrorHandler:[self registrationInfoErrorHandler]];

    return [mmcCommandInstanceFactory_ createMMCCommandWithURLRequestBuilder:urlRequestBuilder
                                                        urlRequestParameters:urlRequestParameters_
                                                              urlRequestData:requestData
                                                                  jsonParser:jsonParser_
                                                   parsedJSONResponseHandler:parsedJSONResponseHandler
                                                         commandErrorHandler:errorHandler];
}

@end
