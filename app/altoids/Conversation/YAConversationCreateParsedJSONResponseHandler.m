//
//  YAConversationCreateParsedJSONResponseHandler.m
//  altoids
//
//  Created by Jon Herron on 10/4/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAConversationCreateParsedJSONResponseHandler.h"
#import "YAConversationInfo.h"
#import "YAMMCConversation.h"
#import "YASessionLogger.h"

@interface YAConversationCreateParsedJSONResponseHandler ()

@property (strong, nonatomic) id<ConversationHandler> conversationHandler;
@property (strong, nonatomic) id<MMCConversationToConversationInfoTranslator> mmcConversationToConversationInfoTranslator;
@property (strong, nonatomic) NSManagedObjectID *conversationObjectID;
@property (strong, nonatomic) id<ConversationCreateCommandDelegate> conversationCreateCommandDelegate;
@property (strong, nonatomic) id<MMCConversationErrorDetector> mmcConversationErrorDetector;
@property (strong, nonatomic) id<MMCErrorCreator> mmcErrorCreator;
@property (strong, nonatomic) id<ConversationErrorHandlerFactory> conversationErrorHandlerFactory;

- (void)handleErrorForMMCConversation:(YAMMCConversation *)theMMCConversation;

@end

@implementation YAConversationCreateParsedJSONResponseHandler

#pragma mark -
#pragma mark @synthesize

@synthesize conversationHandler = conversationHandler_;
@synthesize conversationObjectID = conversationObjectID_;
@synthesize conversationCreateCommandDelegate = conversationCreateCommandDelegate_;
@synthesize mmcConversationToConversationInfoTranslator = mmcConversationToConversationInfoTranslator_;
@synthesize mmcConversationErrorDetector = mmcConversationErrorDetector_;
@synthesize mmcErrorCreator = mmcErrorCreator_;
@synthesize conversationErrorHandlerFactory = conversationErrorHandlerFactory_;

#pragma mark -
#pragma mark Designated initializer

- (id)initWithConversationHandler:(id<ConversationHandler>)theConversationHandler 
mmcConversationToConversationInfoTranslator:(id<MMCConversationToConversationInfoTranslator>)theMMCConversationToConversationInfoTranslator 
     mmcConversationErrorDetector:(id<MMCConversationErrorDetector>)theMMCConversationErrorDetector 
                  mmcErrorCreator:(id<MMCErrorCreator>)theMMCErrorCreator
  conversationErrorHandlerFactory:(id<ConversationErrorHandlerFactory>)theConversationErrorHandlerFactory
                     conversation:(YAConversation *)theConversation 
                         delegate:(id<ConversationCreateCommandDelegate>)theConversationCreateCommandDelegate
{
  self = [super init];
    
  if (self) 
  {
      conversationHandler_ = theConversationHandler;
      conversationObjectID_ = [[self conversationHandler] conversationObjectIDForConversation:theConversation];
      mmcConversationToConversationInfoTranslator_ = theMMCConversationToConversationInfoTranslator;
      conversationCreateCommandDelegate_ = theConversationCreateCommandDelegate;
      mmcConversationErrorDetector_ = theMMCConversationErrorDetector;
      mmcErrorCreator_ = theMMCErrorCreator;
      conversationErrorHandlerFactory_ = theConversationErrorHandlerFactory;
  }
  
  return self;
}

#pragma mark -
#pragma mark ConversationCreateParsedJSONResponseHandler delegate methods

- (void)handleParsedJSONResponse:(NSDictionary *)aParsedJSONResponse
{
    YASessionLogDebug(@"Parsed JSON response: %@", aParsedJSONResponse);
    YALogInfo(@"Parsed JSON response: %@", aParsedJSONResponse);
    YAMMCConversation *mmcConversation = mmcConversation = [[YAMMCConversation alloc] initWithParsedJSONConversationResponse:aParsedJSONResponse];
    BOOL mmcConversationHasErrors = [[self mmcConversationErrorDetector] mmcConversationHasErrors:mmcConversation];
    if (mmcConversationHasErrors) 
    {
        [self handleErrorForMMCConversation:mmcConversation];
        
        return;
    }
    
    YAConversationInfo *newlyCreatedConversationInfo = [[self mmcConversationToConversationInfoTranslator] conversationInfoFromMMCConversation:mmcConversation];
    
    [[self conversationCreateCommandDelegate] conversationCreated:newlyCreatedConversationInfo fromLocalConversationWithObjectID:[self conversationObjectID]];
}

#pragma mark -
#pragma mark Private methods

- (void)handleErrorForMMCConversation:(YAMMCConversation *)theMMCConversation
{
    id<ErrorHandler> errorHandler;
    NSError *conversationError;
    
    conversationError = [[self mmcErrorCreator] errorFromMMCConversationErrors:[theMMCConversation errors]];
    errorHandler = [[self conversationErrorHandlerFactory] conversationCreateErrorHandlerWithConversationObjectID:[self conversationObjectID]];
    
    [errorHandler handleError:conversationError];
}

@end
