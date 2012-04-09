//
//  YASystemMessageDescriptionBuilder.m
//  altoids
//
//  Created by Srinivas Raovasudeva on 11/1/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YASystemMessageDescriptionBuilder.h"

#define kSystemMessageTypeKey @"operation"
#define kConversationParticipantsKey @"conversation.mgrData.participants"
#define kRemovedParticipantsKey @"convEdits.removedParticipants"
#define kAddedParticipantsKey @"convEdits.addedParticipants"
#define kMessageSenderPIDKey @"sender.pid"

#define kSystemMessageConversationEdit @"conv-edit"
#define kSystemMessageConversationLeave @"conv-leave"
#define kSystemMessageConversationDelete @"conv-delete"
#define kSystemMessageConversationMigrate @"conv-migrate"
#define kSystemMessageConversationSystemMessage @"conv-sysmsg"

#define kSystemMessageNotImplemented @"System message not implemented"

// Private class extension
@interface YASystemMessageDescriptionBuilder ()

// @property definitions

@property (strong, nonatomic) NSString *systemMessage;
@property (copy, nonatomic) NSDictionary *canonicalMessageData;
@property (strong, nonatomic) id<MMCParticipantToParticipantInfoTranslator> mmcParticipantToParticipantInfoTranslator;
@property (strong, nonatomic) id<ParticipantNameFormatter> participantNameFormatter;
@property (strong, nonatomic) id<MutableArrayCreator> mutableArrayCreator;
@property (strong, nonatomic) id<ParticipantDescriptionBuilder> participantDescriptionBuilder;

// methods

- (NSString *)buildSystemMessageFromCanonicalMessageData;

- (NSString *)buildSystemMessageForConversationEdit;
- (NSString *)buildSystemMessageForConversationLeave;
- (NSString *)buildSystemMessageForConversationDelete;
- (NSString *)buildSystemMessageForConversationMigrate;
- (NSString *)buildSystemMessageForConversationSystemMessage;

- (NSString *)messageSender;

@end

@implementation YASystemMessageDescriptionBuilder

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize systemMessage = systemMessage_;
@synthesize canonicalMessageData = canonicalMessageData_;
@synthesize mmcParticipantToParticipantInfoTranslator = mmcParticipantToParticipantInfoTranslator_;
@synthesize participantNameFormatter = participantNameFormatter_;
@synthesize mutableArrayCreator = mutableArrayCreator_;
@synthesize participantDescriptionBuilder = participantDescriptionBuilder_;

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

- (id)initWithCanonicalMessageData:(NSDictionary *)theCanonicalMessageData 
mmcParticipantToParticipantInfoTranslator:(id<MMCParticipantToParticipantInfoTranslator>)anMMCParticipantToParticipantInfoTranslator
          participantNameFormatter:(id<ParticipantNameFormatter>)aParticipantNameFormatter
               mutableArrayCreator:(id<MutableArrayCreator>)aMutableArrayCreator
     participantDescriptionBuilder:(id<ParticipantDescriptionBuilder>)aParticipantDescriptionBuilder
{
    self = [super init];
    if (self) {
        // Initialization code here.
        canonicalMessageData_ = [theCanonicalMessageData copy];
        mmcParticipantToParticipantInfoTranslator_ = anMMCParticipantToParticipantInfoTranslator;
        participantNameFormatter_ = aParticipantNameFormatter;
        mutableArrayCreator_ = aMutableArrayCreator;
        participantDescriptionBuilder_ = aParticipantDescriptionBuilder;
    }
    
    return self;
}

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark <Protocol Name> delegate methods

// Public methods
#pragma mark -
#pragma mark Public methods

- (BOOL)isSystemMessage
{
    NSString *systemMessageType = [[self canonicalMessageData] valueForKey:kSystemMessageTypeKey];
    
    return ([systemMessageType isEqualToString:kSystemMessageConversationEdit] ||
            [systemMessageType isEqualToString:kSystemMessageConversationLeave] ||
            [systemMessageType isEqualToString:kSystemMessageConversationDelete] ||
            [systemMessageType isEqualToString:kSystemMessageConversationMigrate] ||            
            [systemMessageType isEqualToString:kSystemMessageConversationSystemMessage]);
}

- (NSString *)systemMessage
{
    if ([self isSystemMessage] && !systemMessage_) {
        // build system message from canonical message data
        [self setSystemMessage:[self buildSystemMessageFromCanonicalMessageData]];
    }
    
    return systemMessage_;
}

// Protected methods
#pragma mark -
#pragma mark Protected methods

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods
#pragma mark -
#pragma mark YASystemMessageDescriptionBuilder ()

- (NSString *)buildSystemMessageFromCanonicalMessageData
{
    NSString *systemMessageType = [[self canonicalMessageData] valueForKey:kSystemMessageTypeKey];
    
    if ([systemMessageType isEqualToString:kSystemMessageConversationEdit]) {
        return [self buildSystemMessageForConversationEdit];        
    } else if ([systemMessageType isEqualToString:kSystemMessageConversationLeave]) {
        return [self buildSystemMessageForConversationLeave];        
    } else if ([systemMessageType isEqualToString:kSystemMessageConversationDelete]) {
        return [self buildSystemMessageForConversationDelete];
    } else if ([systemMessageType isEqualToString:kSystemMessageConversationMigrate]) {
        return [self buildSystemMessageForConversationMigrate];
    } else if ([systemMessageType isEqualToString:kSystemMessageConversationSystemMessage]) {
        return [self buildSystemMessageForConversationSystemMessage];
    }
    
    return kUnknownSystemMessage;
}

- (NSString *)buildSystemMessageForConversationEdit
{
    NSArray *addedParticipants = [[self canonicalMessageData] valueForKeyPath:kAddedParticipantsKey];
    NSArray *removedParticipants = [[self canonicalMessageData] valueForKeyPath:kRemovedParticipantsKey];
    NSString *affectedParticipantsDescription;
    NSString *senderDisplayName = [self messageSender];
    
    NSString *result = nil;
    
    if ([addedParticipants count] > 0) {
        NSMutableArray *addedParticipantInfoList = [[self mutableArrayCreator] mutableArrayWithCapacity:[addedParticipants count]];

        NSString *predicateFormat = @"";
        NSUInteger index = 0;
        NSUInteger count = [addedParticipants count];
        
        for (NSDictionary *participantIdInfo in addedParticipants) {
            predicateFormat = [predicateFormat stringByAppendingFormat:@"pid=='%@'",[participantIdInfo valueForKey:@"pid"]];
            predicateFormat = (index < count-1) ? [predicateFormat stringByAppendingString:@" OR "] : predicateFormat;
        }
        
        NSArray *conversationParticipants = [[self canonicalMessageData] valueForKeyPath:kConversationParticipantsKey];
        NSArray *addedParticipantsInfoArray = [conversationParticipants filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:predicateFormat]];
        
        for (NSDictionary *addedParticipant in addedParticipantsInfoArray) {
            YAMMCParticipant *mmcParticipant = [[YAMMCParticipant alloc] initWithParsedJSONParticipantResponse:addedParticipant];
            YAParticipantInfo *participantInfo = [[self mmcParticipantToParticipantInfoTranslator] participantInfoFromMMCParticipant:mmcParticipant withTransientID:nil];
            [addedParticipantInfoList addObject:participantInfo];
        }
        
        if ([addedParticipantInfoList count] > 0) {
            affectedParticipantsDescription = [[self participantDescriptionBuilder] descriptionForParticipantInfos:addedParticipantInfoList sizeWithFont:[UIFont systemFontOfSize:kDefaultFontSize] constraintedToSize:CGSizeMake(kDefaultWidth, kMaxHeight)];
            
            result = [NSString stringWithFormat:kAddedParticipantSystemMessage,senderDisplayName,affectedParticipantsDescription];
        }
    }
        
    if ([removedParticipants count] > 0) {
        NSMutableArray *removedParticipantInfoList = [[self mutableArrayCreator] mutableArrayWithCapacity:[removedParticipants count]];
        
        for (NSDictionary *removedParticipant in removedParticipants) {
            YAMMCParticipant *mmcParticipant = [[YAMMCParticipant alloc] initWithParsedJSONParticipantResponse:removedParticipant];
            YAParticipantInfo *participantInfo = [[self mmcParticipantToParticipantInfoTranslator] participantInfoFromMMCParticipant:mmcParticipant withTransientID:nil];
            [removedParticipantInfoList addObject:participantInfo];
        }
        
        if ([removedParticipantInfoList count] > 0) {
            if ([result length] > 0) {
                result = [result stringByAppendingFormat:kAddRemoveParticipantConjunction,[[self participantDescriptionBuilder] descriptionForParticipantInfos:removedParticipantInfoList sizeWithFont:[UIFont systemFontOfSize:kDefaultFontSize] constraintedToSize:CGSizeMake(kDefaultWidth, kMaxHeight)]];
            }
            else {
                result = [NSString stringWithFormat:kRemovedParticipantSystemMessage,senderDisplayName,[[self participantDescriptionBuilder] descriptionForParticipantInfos:removedParticipantInfoList sizeWithFont:[UIFont systemFontOfSize:kDefaultFontSize] constraintedToSize:CGSizeMake(kDefaultWidth, kMaxHeight)]];
            }
        }
    }
    
    return result;
}

- (NSString *)buildSystemMessageForConversationLeave
{
    NSArray *removedParticipants = [[self canonicalMessageData] valueForKeyPath:kRemovedParticipantsKey];
    NSString *result = nil;
    
    if ([removedParticipants count] > 0) {        
        
        for (NSDictionary *removedParticipant in removedParticipants) {
            YAMMCParticipant *mmcParticipant = [[YAMMCParticipant alloc] initWithParsedJSONParticipantResponse:removedParticipant];
            YAParticipantInfo *participantInfo = [[self mmcParticipantToParticipantInfoTranslator] participantInfoFromMMCParticipant:mmcParticipant withTransientID:nil];
            NSString *removedParticipantDisplayName = [[self participantNameFormatter] formatDisplayNameForParticipantInfo:participantInfo];
            
            if (!result) {
                result = [NSString stringWithFormat:@"%@\n",removedParticipantDisplayName,kLeftConversationSystemMessage];
            }
            else {
                result = [result stringByAppendingFormat:@"%@\n",removedParticipantDisplayName,kLeftConversationSystemMessage];
            }
        }        
    }

    return result;
}

- (NSString *)buildSystemMessageForConversationDelete
{
    return kConversationDeletedSystemMessage;
}

- (NSString *)buildSystemMessageForConversationMigrate
{
    return [NSString stringWithFormat:kConversationMigrateSystemMessage,[self messageSender]];
}

- (NSString *)buildSystemMessageForConversationSystemMessage
{
    return kSystemMessageNotImplemented;
}

- (NSString *)messageSender
{
    NSString *senderPID = [[self canonicalMessageData] valueForKeyPath:kMessageSenderPIDKey];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"pid==%@",senderPID];
    NSArray *conversationParticipants = [[self canonicalMessageData] valueForKeyPath:kConversationParticipantsKey];
    NSArray *senderInfoArray = [conversationParticipants filteredArrayUsingPredicate:predicate];
    
    NSAssert([senderInfoArray count]==1, @"Sender not found");
    
    YAMMCParticipant *mmcSender = [[YAMMCParticipant alloc] initWithParsedJSONParticipantResponse:[senderInfoArray objectAtIndex:0]];
    YAParticipantInfo *senderInfo = [[self mmcParticipantToParticipantInfoTranslator] participantInfoFromMMCParticipant:mmcSender withTransientID:nil];
    NSString *senderDisplayName = [[self participantNameFormatter] formatDisplayNameForParticipantInfo:senderInfo];
    
    return senderDisplayName;
}

@end
