//
//  YAMMCCommandTests.m
//  altoids
//
//  Created by Jon Herron on 9/16/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//
//  http://twiki.corp.yahoo.com/view/Devel/AltoidsiOSClientURLAndURLRequestHandling
//

#import "YATestCase.h"
#import "YAMMCCommand.h"
#import "JSONParser.h"
#import "JSONWriter.h"
#import "ParsedJSONResponseHandler.h"
#import "TransportFactory.h"
#import "Transport.h"
#import "URLRequestBuilder.h"
#import "URLRequestCreator.h"
#import "CommandErrorHandler.h"
#import "CommandErrorCreator.h"

@interface YAMMCCommandTests : YATestCase

@property (strong, nonatomic) id jsonParserMock;
@property (strong, nonatomic) id jsonWriterMock;
@property (strong, nonatomic) id parsedJSONResponseHandlerMock;
@property (strong, nonatomic) id transportMock;
@property (strong, nonatomic) id transportFactoryMock;
@property (strong, nonatomic) id urlRequestBuilderMock;
@property (strong, nonatomic) id urlRequestCreatorMock;
@property (strong, nonatomic) id urlRequestMock;
@property (strong, nonatomic) id urlRequestParametersMock;
@property (strong, nonatomic) id urlRequestDataMock;
@property (strong, nonatomic) id commandErrorHandlerMock;
@property (strong, nonatomic) id commandErrorCreatorMock;
@property (strong, nonatomic) YAMMCCommand *command;

- (void)executeCommandAndVerifyMocks;
- (void)verifyMocks;

@end


@interface ThrowingTransport : NSObject<Transport>
@end


@implementation YAMMCCommandTests

@synthesize jsonParserMock = jsonParserMock_;
@synthesize jsonWriterMock = jsonWriterMock_;
@synthesize parsedJSONResponseHandlerMock = parsedJSONResponseHandlerMock_;
@synthesize transportMock = transportMock_;
@synthesize transportFactoryMock = transportFactoryMock_;
@synthesize urlRequestBuilderMock = urlRequestBuilderMock_;
@synthesize urlRequestCreatorMock = urlRequestCreatorMock_;
@synthesize urlRequestMock = urlRequestMock_;
@synthesize urlRequestParametersMock = urlRequestParametersMock_;
@synthesize urlRequestDataMock = urlRequestDataMock_;
@synthesize commandErrorHandlerMock = commandErrorHandlerMock_;
@synthesize commandErrorCreatorMock = commandErrorCreatorMock_;
@synthesize command = command_;

- (void)setUp
{
    [self setJsonParserMock:[OCMockObject mockForProtocol:@protocol(JSONParser)]];
    [self setJsonWriterMock:[OCMockObject mockForProtocol:@protocol(JSONWriter)]];
    [self setParsedJSONResponseHandlerMock:[OCMockObject mockForProtocol:@protocol(ParsedJSONResponseHandler)]];
    [self setTransportFactoryMock:[OCMockObject mockForProtocol:@protocol(TransportFactory)]];
    [self setTransportMock:[OCMockObject mockForProtocol:@protocol(Transport)]];
    [self setUrlRequestBuilderMock:[OCMockObject mockForProtocol:@protocol(URLRequestBuilder)]];
    [self setUrlRequestCreatorMock:[OCMockObject mockForProtocol:@protocol(URLRequestCreator)]];
    [self setUrlRequestMock:[OCMockObject mockForClass:[NSURLRequest class]]];
    [self setUrlRequestParametersMock:[OCMockObject mockForClass:[NSDictionary class]]];
    [self setUrlRequestDataMock:[OCMockObject mockForClass:[NSDictionary class]]];
    [self setCommandErrorHandlerMock:[OCMockObject mockForProtocol:@protocol(CommandErrorHandler)]];
    [self setCommandErrorCreatorMock:[OCMockObject mockForProtocol:@protocol(CommandErrorCreator)]];
    
    [[[urlRequestParametersMock_ stub] andReturn:urlRequestParametersMock_] copy];
    [[[urlRequestDataMock_ stub] andReturn:urlRequestDataMock_] copy];
    
    YAMMCCommand* command = [[YAMMCCommand alloc] initWithURLRequestBuilder:urlRequestBuilderMock_ urlRequestParameters:urlRequestParametersMock_ urlRequestData:urlRequestDataMock_ jsonParser:jsonParserMock_ parsedJSONResponseHandler:parsedJSONResponseHandlerMock_ commandErrorHandler:commandErrorHandlerMock_];
    [command setUrlRequestCreator:urlRequestCreatorMock_];
    [command setJsonWriter:jsonWriterMock_];
    [command setTransportFactory:transportFactoryMock_];
    [command setCommandErrorCreator:commandErrorCreatorMock_];
    [self setCommand:command];
}

- (void)testIfUrlRequestDataIsNotNilItIsGivenToJSONWriterToWriteToDataForm
{
    // temp ignore these calls for this commit
    BOOL yes = YES;
    [[[commandErrorHandlerMock_ stub] andReturnValue:OCMOCK_VALUE(yes)] urlRequestHasError:OCMOCK_ANY error:[OCMArg setTo:nil]];
    [[[commandErrorHandlerMock_ stub] andReturnValue:OCMOCK_VALUE(yes)] parsedJSONResponseHasError:OCMOCK_ANY error:[OCMArg setTo:nil]];
    [[commandErrorHandlerMock_ stub] handleError:OCMOCK_ANY];
    
    [[jsonWriterMock_ expect] dataFromDictionary:urlRequestDataMock_];
    
    [[urlRequestCreatorMock_ stub] urlRequestFromURLRequestBuilder:OCMOCK_ANY withURLParameters:OCMOCK_ANY requestData:OCMOCK_ANY];
    
    [self executeCommandAndVerifyMocks];
}

- (void)testIfUrlRequestDataIsNotNilResultsOfJSONWriterAreGivenToUrlRequestCreatorAsRequestData
{
    NSData *data = [NSData data];
    
    // temp ignore these calls for this commit
    BOOL yes = YES;
    [[[commandErrorHandlerMock_ stub] andReturnValue:OCMOCK_VALUE(yes)] urlRequestHasError:OCMOCK_ANY error:[OCMArg setTo:nil]];
    [[[commandErrorHandlerMock_ stub] andReturnValue:OCMOCK_VALUE(yes)] parsedJSONResponseHasError:OCMOCK_ANY error:[OCMArg setTo:nil]];
    [[commandErrorHandlerMock_ stub] handleError:OCMOCK_ANY];
    
    [[[jsonWriterMock_ stub] andReturn:data] dataFromDictionary:OCMOCK_ANY];
    
    [[urlRequestCreatorMock_ expect] urlRequestFromURLRequestBuilder:OCMOCK_ANY withURLParameters:OCMOCK_ANY requestData:data];
    
    [self executeCommandAndVerifyMocks];
}

- (void)testIfUrlRequestDataIsNilUrlRequestCreatorIsGivenNilRequestData
{
    YAMMCCommand *oneOffCommandOnlyForThisTestDoNotMimicThisUse = [[YAMMCCommand alloc] initWithURLRequestBuilder:nil urlRequestParameters:nil urlRequestData:nil jsonParser:nil parsedJSONResponseHandler:nil commandErrorHandler:nil];
    [oneOffCommandOnlyForThisTestDoNotMimicThisUse setUrlRequestCreator:urlRequestCreatorMock_];
    [oneOffCommandOnlyForThisTestDoNotMimicThisUse setJsonWriter:jsonWriterMock_];
    
    [[urlRequestCreatorMock_ expect] urlRequestFromURLRequestBuilder:OCMOCK_ANY withURLParameters:OCMOCK_ANY requestData:nil];
    
    [oneOffCommandOnlyForThisTestDoNotMimicThisUse execute];
    [jsonWriterMock_ verify];
    [urlRequestCreatorMock_ verify];
}

- (void)testUsesURLRequestCreatorAndBuilderToFormNSURLRequest
{
    NSData *data = [NSData data];
    
    [[[jsonWriterMock_ stub] andReturn:data] dataFromDictionary:OCMOCK_ANY];
    
    [[urlRequestCreatorMock_ expect] urlRequestFromURLRequestBuilder:urlRequestBuilderMock_ withURLParameters:urlRequestParametersMock_ requestData:data];
    
    // temp ignore these calls for this commit
    BOOL yes = YES;
    [[[commandErrorHandlerMock_ stub] andReturnValue:OCMOCK_VALUE(yes)] urlRequestHasError:OCMOCK_ANY error:[OCMArg setTo:nil]];
    [[[commandErrorHandlerMock_ stub] andReturnValue:OCMOCK_VALUE(yes)] parsedJSONResponseHasError:OCMOCK_ANY error:[OCMArg setTo:nil]];
    [[commandErrorHandlerMock_ stub] handleError:OCMOCK_ANY];
    
    [self executeCommandAndVerifyMocks];
}

- (void)testIfNSURLRequestIsNilCommandHalts
{
    [[jsonWriterMock_ stub] dataFromDictionary:OCMOCK_ANY];
    
    [[[urlRequestCreatorMock_ expect] andReturn:nil] urlRequestFromURLRequestBuilder:urlRequestBuilderMock_ withURLParameters:OCMOCK_ANY requestData:OCMOCK_ANY];
    
    // temp ignore these calls for this commit
    BOOL yes = YES;
    [[[commandErrorHandlerMock_ stub] andReturnValue:OCMOCK_VALUE(yes)] urlRequestHasError:OCMOCK_ANY error:[OCMArg setTo:nil]];
    [[[commandErrorHandlerMock_ stub] andReturnValue:OCMOCK_VALUE(yes)] parsedJSONResponseHasError:OCMOCK_ANY error:[OCMArg setTo:nil]];
    [[commandErrorHandlerMock_ stub] handleError:OCMOCK_ANY];
    
    [self executeCommandAndVerifyMocks];
}

- (void)testPassesCreatedURLRequestToTransport
{
    [[jsonWriterMock_ stub] dataFromDictionary:OCMOCK_ANY];
    
    [[[urlRequestCreatorMock_ expect] andReturn:urlRequestMock_] urlRequestFromURLRequestBuilder:OCMOCK_ANY withURLParameters:OCMOCK_ANY requestData:OCMOCK_ANY];
    
    [[[transportFactoryMock_ expect] andReturn:transportMock_] serverTransport];
    [[transportMock_ expect] sendSynchronousRequest:urlRequestMock_ 
                                        returningResponse:[OCMArg setTo:nil]
                                                     data:[OCMArg setTo:nil] 
                                                    error:[OCMArg setTo:nil]];
    
    [[jsonParserMock_ stub] parseJSONData:OCMOCK_ANY];
    
    // temp ignore these calls for this commit
    BOOL no = NO;
    BOOL yes = YES;
    [[[commandErrorHandlerMock_ stub] andReturnValue:OCMOCK_VALUE(no)] urlRequestHasError:OCMOCK_ANY error:[OCMArg setTo:nil]];
    [[[commandErrorHandlerMock_ stub] andReturnValue:OCMOCK_VALUE(yes)] parsedJSONResponseHasError:OCMOCK_ANY error:[OCMArg setTo:nil]];
    [[commandErrorHandlerMock_ stub] handleError:OCMOCK_ANY];
    
    [self executeCommandAndVerifyMocks];
}

- (void)testIfTransportSetsErrorCommandHalts
{
    NSError *error = [NSError errorWithDomain:@"d" code:1 userInfo:nil];
    
    [[jsonWriterMock_ stub] dataFromDictionary:OCMOCK_ANY];
    
    [[[urlRequestCreatorMock_ expect] andReturn:urlRequestMock_] urlRequestFromURLRequestBuilder:OCMOCK_ANY withURLParameters:OCMOCK_ANY requestData:OCMOCK_ANY];
    
    [[[transportFactoryMock_ expect] andReturn:transportMock_] serverTransport];
    [[transportMock_ expect] sendSynchronousRequest:urlRequestMock_ 
                                        returningResponse:[OCMArg setTo:nil]
                                                     data:[OCMArg setTo:nil] 
                                                    error:[OCMArg setTo:error]];
    
    // temp ignore these calls for this commit
    BOOL no = NO;
    BOOL yes = YES;
    [[[commandErrorHandlerMock_ stub] andReturnValue:OCMOCK_VALUE(no)] urlRequestHasError:OCMOCK_ANY error:[OCMArg setTo:nil]];
    [[[commandErrorHandlerMock_ stub] andReturnValue:OCMOCK_VALUE(yes)] parsedJSONResponseHasError:OCMOCK_ANY error:[OCMArg setTo:nil]];
    [[commandErrorHandlerMock_ stub] handleError:OCMOCK_ANY];
    
    [self executeCommandAndVerifyMocks];
}

- (void)testDataSetByTransportIsGivenToJSONParserForParsing
{
    return;
    
    NSData *data = [NSData data];
    
    [[jsonWriterMock_ stub] dataFromDictionary:OCMOCK_ANY];
    
    [[[urlRequestCreatorMock_ expect] andReturn:urlRequestMock_] urlRequestFromURLRequestBuilder:OCMOCK_ANY withURLParameters:OCMOCK_ANY requestData:OCMOCK_ANY];
    
    [[[transportFactoryMock_ expect] andReturn:transportMock_] serverTransport];
    [[transportMock_ expect] sendSynchronousRequest:urlRequestMock_ 
                                        returningResponse:[OCMArg setTo:nil]
                                                     data:[OCMArg setTo:data] 
                                                    error:[OCMArg setTo:nil]];
    
    [[jsonParserMock_ expect] parseJSONData:data];
    
    // temp ignore these calls for this commit
    BOOL no = NO;
    [[[commandErrorHandlerMock_ stub] andReturnValue:OCMOCK_VALUE(no)] urlRequestHasError:OCMOCK_ANY error:[OCMArg setTo:nil]];
    [[[commandErrorHandlerMock_ stub] andReturnValue:OCMOCK_VALUE(no)] parsedJSONResponseHasError:OCMOCK_ANY error:[OCMArg setTo:nil]];
    [[commandErrorHandlerMock_ stub] handleError:OCMOCK_ANY];
    
    [self executeCommandAndVerifyMocks];
}

- (void)testIfJSONParserReturnsNilCommandHalts
{
    [[jsonWriterMock_ stub] dataFromDictionary:OCMOCK_ANY];
    
    [[[urlRequestCreatorMock_ expect] andReturn:urlRequestMock_] urlRequestFromURLRequestBuilder:OCMOCK_ANY withURLParameters:OCMOCK_ANY requestData:OCMOCK_ANY];
    
    [[[transportFactoryMock_ expect] andReturn:transportMock_] serverTransport];
    [[transportMock_ expect] sendSynchronousRequest:urlRequestMock_ 
                                        returningResponse:[OCMArg setTo:nil]
                                                     data:[OCMArg setTo:nil] 
                                                    error:[OCMArg setTo:nil]];
    
    [[[jsonParserMock_ expect] andReturn:nil] parseJSONData:OCMOCK_ANY];
    
    // temp ignore these calls for this commit
    BOOL no = NO;
    BOOL yes = YES;
    [[[commandErrorHandlerMock_ stub] andReturnValue:OCMOCK_VALUE(no)] urlRequestHasError:OCMOCK_ANY error:[OCMArg setTo:nil]];
    [[[commandErrorHandlerMock_ stub] andReturnValue:OCMOCK_VALUE(yes)] parsedJSONResponseHasError:OCMOCK_ANY error:[OCMArg setTo:nil]];
    [[commandErrorHandlerMock_ stub] handleError:OCMOCK_ANY];
    
    [self executeCommandAndVerifyMocks];
}

- (void)testResultFromJSONParserIsGivenToParsedJSONResponseHandler
{
    NSDictionary *jsonResponse = [NSDictionary dictionary];
    
    [[jsonWriterMock_ stub] dataFromDictionary:OCMOCK_ANY];
    
    [[[urlRequestCreatorMock_ expect] andReturn:urlRequestMock_] urlRequestFromURLRequestBuilder:OCMOCK_ANY withURLParameters:OCMOCK_ANY requestData:OCMOCK_ANY];
    
    [[[transportFactoryMock_ expect] andReturn:transportMock_] serverTransport];
    [[transportMock_ expect] sendSynchronousRequest:urlRequestMock_ 
                                        returningResponse:[OCMArg setTo:nil]
                                                     data:[OCMArg setTo:nil] 
                                                    error:[OCMArg setTo:nil]];
    
    [[[jsonParserMock_ expect] andReturn:jsonResponse] parseJSONData:OCMOCK_ANY];
    
    [[parsedJSONResponseHandlerMock_ expect] handleParsedJSONResponse:jsonResponse];
    
    // temp ignore these calls for this commit
    BOOL no = NO;
    [[[commandErrorHandlerMock_ stub] andReturnValue:OCMOCK_VALUE(no)] urlRequestHasError:OCMOCK_ANY error:[OCMArg setTo:nil]];
    [[[commandErrorHandlerMock_ stub] andReturnValue:OCMOCK_VALUE(no)] parsedJSONResponseHasError:OCMOCK_ANY error:[OCMArg setTo:nil]];
    [[commandErrorHandlerMock_ stub] handleError:OCMOCK_ANY];
    
    [self executeCommandAndVerifyMocks];
}

- (void)testExecuteShouldHandleAndReturnErrorCreatedFromExceptionWhenRequestDoesThrowException
{
    // we could add a lot more exception-handling coverage (exceptions at different points within executeMMCCommand), but looking at the code, there's not much value in adding that coverage now -- there's no special handling for an exception at any point except between execution and error handling

    [[jsonWriterMock_ stub] dataFromDictionary:OCMOCK_ANY];
    [[urlRequestCreatorMock_ stub] urlRequestFromURLRequestBuilder:OCMOCK_ANY withURLParameters:OCMOCK_ANY requestData:OCMOCK_ANY];
    [[commandErrorHandlerMock_ stub] urlRequestHasError:OCMOCK_ANY error:[OCMArg setTo:nil]];

    [[[transportFactoryMock_ expect] andReturn:[[ThrowingTransport alloc] init]] serverTransport];

    NSError* expectedError = [NSError errorWithDomain:@"whatever" code:0 userInfo:nil];
    [[[commandErrorCreatorMock_ expect] andReturn:expectedError] errorWithCode:YACommandErrorCodeException underlyingError:OCMOCK_ANY];
    [[commandErrorHandlerMock_ expect] handleError:expectedError];

    NSError* result = [command_ execute];
    STAssertEquals(result, expectedError, nil);
    
    [self verifyMocks];
}


- (void)executeCommandAndVerifyMocks
{
    [command_ execute];
    [self verifyMocks];
}

- (void)verifyMocks
{
    [jsonParserMock_ verify];
    [jsonWriterMock_ verify];
    [parsedJSONResponseHandlerMock_ verify];
    [transportFactoryMock_ verify];
    [transportMock_ verify];
    [urlRequestBuilderMock_ verify];
    [urlRequestCreatorMock_ verify];
    [urlRequestMock_ verify];
    [urlRequestParametersMock_ verify];
    [commandErrorHandlerMock_ verify];
    [commandErrorCreatorMock_ verify];
}

@end


// we can't use OCMock to andThrow an exception anymore:
// http://spin.atomicobject.com/2010/07/06/catching-exceptions-via-nsinvocation-and-nsproxy-is-not-longer-possible-in-objective-c/
@implementation ThrowingTransport
- (void)sendSynchronousRequest:(NSURLRequest *)request returningResponse:(id<HTTPURLResponse> __autoreleasing *)response data:(NSData *__autoreleasing*)data
                         error:(NSError *__autoreleasing *)error
{
    [NSException raise:@"some exception name" format:@"some details"];
}
- (void)startRequest:(NSURLRequest *)request withDelegate:(id<NSURLConnectionDataDelegate>)delegate
{
    [NSException raise:@"some exception name" format:@"some details"];
}
@end
