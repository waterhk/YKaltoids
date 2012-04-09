//
//  YAConversationMessageListParsedJSONResponseHandler.m
//  altoids
//
//  Created by Jon Herron on 10/18/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAConversationMessageListParsedJSONResponseHandler.h"
#import "YAConversationInfo.h"
#import "YAMMCConversation.h"
#import "YASessionLogger.h"
#import "ParsedJSONResponseFilterer.h"

@interface YAConversationMessageListParsedJSONResponseHandler ()

@property (strong, nonatomic) id<MMCConversationToConversationInfoTranslator> mmcConversationToConversationInfoTranslator;
@property (strong, nonatomic) id<ConversationMessageListCommandDelegate> conversationMessageListDelegate;
@property (strong, nonatomic) id<ParsedJSONResponseFilterer> parsedJSONResponseFilterer;

@end

@implementation YAConversationMessageListParsedJSONResponseHandler

#pragma mark -
#pragma mark @synthesize

@synthesize mmcConversationToConversationInfoTranslator = mmcConversationToConversationInfoTranslator_;
@synthesize conversationMessageListDelegate = conversationMessageListDelegate_;
@synthesize parsedJSONResponseFilterer = parsedJSONResponseFilterer_;

#pragma mark -
#pragma mark Designated initializer

- (id)initWithMMCConversationToConversationInfoTranslator:(id<MMCConversationToConversationInfoTranslator>)theMMCConversationToConversationInfoTranslator 
                   conversationMessageListCommandDelegate:(id<ConversationMessageListCommandDelegate>)theConversationMessageListCommandDelegate 
                               parsedJSONResponseFilterer:(id<ParsedJSONResponseFilterer>)aParsedJSONResponseFilterer
{
  self = [super init];
    
  if (self) 
  {
      mmcConversationToConversationInfoTranslator_ = theMMCConversationToConversationInfoTranslator;
      conversationMessageListDelegate_ = theConversationMessageListCommandDelegate;
      parsedJSONResponseFilterer_ = aParsedJSONResponseFilterer;
  }
  
  return self;
}

#pragma mark -
#pragma mark ParsedJSONREsponseHandler delegate methods

- (void)handleParsedJSONResponse:(NSDictionary *)aParsedJSONResponse
{
    YASessionLogDebug(@"Parsed JSON response: %@", [[self parsedJSONResponseFilterer] filteredStringFromParsedJSONResponse:aParsedJSONResponse]);
    YALogInfo(@"Parsed JSON response: %@", aParsedJSONResponse);
    
    YAMMCConversation *mmcConversation = [[YAMMCConversation alloc] initWithParsedJSONConversationResponse:aParsedJSONResponse];
    YAConversationInfo *conversationInfo = [[self mmcConversationToConversationInfoTranslator] conversationInfoFromMMCConversation:mmcConversation];
    
    [[self conversationMessageListDelegate] messageListRecievedForConversation:conversationInfo];
}

@end
