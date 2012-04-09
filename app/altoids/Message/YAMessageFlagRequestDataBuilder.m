//
//  YAMessageFlagRequestDataBuilder.m
//  altoids
//
//  Created by Jon Herron on 10/12/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAMessageFlagRequestDataBuilder.h"
#import "YAMessage.h"

#define kMessageFlagRequestDataElementsCount 2
#define kMessageFlagRequestMessageIDsKey @"mids"
#define kMessageFlagRequestReadFlagKey @"read"
#define kMessageFlagRequestReadFlagTrueValue @"True"
#define kMessageFlagRequestReadFlagFalseValue @"False"

// Private class extension
@interface YAMessageFlagRequestDataBuilder ()

// @property definitions
@property (strong, nonatomic) id<MessageHandler> messageHandler;
@property (strong, nonatomic) id<MutableArrayCreator> mutableArrayCreator;
@property (strong, nonatomic) id<MutableDictionaryCreator> mutableDictionaryCreator;

// methods
- (NSDictionary *)requestDataForFlaggingMessages:(NSArray *)theMessages asRead:(BOOL)theReadFlag;

@end

@implementation YAMessageFlagRequestDataBuilder

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize messageHandler = messageHandler_;
@synthesize mutableArrayCreator = mutableArrayCreator_;
@synthesize mutableDictionaryCreator = mutableDictionaryCreator_;

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

- (id)initWithMessageHandler:(id<MessageHandler>)theMessageHandler 
         mutableArrayCreator:(id<MutableArrayCreator>)theMutableArrayCreator 
    mutableDictionaryCreator:(id<MutableDictionaryCreator>)theMutableDictionaryCreator
{
  self = [super init];
    
  if (self) 
  {
      messageHandler_ = theMessageHandler;
      mutableArrayCreator_ = theMutableArrayCreator;
      mutableDictionaryCreator_ = theMutableDictionaryCreator;
  }
  
  return self;
}

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark MessageFlagRequestDataBuilder delegate methods

- (NSDictionary *)requestDataForFlaggingMessagesAsRead:(NSArray *)theMessages
{
    return [self requestDataForFlaggingMessages:theMessages asRead:YES];
}

- (NSDictionary *)requestDataForFlaggingMessagesAsUnread:(NSArray *)theMessages
{
    return [self requestDataForFlaggingMessages:theMessages asRead:NO];
}

// Public methods
#pragma mark -
#pragma mark Public methods

// Protected methods
#pragma mark -
#pragma mark Protected methods

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods
#pragma mark -
#pragma mark YAMessageFlagRequestDataBuilder ()

- (NSDictionary *)requestDataForFlaggingMessages:(NSArray *)theMessages asRead:(BOOL)theReadFlag
{
    NSMutableArray *messageIDs = [[self mutableArrayCreator] mutableArrayWithCapacity:[theMessages count]];
    NSMutableDictionary *requestData = [[self mutableDictionaryCreator] mutableDictionaryWithCapacity:kMessageFlagRequestDataElementsCount];
    NSString *readFlag = theReadFlag ? kMessageFlagRequestReadFlagTrueValue : kMessageFlagRequestReadFlagFalseValue;
    
    for (YAMessage *message in theMessages) 
    {
        [messageIDs addObject:[[self messageHandler] messageIDForMessage:message]];
    }
    
    [requestData setObject:messageIDs forKey:kMessageFlagRequestMessageIDsKey];
    [requestData setObject:readFlag forKey:kMessageFlagRequestReadFlagKey];
    
    return requestData;
}

@end
