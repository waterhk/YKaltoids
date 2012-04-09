//
//  YAConversationEditParsedJSONResponseHandler.m
//  altoids
//
//  Created by Jon Herron on 10/31/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAConversationEditParsedJSONResponseHandler.h"
#import "YAMMCConversation.h"
#import "YAConversationInfo.h"
#import "YASessionLogger.h"

@interface YAConversationEditParsedJSONResponseHandler ()

// @property definitions
@property (strong, nonatomic) id<MMCConversationToConversationInfoTranslator> mmcConversationToConversationInfoTranslator;
@property (strong, nonatomic) id<ConversationEditCommandDelegate> conversationEditCommandDelegate;
@property (strong, nonatomic) YAConversation *conversation;

@end

@implementation YAConversationEditParsedJSONResponseHandler

#pragma mark -
#pragma mark @synthesize
@synthesize mmcConversationToConversationInfoTranslator = mmcConversationToConversationInfoTranslator_;
@synthesize conversationEditCommandDelegate = conversationEditCommandDelegate_;
@synthesize conversation = conversation_;

#pragma mark -
#pragma mark Designated initializer

- (id)initWithMMCConversationToConversationInfoTranslator:(id<MMCConversationToConversationInfoTranslator>)theMMCConversationToConversationInfoTranslator 
                          conversationEditCommandDelegate:(id<ConversationEditCommandDelegate>)theConversationEditCommandDelegate 
                                             conversation:(YAConversation *)theConversation
{
  self = [super init];
    
  if (self) 
  {
      mmcConversationToConversationInfoTranslator_ = theMMCConversationToConversationInfoTranslator;
      conversationEditCommandDelegate_ = theConversationEditCommandDelegate;
      conversation_ = theConversation;
  }
  
  return self;
}

#pragma mark -
#pragma mark ConversationEditParsedJSONResponseHandler delegate methods

- (void)handleParsedJSONResponse:(NSDictionary *)aParsedJSONResponse
{
    YASessionLogDebug(@"Parsed JSON response: %@", aParsedJSONResponse);
    YALogInfo(@"Parsed JSON response: %@", aParsedJSONResponse);
    
    YAMMCConversation *mmcConversation = [[YAMMCConversation alloc] initWithParsedJSONConversationResponse:aParsedJSONResponse];
    YAConversationInfo *conversationInfo = [[self mmcConversationToConversationInfoTranslator] conversationInfoFromMMCConversation:mmcConversation];
    
    [[self conversationEditCommandDelegate] conversationEditProducedUpatedConversationInfo:conversationInfo fromExistingConversation:[self conversation]];
}

@end
