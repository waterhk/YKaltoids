//
//  YAConversationCommandFactoryTests.m
//  altoids
//
//  Created by Jon Herron on 10/13/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAConversationCommandFactoryTests.h"
#import "YAConversationCommandFactory.h"
#import "AppFactory.h"
#import "ConversationHandler.h"
#import "JSONParser.h"
#import "ConversationListParsedJSONResponseHandlerCreator.h"
#import "MMCURLParametersCreator.h"
#import "ConversationCreateRequestDataBuilder.h"
#import "ConversationCreateParsedJSONResponseHandlerCreator.h"
#import "ConversationFlagMessagesRequestDataBuilder.h"
#import "ConversationMessageListJSONParser.h"
#import "ConversationMessageListParsedJSONResponseHandlerCreator.h"
#import "ConversationReplyRequestDataBuilder.h"
#import "ConversationURLRequestBuilderCreator.h"
#import "YAConversation.h"
#import "YAMessage.h"
#import "ConversationCreateCommandDelegate.h"
#import "ConversationListCommandDelegate.h"
#import "ConversationMessageListCommandDelegate.h"
#import "ConversationReplyParsedJSONResponseHandler.h"
#import "ConversationReplyParsedJSONResponseHandlerCreator.h"
#import "ConversationReplyCommandDelegate.h"
#import "MessageHandler.h"
#import "CommandErrorHandlerCreator.h"
#import "ConversationErrorHandlerFactory.h"

@interface YAConversationCommandFactoryTests()

@property (strong, nonatomic) id mmcCommandInstanceFactoryMock;
@property (strong, nonatomic) id conversationMock;
@property (strong, nonatomic) id messageMock;
@property (strong, nonatomic) id conversationCreateCommandDelegateMock;
@property (strong, nonatomic) id conversationListCommandDelegateMock;
@property (strong, nonatomic) id conversationMessageListCommandDelegateMock;
@property (strong, nonatomic) id requestDataMock;
@property (strong, nonatomic) id requestParametersMock;
@property (strong, nonatomic) id conversationHandlerMock;
@property (strong, nonatomic) id urlRequestCreatorMock;
@property (strong, nonatomic) id jsonParserMock;
@property (strong, nonatomic) id conversationMessageListJSONParserMock;
@property (strong, nonatomic) id conversationListParsedJSONResponseHandlerMock;
@property (strong, nonatomic) id conversationListParsedJSONResponseHandlerCreatorMock;
@property (strong, nonatomic) id mmcURLParametersCreatorMock;
@property (strong, nonatomic) id conversationCreateRequestDataBuilderMock;
@property (strong, nonatomic) id conversationCreateParsedJSONResponseHandlerMock;
@property (strong, nonatomic) id conversationCreateParsedJSONResponseHandlerCreatorMock;
@property (strong, nonatomic) id conversationURLRequestBuilderMock;
@property (strong, nonatomic) id conversationURLRequestBuilderCreatorMock;
@property (strong, nonatomic) id conversationMessageListParsedJSONResponseHandlerMock;
@property (strong, nonatomic) id conversationMessageListParsedJSONResponseHandlerCreatorMock;
@property (strong, nonatomic) id conversationReplyRequestDataBuilderMock;
@property (strong, nonatomic) id conversationReplyParsedJSONResponseHandlerMock;
@property (strong, nonatomic) id conversationReplyParsedJSONResponseHandlerCreatorMock;
@property (strong, nonatomic) id conversationReplyCommandDelegateMock;
@property (strong, nonatomic) id conversationEditRequestDataBuilderMock;
@property (strong, nonatomic) id conversationEditParsedJSONResponseHandlerCreatorMock;
@property (strong, nonatomic) id conversationFlagMessagesRequestDataBuilderMock;
@property (strong, nonatomic) id messageHandlerMock;
@property (strong, nonatomic) id commandErrorHandlerMock;
@property (strong, nonatomic) id commandErrorHandlerCreatorMock;
@property (strong, nonatomic) id conversationErrorHandlerMock;
@property (strong, nonatomic) id conversationErrorHandlerFactoryMock;
@property (strong, nonatomic) id commandMock;
@property (strong, nonatomic) YAConversationCommandFactory *conversationCommandFactory;

- (void)verifyMocks;

@end

@implementation YAConversationCommandFactoryTests

@synthesize mmcCommandInstanceFactoryMock = mmcCommandInstanceFactoryMock_;
@synthesize conversationMock = conversationMock_;
@synthesize messageMock = messageMock_;
@synthesize conversationCreateCommandDelegateMock = conversationCreateCommandDelegateMock_;
@synthesize conversationListCommandDelegateMock = conversationListCommandDelegateMock_;
@synthesize conversationMessageListCommandDelegateMock = conversationMessageListCommandDelegateMock_;
@synthesize requestDataMock = requestDataMock_;
@synthesize requestParametersMock = requestParametersMock_;
@synthesize conversationHandlerMock = conversationHandlerMock_;
@synthesize urlRequestCreatorMock = urlRequestCreatorMock_;
@synthesize jsonParserMock = jsonParserMock_;
@synthesize conversationMessageListJSONParserMock = conversationMessageListJSONParserMock_;
@synthesize conversationListParsedJSONResponseHandlerMock = conversationListParsedJSONResponseHandlerMock_;
@synthesize conversationListParsedJSONResponseHandlerCreatorMock = conversationListParsedJSONResponseHandlerCreatorMock_;
@synthesize mmcURLParametersCreatorMock = mmcURLParametersCreatorMock_;
@synthesize conversationCreateRequestDataBuilderMock = conversationCreateRequestDataBuilderMock_;
@synthesize conversationCreateParsedJSONResponseHandlerMock = conversationCreateParsedJSONResponseHandlerMock_;
@synthesize conversationCreateParsedJSONResponseHandlerCreatorMock = conversationCreateParsedJSONResponseHandlerCreatorMock_;
@synthesize conversationURLRequestBuilderMock = conversationURLRequestBuilderMock_;
@synthesize conversationURLRequestBuilderCreatorMock = conversationURLRequestBuilderCreatorMock_;
@synthesize conversationMessageListParsedJSONResponseHandlerMock = conversationMessageListParsedJSONResponseHandlerMock_;
@synthesize conversationMessageListParsedJSONResponseHandlerCreatorMock = conversationMessageListParsedJSONResponseHandlerCreatorMock_;
@synthesize conversationReplyRequestDataBuilderMock = conversationReplyRequestDataBuilderMock_;
@synthesize conversationReplyParsedJSONResponseHandlerMock = conversationReplyParsedJSONResponseHandlerMock_;
@synthesize conversationReplyParsedJSONResponseHandlerCreatorMock = conversationReplyParsedJSONResponseHandlerCreatorMock_;
@synthesize conversationCommandFactory = conversationCommandFactory_;
@synthesize conversationReplyCommandDelegateMock = conversationReplyCommandDelegateMock_;
@synthesize conversationEditRequestDataBuilderMock = conversationEditRequestDataBuilderMock_;
@synthesize conversationEditParsedJSONResponseHandlerCreatorMock = conversationEditParsedJSONResponseHandlerCreatorMock_;
@synthesize conversationFlagMessagesRequestDataBuilderMock = conversationFlagMessagesRequestDataBuilderMock_;
@synthesize messageHandlerMock = messageHandlerMock_;
@synthesize commandErrorHandlerCreatorMock = commandErrorHandlerCreatorMock_;
@synthesize commandErrorHandlerMock = commandErrorHandlerMock_;
@synthesize conversationErrorHandlerMock = conversationErrorHandlerMock_;
@synthesize conversationErrorHandlerFactoryMock = conversationErrorHandlerFactoryMock_;
@synthesize commandMock = commandMock_;

- (void)setUp
{
    [self setMmcCommandInstanceFactoryMock:[OCMockObject mockForProtocol:@protocol(MMCCommandInstanceFactory)]];
    [self setConversationMock:[OCMockObject mockForClass:[YAConversation class]]];
    [self setMessageMock:[OCMockObject mockForClass:[YAMessage class]]];
    [self setConversationCreateCommandDelegateMock:[OCMockObject mockForProtocol:@protocol(ConversationCreateCommandDelegate)]];
    [self setConversationListCommandDelegateMock:[OCMockObject mockForProtocol:@protocol(ConversationListCommandDelegate)]];
    [self setConversationMessageListCommandDelegateMock:[OCMockObject mockForProtocol:@protocol(ConversationMessageListCommandDelegate)]];
    
    [self setRequestDataMock:[OCMockObject mockForClass:[NSDictionary class]]];
    [self setRequestParametersMock:[OCMockObject mockForClass:[NSDictionary class]]];
    
    [self setConversationHandlerMock:[OCMockObject mockForProtocol:@protocol(ConversationHandler)]];
    [self setJsonParserMock:[OCMockObject mockForProtocol:@protocol(JSONParser)]];
    [self setConversationMessageListJSONParserMock:[OCMockObject mockForProtocol:@protocol(ConversationMessageListJSONParser)]];
    [self setConversationListParsedJSONResponseHandlerMock:[OCMockObject mockForProtocol:@protocol(ConversationListParsedJSONResponseHandler)]];
    [self setConversationListParsedJSONResponseHandlerCreatorMock:[OCMockObject mockForProtocol:@protocol(ConversationListParsedJSONResponseHandlerCreator)]];
    [self setMmcURLParametersCreatorMock:[OCMockObject mockForProtocol:@protocol(MMCURLParametersCreator)]];
    [self setConversationCreateRequestDataBuilderMock:[OCMockObject mockForProtocol:@protocol(ConversationCreateRequestDataBuilder)]];
    [self setConversationCreateParsedJSONResponseHandlerMock:[OCMockObject mockForProtocol:@protocol(ConversationCreateParsedJSONResponseHandler)]];
    [self setConversationCreateParsedJSONResponseHandlerCreatorMock:[OCMockObject mockForProtocol:@protocol(ConversationCreateParsedJSONResponseHandlerCreator)]];
    [self setConversationURLRequestBuilderMock:[OCMockObject mockForProtocol:@protocol(URLRequestBuilder)]];
    [self setConversationURLRequestBuilderCreatorMock:[OCMockObject mockForProtocol:@protocol(ConversationURLRequestBuilderCreator)]];
    [self setConversationMessageListParsedJSONResponseHandlerMock:[OCMockObject mockForProtocol:@protocol(ConversationMessageListParsedJSONResponseHandler)]];
    [self setConversationMessageListParsedJSONResponseHandlerCreatorMock:[OCMockObject mockForProtocol:@protocol(ConversationMessageListParsedJSONResponseHandlerCreator)]];
    [self setConversationReplyRequestDataBuilderMock:[OCMockObject mockForProtocol:@protocol(ConversationReplyRequestDataBuilder)]];
    [self setConversationReplyParsedJSONResponseHandlerMock:[OCMockObject mockForProtocol:@protocol(ConversationReplyParsedJSONResponseHandler)]];
    [self setConversationReplyParsedJSONResponseHandlerCreatorMock:[OCMockObject mockForProtocol:@protocol(ConversationReplyParsedJSONResponseHandlerCreator)]];
    [self setConversationReplyCommandDelegateMock:[OCMockObject mockForProtocol:@protocol(ConversationReplyCommandDelegate)]];
    [self setConversationEditRequestDataBuilderMock:[OCMockObject mockForProtocol:@protocol(ConversationEditRequestDataBuilder)]];
    [self setConversationEditParsedJSONResponseHandlerCreatorMock:[OCMockObject mockForProtocol:@protocol(ConversationEditParsedJSONResponseHandlerCreator)]];
    [self setConversationFlagMessagesRequestDataBuilderMock:[OCMockObject mockForProtocol:@protocol(ConversationFlagMessagesRequestDataBuilder)]];
    [self setMessageHandlerMock:[OCMockObject mockForProtocol:@protocol(MessageHandler)]];
    [self setCommandErrorHandlerCreatorMock:[OCMockObject mockForProtocol:@protocol(CommandErrorHandlerCreator)]];
    [self setCommandErrorHandlerMock:[OCMockObject mockForProtocol:@protocol(CommandErrorHandler)]];
    [self setConversationErrorHandlerFactoryMock:[OCMockObject mockForProtocol:@protocol(ConversationErrorHandlerFactory)]];
    
    [self setConversationCommandFactory:[[YAConversationCommandFactory alloc] init]];
    [conversationCommandFactory_ setMmcCommandInstanceFactory:mmcCommandInstanceFactoryMock_];
    [conversationCommandFactory_ setConversationHandler:conversationHandlerMock_];
    [conversationCommandFactory_ setJsonParser:jsonParserMock_];
    [conversationCommandFactory_ setConversationMessageListJSONParser:conversationMessageListJSONParserMock_];
    [conversationCommandFactory_ setConversationListParsedJSONResponseHandlerCreator:conversationListParsedJSONResponseHandlerCreatorMock_];
    [conversationCommandFactory_ setMmcURLParametersCreator:mmcURLParametersCreatorMock_];
    [conversationCommandFactory_ setConversationCreateRequestDataBuilder:conversationCreateRequestDataBuilderMock_];
    [conversationCommandFactory_ setConversationCreateParsedJSONResponseHandlerCreator:conversationCreateParsedJSONResponseHandlerCreatorMock_];
    [conversationCommandFactory_ setConversationURLRequestBuilderCreator:conversationURLRequestBuilderCreatorMock_];
    [conversationCommandFactory_ setConversationMessageListParsedJSONResponseHandlerCreator:conversationMessageListParsedJSONResponseHandlerCreatorMock_];
    [conversationCommandFactory_ setConversationReplyRequestDataBuilder:conversationReplyRequestDataBuilderMock_];
    [conversationCommandFactory_ setConversationReplyParsedJSONResponseHandlerCreator:conversationReplyParsedJSONResponseHandlerCreatorMock_];
    [conversationCommandFactory_ setConversationEditRequestDataBuilder:conversationEditRequestDataBuilderMock_];
    [conversationCommandFactory_ setConversationEditParsedJSONResponseHandlerCreator:conversationEditParsedJSONResponseHandlerCreatorMock_];
    [conversationCommandFactory_ setConversationFlagMessagesRequestDataBuilder:conversationFlagMessagesRequestDataBuilderMock_];
    [conversationCommandFactory_ setMessageHandler:messageHandlerMock_];
    [conversationCommandFactory_ setCommandErrorHandlerCreator:commandErrorHandlerCreatorMock_];
    [conversationCommandFactory_ setConversationErrorHandlerFactory:conversationErrorHandlerFactoryMock_];
}

- (void)testCanConstructCommandToCreateConversation
{
    [[[conversationCreateParsedJSONResponseHandlerCreatorMock_ expect] andReturn:conversationCreateParsedJSONResponseHandlerMock_] createWithConversation:conversationMock_ delegate:conversationCreateCommandDelegateMock_];
    [[[conversationURLRequestBuilderCreatorMock_ expect] andReturn:conversationURLRequestBuilderMock_] createConversationCreateURLRequestBuilder];
    [[[conversationCreateRequestDataBuilderMock_ expect] andReturn:requestDataMock_] requestDataForConversation:conversationMock_];
    [[[mmcURLParametersCreatorMock_ expect] andReturn:requestParametersMock_] urlParametersForCreateConversation];
    
    [[[conversationErrorHandlerFactoryMock_ expect] andReturn:conversationErrorHandlerMock_] conversationCreateErrorHandlerWithConversation:conversationMock_];
    [[[commandErrorHandlerCreatorMock_ expect] andReturn:commandErrorHandlerMock_] createWithErrorHandler:conversationErrorHandlerMock_];

    [[[mmcCommandInstanceFactoryMock_ expect] andReturn:commandMock_] createMMCCommandWithURLRequestBuilder:conversationURLRequestBuilderMock_ urlRequestParameters:requestParametersMock_ urlRequestData:requestDataMock_ jsonParser:jsonParserMock_ parsedJSONResponseHandler:conversationCreateParsedJSONResponseHandlerMock_ commandErrorHandler:commandErrorHandlerMock_];
    
    STAssertEquals(commandMock_, [conversationCommandFactory_ conversationCreateCommandForConversation:conversationMock_ withDelegate:conversationCreateCommandDelegateMock_], @"Unexpected conversation create command");
    
    [self verifyMocks];
}

- (void)testCanConstructCommandToRetrieveListOfMostRecentConversations
{
    [[[mmcURLParametersCreatorMock_ expect] andReturn:requestParametersMock_] urlParametersForConversationListFromMostRecentConversation];
    [[[conversationListParsedJSONResponseHandlerCreatorMock_ expect] andReturn:conversationListParsedJSONResponseHandlerMock_] createWithDelegate:conversationListCommandDelegateMock_];
    [[[conversationURLRequestBuilderCreatorMock_ expect] andReturn:conversationURLRequestBuilderMock_] createConversationListURLRequestBuilder];
    
    [[[commandErrorHandlerCreatorMock_ expect] andReturn:commandErrorHandlerMock_] createWithErrorHandler:nil];

    [[[mmcCommandInstanceFactoryMock_ expect] andReturn:commandMock_] createMMCCommandWithURLRequestBuilder:conversationURLRequestBuilderMock_ urlRequestParameters:requestParametersMock_ urlRequestData:nil jsonParser:jsonParserMock_ parsedJSONResponseHandler:conversationListParsedJSONResponseHandlerMock_ commandErrorHandler:commandErrorHandlerMock_];

    STAssertEquals(commandMock_, [conversationCommandFactory_ conversationListCommandForMostRecentConversationsWithDelegate:conversationListCommandDelegateMock_ transactionDelegate:nil], @"Unexpected conversation list command");
    
    [self verifyMocks];
}

- (void)testCanConstructCommandToRetrieveConversationsAfterAConversation
{
    [[[mmcURLParametersCreatorMock_ expect] andReturn:requestParametersMock_] urlParametersForConversationListFromConversation:conversationMock_];
    [[[conversationListParsedJSONResponseHandlerCreatorMock_ expect] andReturn:conversationListParsedJSONResponseHandlerMock_] createWithDelegate:conversationListCommandDelegateMock_];
    [[[conversationURLRequestBuilderCreatorMock_ expect] andReturn:conversationURLRequestBuilderMock_] createConversationListURLRequestBuilder];
    
    [[[commandErrorHandlerCreatorMock_ expect] andReturn:commandErrorHandlerMock_] createWithErrorHandler:nil];
    
    [[[mmcCommandInstanceFactoryMock_ expect] andReturn:commandMock_] createMMCCommandWithURLRequestBuilder:conversationURLRequestBuilderMock_ urlRequestParameters:requestParametersMock_ urlRequestData:nil jsonParser:jsonParserMock_ parsedJSONResponseHandler:conversationListParsedJSONResponseHandlerMock_ commandErrorHandler:commandErrorHandlerMock_];
    
    STAssertEquals(commandMock_, [conversationCommandFactory_ conversationListCommandForConversationsAfterConversation:conversationMock_ withDelegate:conversationListCommandDelegateMock_], @"Unexpected conversation list command");
    
    [self verifyMocks];
}

- (void)testCanConstructCommandToRetrieveListOfMostrecentMessagesForAConversation
{
    [[[mmcURLParametersCreatorMock_ expect] andReturn:requestParametersMock_] urlParametersForConversationMessageListFromMostRecentMessage];
    [[[conversationURLRequestBuilderCreatorMock_ expect] andReturn:conversationURLRequestBuilderMock_] createConversationMessageListURLRequestBuilderForMessagesInConversation:conversationMock_];
    [[[conversationMessageListParsedJSONResponseHandlerCreatorMock_ expect] andReturn:conversationMessageListParsedJSONResponseHandlerMock_] createWithDelegate:conversationMessageListCommandDelegateMock_];
    
    [[[conversationErrorHandlerFactoryMock_ expect] andReturn:conversationErrorHandlerMock_] conversationMessageListErrorHandlerWithConversation:conversationMock_];
    [[[commandErrorHandlerCreatorMock_ expect] andReturn:commandErrorHandlerMock_] createWithErrorHandler:conversationErrorHandlerMock_];
    
    [[[mmcCommandInstanceFactoryMock_ expect] andReturn:commandMock_] createMMCCommandWithURLRequestBuilder:conversationURLRequestBuilderMock_ urlRequestParameters:requestParametersMock_ urlRequestData:nil jsonParser:conversationMessageListJSONParserMock_ parsedJSONResponseHandler:conversationMessageListParsedJSONResponseHandlerMock_ commandErrorHandler:commandErrorHandlerMock_];
    
    STAssertEquals(commandMock_, [conversationCommandFactory_ conversationMessageListCommandForMostRecentMessagesInConversation:conversationMock_ 
                                                                                                                   withDelegate:conversationMessageListCommandDelegateMock_ 
                                                                                                            transactionDelegate:nil], @"Unexpected conversation message list command");
    
    [self verifyMocks];
}

- (void)testCanConstructCommandToRetrieveMessagesAfterAMessageForAConversation
{
    [[[mmcURLParametersCreatorMock_ expect] andReturn:requestParametersMock_] urlParametersForConversationMessageListFromMessage:messageMock_];
    [[[conversationURLRequestBuilderCreatorMock_ expect] andReturn:conversationURLRequestBuilderMock_] createConversationMessageListURLRequestBuilderForMessagesInConversation:conversationMock_];
    [[[conversationMessageListParsedJSONResponseHandlerCreatorMock_ expect] andReturn:conversationMessageListParsedJSONResponseHandlerMock_] createWithDelegate:conversationMessageListCommandDelegateMock_];
    
    [[[conversationErrorHandlerFactoryMock_ expect] andReturn:conversationErrorHandlerMock_] conversationMessageListErrorHandlerWithConversation:conversationMock_];
    [[[commandErrorHandlerCreatorMock_ expect] andReturn:commandErrorHandlerMock_] createWithErrorHandler:conversationErrorHandlerMock_];
    
    [[[mmcCommandInstanceFactoryMock_ expect] andReturn:commandMock_] createMMCCommandWithURLRequestBuilder:conversationURLRequestBuilderMock_ urlRequestParameters:requestParametersMock_ urlRequestData:nil jsonParser:conversationMessageListJSONParserMock_ parsedJSONResponseHandler:conversationMessageListParsedJSONResponseHandlerMock_ commandErrorHandler:commandErrorHandlerMock_];

    STAssertEquals(commandMock_, [conversationCommandFactory_ conversationMessageListCommandForMessagesAfterMessage:messageMock_ inConversation:conversationMock_ withDelegate:conversationMessageListCommandDelegateMock_], @"Unexpected conversation message list command");
    
    [self verifyMocks];
}

- (void)testCanConstructCommandToReplyToAConversationWithMessageBody
{
    NSString *messageBody = @"msg";
    
    [[[messageHandlerMock_ expect] andReturn:messageBody] bodyForMessage:messageMock_];
    
    [[[conversationReplyParsedJSONResponseHandlerCreatorMock_ expect] andReturn:conversationReplyParsedJSONResponseHandlerMock_] createWithMessage:messageMock_ delegate:conversationReplyCommandDelegateMock_];
    
    [[[conversationURLRequestBuilderCreatorMock_ expect] andReturn:conversationURLRequestBuilderMock_] createConversationReplyURLRequestBuilderForReplyingToConversation:conversationMock_];
    
    [[[conversationReplyRequestDataBuilderMock_ expect] andReturn:requestDataMock_] requestDataForReplyingToConversationWithMessageBody:messageBody];
    
    [[[mmcURLParametersCreatorMock_ expect] andReturn:requestParametersMock_] urlParametersForConversationReply];
    
    [[[conversationErrorHandlerFactoryMock_ expect] andReturn:conversationErrorHandlerMock_] conversationReplyErrorHandlerWithMessage:messageMock_];
    
    [[[commandErrorHandlerCreatorMock_ expect] andReturn:commandErrorHandlerMock_] createWithErrorHandler:conversationErrorHandlerMock_];
    
    [[[mmcCommandInstanceFactoryMock_ expect] andReturn:commandMock_] createMMCCommandWithURLRequestBuilder:conversationURLRequestBuilderMock_ urlRequestParameters:requestParametersMock_ urlRequestData:requestDataMock_ jsonParser:jsonParserMock_ parsedJSONResponseHandler:conversationReplyParsedJSONResponseHandlerMock_ commandErrorHandler:commandErrorHandlerMock_];
    
    STAssertEquals(commandMock_, [conversationCommandFactory_ conversationReplyCommandForConversation:conversationMock_ withMessage:messageMock_
                                                                                 withDelegate:conversationReplyCommandDelegateMock_],
                   @"Unexpected command");
    
    [self verifyMocks];
}

- (void)testCanConstructCommandToFlagMessagesAsReadInConversation
{
    NSArray *messageIDs = [NSArray arrayWithObjects:@"1", @"2", @"3", nil];

    [[[conversationURLRequestBuilderCreatorMock_ expect] andReturn:conversationURLRequestBuilderMock_]
     urlRequestBuilderToFlagMessagesInConversation:conversationMock_];
    [[[conversationFlagMessagesRequestDataBuilderMock_ expect] andReturn:requestDataMock_] requestDataToFlagMessagesAsRead:messageIDs];    
    [[[mmcURLParametersCreatorMock_ expect] andReturn:requestParametersMock_] urlParametersForFlaggingMessagesAsReadOrUnread];
    
    [[[conversationErrorHandlerFactoryMock_ expect] andReturn:conversationErrorHandlerMock_] conversationFlagMessagesAsReadErrorHandlerWithMessageIDs:messageIDs];
    
    [[[commandErrorHandlerCreatorMock_ expect] andReturn:commandErrorHandlerMock_] createWithErrorHandler:conversationErrorHandlerMock_];
    
    [[[mmcCommandInstanceFactoryMock_ expect] andReturn:commandMock_] createMMCCommandWithURLRequestBuilder:conversationURLRequestBuilderMock_ urlRequestParameters:requestParametersMock_ urlRequestData:requestDataMock_ jsonParser:jsonParserMock_ parsedJSONResponseHandler:nil commandErrorHandler:commandErrorHandlerMock_];

    STAssertEquals(commandMock_, [conversationCommandFactory_ conversationMessagesFlagAsReadCommandWithConversation:conversationMock_ messageIDs:messageIDs],
                   @"Unexpected command");
    
    [self verifyMocks];
}

- (void)verifyMocks
{
    [mmcCommandInstanceFactoryMock_ verify];
    [conversationMock_ verify];
    [messageMock_ verify];
    [conversationCreateCommandDelegateMock_ verify];
    [conversationListCommandDelegateMock_ verify];
    [conversationMessageListCommandDelegateMock_ verify];
    [requestDataMock_ verify];
    [requestParametersMock_ verify];
    [conversationHandlerMock_ verify];
    [urlRequestCreatorMock_ verify];
    [jsonParserMock_ verify];
    [conversationListParsedJSONResponseHandlerMock_ verify];
    [conversationListParsedJSONResponseHandlerCreatorMock_ verify];
    [mmcURLParametersCreatorMock_ verify];
    [conversationCreateRequestDataBuilderMock_ verify];
    [conversationCreateParsedJSONResponseHandlerMock_ verify];
    [conversationCreateParsedJSONResponseHandlerCreatorMock_ verify];
    [conversationURLRequestBuilderMock_ verify];
    [conversationURLRequestBuilderCreatorMock_ verify];
    [conversationMessageListParsedJSONResponseHandlerMock_ verify];
    [conversationMessageListParsedJSONResponseHandlerCreatorMock_ verify];
    [conversationReplyRequestDataBuilderMock_ verify];
    [conversationReplyParsedJSONResponseHandlerCreatorMock_ verify];
    [conversationFlagMessagesRequestDataBuilderMock_ verify];
    [commandErrorHandlerCreatorMock_ verify];
    [conversationErrorHandlerFactoryMock_ verify];
}

@end
