//
//  YAConversationReplyParsedJSONResponseHandler.m
//  altoids
//
//  Created by Anand Biligiri on 10/27/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAConversationReplyParsedJSONResponseHandler.h"
#import "YAConversationReplyInfo.h"
#import "YAMMCConversationReply.h"
#import "YAMessage.h"
#import "YASessionLogger.h"

@interface YAConversationReplyParsedJSONResponseHandler ()

@property (nonatomic, strong) id<MMCConversationReplyToConversationReplyInfoTranslator> mmcConversationReplyToConversationReplyInfoTranslator;
@property (nonatomic, assign) id<ConversationReplyCommandDelegate> delegate;

@property (strong, nonatomic) YAMessage *message;

@end

@implementation YAConversationReplyParsedJSONResponseHandler

#pragma mark -
#pragma mark @synthesize

@synthesize mmcConversationReplyToConversationReplyInfoTranslator = mmcConversationReplyToConversationReplyInfoTranslator_;
@synthesize delegate = delegate_;

@synthesize message = message_;

#pragma mark -
#pragma mark Designated initializer

- (id)initWithMessage:(YAMessage *)message mmcConversationReplyToConversationReplyInfoTranslator:(id)mmcConversationReplyToConversationReplyInfoTranslator delegate:(id<ConversationReplyCommandDelegate>)delegate
{
  self = [super init];
  if (self) {
      message_ = message;
      mmcConversationReplyToConversationReplyInfoTranslator_ = mmcConversationReplyToConversationReplyInfoTranslator;
      delegate_ = delegate;
  }
  
  return self;
}

#pragma mark -
#pragma mark ParsedJSONResponseHandler methods

- (void)handleParsedJSONResponse:(NSDictionary *)aParsedJSONResponse
{
    YASessionLogDebug(@"Parsed JSON response: %@", aParsedJSONResponse);
    YALogInfo(@"Parsed JSON response: %@", aParsedJSONResponse);
    
    YAMMCConversationReply *conversationReply = [[YAMMCConversationReply alloc] initWithParsedJSONConversationReplyResponse:aParsedJSONResponse];
    YAConversationReplyInfo *conversationReplyInfo = [[self mmcConversationReplyToConversationReplyInfoTranslator] conversationReplyInfoFromMMCConversationReply:conversationReply];
    
    [[self delegate] repliedToConversationWithMessage:[self message] conversationReplyInfo:conversationReplyInfo];
}

@end
