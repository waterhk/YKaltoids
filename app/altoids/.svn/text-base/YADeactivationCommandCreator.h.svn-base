//
//  YADeactivationCommandCreator.h
//  altoids
//
//  Created by Venkatraman Sridharan on 3/27/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeactivationCommandCreator.h"

@protocol MMCCommandInstanceFactory, JSONParser, CommandErrorHandlerCreator, DeactivationInfoErrorHandler, DeactivationInfoParsedJSONResponseHandler, DeactivationInfoRequestDataBuilder, DeactivationInfoURLRequestBuilderCreator, MMCURLParametersCreator, TransactionCommandInstanceFactory;

@interface YADeactivationCommandCreator : NSObject <DeactivationCommandCreator>

@property (strong, nonatomic) id<MMCCommandInstanceFactory> mmcCommandInstanceFactory;
@property (strong, nonatomic) id<JSONParser> jsonParser;
@property (strong, nonatomic) id<CommandErrorHandlerCreator> commandErrorHandlerCreator;
@property (strong, nonatomic) id<DeactivationInfoErrorHandler> deactivationInfoErrorHandler;
@property (strong, nonatomic) id<DeactivationInfoParsedJSONResponseHandler> deactivationInfoParsedJSONResponseHandler;
@property (strong, nonatomic) id<DeactivationInfoURLRequestBuilderCreator> deactivationInfoURLRequestBuilderCreator;
@property (nonatomic, strong) id<MMCURLParametersCreator> mmcURLParametersCreator;
@property (nonatomic, strong) id<TransactionCommandInstanceFactory> transactionCommandInstanceFactory;


@end
