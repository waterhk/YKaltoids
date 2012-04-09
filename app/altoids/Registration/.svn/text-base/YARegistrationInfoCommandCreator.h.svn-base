//
//  YARegistrationInfoCommandCreator.h
//  altoids
//
//  Created by Jon Herron on 1/27/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "RegistrationInfoCommandCreator.h"
@protocol MMCCommandInstanceFactory, JSONParser, CommandErrorHandlerCreator, RegistrationInfoErrorHandler, RegistrationInfoParsedJSONResponseHandlerInstanceFactory, RegistrationInfoRequestDataBuilder, RegistrationInfoURLRequestBuilderCreator;

@interface YARegistrationInfoCommandCreator : NSObject <RegistrationInfoCommandCreator>

@property (strong, nonatomic) id<MMCCommandInstanceFactory> mmcCommandInstanceFactory;
@property (strong, nonatomic) id<JSONParser> jsonParser;
@property (strong, nonatomic) id<CommandErrorHandlerCreator> commandErrorHandlerCreator;
@property (strong, nonatomic) id<RegistrationInfoErrorHandler> registrationInfoErrorHandler;
@property (strong, nonatomic) id<RegistrationInfoParsedJSONResponseHandlerInstanceFactory> registrationInfoParsedJSONResponseHandlerInstanceFactory;
@property (strong, nonatomic) id<RegistrationInfoRequestDataBuilder> registrationInfoRequestDataBuilder;
@property (strong, nonatomic) id<RegistrationInfoURLRequestBuilderCreator> registrationInfoURLRequestBuilderCreator;

@property (strong, nonatomic) NSDictionary *urlRequestParameters;

@end
