//
//  YAMMCCommand.h
//  altoids
//
//  Created by Jon Herron on 9/16/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//
//  http://twiki.corp.yahoo.com/view/Devel/AltoidsiOSClientGenericCommand
//

#import <Foundation/Foundation.h>
#import "Command.h"
@protocol JSONParser, JSONWriter, TransportFactory, CommandErrorCreator;
@protocol URLRequestCreator, URLRequestBuilder, ParsedJSONResponseHandler, CommandErrorHandler;

@interface YAMMCCommand : NSObject <Command>

// injected dependencies
@property (strong, nonatomic) id<URLRequestCreator> urlRequestCreator;
@property (strong, nonatomic) id<JSONWriter> jsonWriter;
@property (strong, nonatomic) id<TransportFactory> transportFactory;
@property (strong, nonatomic) id<CommandErrorCreator> commandErrorCreator;

// operational parameters
- (id)initWithURLRequestBuilder:(id<URLRequestBuilder>)urlRequestBuilder
           urlRequestParameters:(NSDictionary *)urlRequestParameters 
                 urlRequestData:(NSDictionary *)urlRequestData
                     jsonParser:(id<JSONParser>)jsonParser
      parsedJSONResponseHandler:(id<ParsedJSONResponseHandler>)parsedJSONResponseParser 
            commandErrorHandler:(id<CommandErrorHandler>)commandErrorHandler;

@end
