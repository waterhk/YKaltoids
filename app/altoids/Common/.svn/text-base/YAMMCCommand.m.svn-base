//
//  YACommand.m
//  altoids
//
//  Created by Jon Herron on 9/16/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//
//  http://twiki.corp.yahoo.com/view/Devel/AltoidsiOSClientGenericCommand
//

#import "YAMMCCommand.h"
#import "AppFactory.h"
#import "JSONWriter.h"
#import "JSONParser.h"
#import "TransportFactory.h"
#import "CommandErrorCreator.h"
#import "URLRequestCreator.h"
#import "URLRequestBuilder.h"
#import "ParsedJSONResponseHandler.h"
#import "CommandErrorHandlerCreator.h"
#import "HTTPURLResponse.h"
#import "YASessionLogger.h"

#undef kYALogComponent
#define kYALogComponent lcl_cCommand

@interface YAMMCCommand ()

@property (strong, nonatomic) id<URLRequestBuilder> urlRequestBuilder;
@property (copy,   nonatomic) NSDictionary *urlRequestParameters;
@property (copy,   nonatomic) NSDictionary *urlRequestData;
@property (strong, nonatomic) id<JSONParser> jsonParser;
@property (strong, nonatomic) id<ParsedJSONResponseHandler> parsedJSONResponseHandler;
@property (strong, nonatomic) id<CommandErrorHandler> commandErrorHandler;

- (NSError*) executeMMCCommand;

@end


@implementation YAMMCCommand

@synthesize jsonParser = jsonParser_;
@synthesize jsonWriter = jsonWriter_;
@synthesize parsedJSONResponseHandler = parsedJSONResponseHandler_;
@synthesize transportFactory = transportFactory_;
@synthesize commandErrorCreator = commandErrorCreator_;
@synthesize urlRequestBuilder = urlRequestBuilder_;
@synthesize urlRequestCreator = urlRequestCreator_;
@synthesize commandErrorHandler = commandErrorHandler_;
@synthesize urlRequestParameters = urlRequestParameters_;
@synthesize urlRequestData = urlRequestData_;


- (id)initWithURLRequestBuilder:(id<URLRequestBuilder>)urlRequestBuilder
           urlRequestParameters:(NSDictionary *)urlRequestParameters 
                 urlRequestData:(NSDictionary *)urlRequestData
                     jsonParser:(id<JSONParser>)jsonParser
      parsedJSONResponseHandler:(id<ParsedJSONResponseHandler>)parsedJSONResponseParser 
            commandErrorHandler:(id<CommandErrorHandler>)commandErrorHandler
{
  self = [super init];
  if (self) 
  {
      urlRequestBuilder_ = urlRequestBuilder;
      urlRequestParameters_ = [urlRequestParameters copy];
      urlRequestData_ = [urlRequestData copy];
      jsonParser_ = jsonParser;
      parsedJSONResponseHandler_ = parsedJSONResponseParser;
      commandErrorHandler_ = commandErrorHandler;
  }
  
  return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"request:\n\t%@\n", [urlRequestCreator_ urlRequestFromURLRequestBuilder:urlRequestBuilder_
                                                                                             withURLParameters:urlRequestParameters_
                                                                                                   requestData:[jsonWriter_ dataFromDictionary:urlRequestData_]]];
}

- (NSError*) execute
{
    NSError* error = nil;

    @try
    {
        error = [self executeMMCCommand];
    }
    @catch(id exception)
    {
        error = [commandErrorCreator_ errorWithCode:YACommandErrorCodeException underlyingError:error];
    }

    if(error)
    {
        [commandErrorHandler_ handleError:error];
    }

    return error;
}

- (NSError*) executeMMCCommand
{
    NSError* error;

    NSData* requestData = urlRequestData_ ? [jsonWriter_ dataFromDictionary:urlRequestData_] : nil;
    NSURLRequest *urlRequest = [urlRequestCreator_ urlRequestFromURLRequestBuilder:urlRequestBuilder_ withURLParameters:urlRequestParameters_ requestData:requestData];
    if ([commandErrorHandler_ urlRequestHasError:urlRequest error:&error]) 
    {
        // todo: move logging into error handler
        YALogError(@"Error: Nil urlRequest returned from urlRequestCreator. Request parameters\n%@\nRequest Data\n%@\n", urlRequestParameters_, urlRequestData_);        
        return error;
    }

    id<HTTPURLResponse> urlResponse = nil;
    NSData *responseData = nil;
    [[transportFactory_ serverTransport] sendSynchronousRequest:urlRequest returningResponse:&urlResponse data:&responseData error:&error];
    if (error) 
    {
        //todo: move logging into error handler
        YALogError(@"Error:\n%@\n", [error localizedDescription]);
        return error;
    }

    NSDictionary *jsonResponse = [jsonParser_ parseJSONData:responseData];    
    if ([commandErrorHandler_ parsedJSONResponseHasError:jsonResponse error:&error])
    {
        NSString *response = [[NSString alloc] initWithBytes:[responseData bytes] length:[responseData length] encoding:NSUTF8StringEncoding];
        // todo: move logging into error handler
        YALogError(@"JSON parser returned nil results\nresponseData:\n{\n\t%@\n}\n", response);
        return error;
    }

    [parsedJSONResponseHandler_ handleParsedJSONResponse:jsonResponse];
    return error;
}

@end
