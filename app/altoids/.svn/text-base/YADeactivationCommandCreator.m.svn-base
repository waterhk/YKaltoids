//
//  YADeactivationCommandCreator.m
//  altoids
//
//  Created by Venkatraman Sridharan on 3/27/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YADeactivationCommandCreator.h"
#import "AppFactory.h"
#import "DeactivationInfoParsedJSONResponseHandler.h"
#import "CommandErrorHandlerCreator.h"
#import "DeactivationInfoErrorHandler.h"
#import "DeactivationInfoURLRequestBuilderCreator.h"
#import "Command.h"
#import "MMCURLParametersCreator.h"
#import "TransactionCommand.h"
#import "TransactionCommandDelegate.h"

@implementation YADeactivationCommandCreator

@synthesize mmcCommandInstanceFactory = mmcCommandInstanceFactory_;
@synthesize jsonParser = jsonParser_;
@synthesize commandErrorHandlerCreator = commandErrorHandlerCreator_;
@synthesize deactivationInfoErrorHandler = deactivationInfoErrorHandler_;
@synthesize deactivationInfoParsedJSONResponseHandler = deactivationInfoParsedJSONResponseHandler_;
@synthesize deactivationInfoURLRequestBuilderCreator = deactivationInfoURLRequestBuilderCreator_;
@synthesize mmcURLParametersCreator = mmcURLParametersCreator_;
@synthesize transactionCommandInstanceFactory = transactionCommandInstanceFactory_;



- (id<TransactionCommand>)createCommandForDeactivationWithTransactionDelegate:(id<TransactionCommandDelegate>)transactionDelegate
{            
    id<URLRequestBuilder> urlRequestBuilder = [[self deactivationInfoURLRequestBuilderCreator] createRegistrationInfoCreateURLRequestBuilder]; 
    
    id<CommandErrorHandler> errorHandler = [[self commandErrorHandlerCreator] createWithErrorHandler:[self deactivationInfoErrorHandler]];
    
    NSDictionary *requestParameters = [[self mmcURLParametersCreator] urlParametersForDeactivation];

    
    id<Command> command = [mmcCommandInstanceFactory_ createMMCCommandWithURLRequestBuilder:urlRequestBuilder
                                                        urlRequestParameters:requestParameters
                                                              urlRequestData:nil
                                                                  jsonParser:jsonParser_
                                                   parsedJSONResponseHandler:deactivationInfoParsedJSONResponseHandler_
                                                         commandErrorHandler:errorHandler];
    return [transactionCommandInstanceFactory_ createTransactionCommandWithCommand:command delegate:transactionDelegate];

    
}



@end
