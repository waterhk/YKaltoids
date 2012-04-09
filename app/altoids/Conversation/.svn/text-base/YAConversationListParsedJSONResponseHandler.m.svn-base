//
//  YAConversationListParsedJSONResponseHandler.m
//  altoids
//
//  Created by Jon Herron on 9/16/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAConversationListParsedJSONResponseHandler.h"
#import "MMCConversationToConversationInfoTranslator.h"
#import "ConversationListCommandErrorHandler.h"
#import "ConversationListCommandDelegate.h"
#import "ParsedJSONResponseFilterer.h"
#import "YAConversationInfo.h"
#import "YAMMCConversation.h"
#import "YAMMCConversations.h"
#import "YASessionLogger.h"

@interface YAConversationListParsedJSONResponseHandler ()

@property (strong, nonatomic) id<ConversationListCommandDelegate> conversationCommandListDelegate;
@property (strong, nonatomic) id<MMCConversationToConversationInfoTranslator> mmcConversationToConversationInfoTranslator;
@property (strong, nonatomic) id<ConversationListCommandErrorHandler> conversationListCommandErrorHandler;
@property (strong, nonatomic) id<ParsedJSONResponseFilterer> parsedJSONResponseFilterer;

@end

@implementation YAConversationListParsedJSONResponseHandler

#pragma mark -
#pragma mark @synthesize

@synthesize conversationCommandListDelegate = conversationCommandListDelegate_;
@synthesize mmcConversationToConversationInfoTranslator = mmcConversationToConversationInfoTransltor_;
@synthesize conversationListCommandErrorHandler = conversationListCommandErrorHandler_;
@synthesize parsedJSONResponseFilterer = parsedJSONResponseFilterer_;

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

- (id)initWithMMCConversationToConversationInfoTranslator:(id<MMCConversationToConversationInfoTranslator>)anMMCConversationToConversationInfoTranslator 
                      conversationListCommandErrorHandler:(id<ConversationListCommandErrorHandler>)theConversationListCommandErrorHandler 
                          conversationListCommandDelegate:(id<ConversationListCommandDelegate>)aConversationListCommandDelegate parsedJSONResponseFilterer:(id<ParsedJSONResponseFilterer>)aParsedJSONResponseFilterer
{
  self = [super init];
    
  if (self) 
  {
      conversationCommandListDelegate_ = aConversationListCommandDelegate;
      mmcConversationToConversationInfoTransltor_ = anMMCConversationToConversationInfoTranslator;
      conversationListCommandErrorHandler_ = theConversationListCommandErrorHandler;
      parsedJSONResponseFilterer_ = aParsedJSONResponseFilterer;
  }
  
  return self;
}

#pragma mark -
#pragma mark ParsedJSONResponseHandler delegate methods

- (void)handleParsedJSONResponse:(NSDictionary *)aParsedJSONResponse
{
    YASessionLogDebug(@"Parsed JSON response: %@", [[self parsedJSONResponseFilterer] filteredStringFromParsedJSONResponse:aParsedJSONResponse]);
    YALogInfo(@"Parsed JSON response: %@", aParsedJSONResponse);
    
    YAMMCConversations *conversationsFacade = [[YAMMCConversations alloc] initWithParsedJSONConversationsResponse:aParsedJSONResponse];
    NSMutableArray *conversations = [NSMutableArray arrayWithCapacity:[[conversationsFacade conversations] count]];
    
    NSError *error;
    for (YAMMCConversation *conversationFacade in [conversationsFacade conversations]) 
    {
        if ([[self conversationListCommandErrorHandler] mmcConversationHasError:conversationFacade error:&error]) 
        {
            [[self conversationListCommandErrorHandler] handleError:error forMMCConversation:conversationFacade];
            
            continue;
        }
        
        YAConversationInfo *conversationInfo = [[self mmcConversationToConversationInfoTranslator] conversationInfoFromMMCConversation:conversationFacade];
        
        if (conversationInfo) 
        {
            [conversations addObject:conversationInfo];
        }
        else
        {
            YALogError(@"Failed to translate mmc conversation to conversationInfo");
        }
    }
    
    [[self conversationCommandListDelegate] conversationListRecieved:conversations conversationIDs:[conversationsFacade conversationIDs] moreConversationsPresentOnServer:[conversationsFacade moreConversationsAvailableOnServer]];
}

@end
