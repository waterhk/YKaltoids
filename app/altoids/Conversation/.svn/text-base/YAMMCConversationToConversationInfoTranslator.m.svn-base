//
//  YAMMCConversationToConversationInfoTranslator.m
//  altoids
//
//  Created by Jon Herron on 9/19/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAMMCConversationToConversationInfoTranslator.h"
#import "YAMMCRecentMessage.h"

@interface YAMMCConversationToConversationInfoTranslator ()

@end

@implementation YAMMCConversationToConversationInfoTranslator

@synthesize mmcMessageToMessageInfoTranslator = mmcMessageToMessageInfoTranslator_;
@synthesize mmcParticipantToParticipantInfoTranslator = mmcParticipantToParticipantInfoTranslator_;
@synthesize mutableArrayCreator = mutableArrayCreator_;
@synthesize mutableDictionaryCreator = mutableDictionaryCreator_;
@synthesize arrayFilterer = arrayFilterer_;

//todo: refactor this
- (YAConversationInfo *)conversationInfoFromMMCConversation:(YAMMCConversation *)anMMCConversation
{
    NSArray *mmcMessages = nil;
    NSArray *mmcParticipants = nil;
    NSDictionary *mmcParticipantTransientIDMap = nil;
    NSMutableArray *messageInfos = nil;
    NSMutableArray *participantInfos = nil;
    NSMutableDictionary *participantInfosByTransientID = nil;
    NSString *transientID = nil;
    NSUInteger mmcMessagesCount = 0;
    NSUInteger mmcParticipantsCount = 0;
    YAMessageInfo *mostRecentMessageInfo = nil;
    YAMMCRecentMessage *mmcRecentMessage = nil;
    YAParticipantInfo *participant = nil;
    YAParticipantInfo *sender = nil;
    
    mmcMessages = [anMMCConversation messages];
    mmcParticipants = [anMMCConversation participants];
    mmcRecentMessage = [anMMCConversation recentMessage];
    mmcParticipantTransientIDMap = [anMMCConversation participantIDToTransientIDMap];
    
    if (mmcParticipantTransientIDMap) 
    {
        participantInfosByTransientID = [[self mutableDictionaryCreator] mutableDictionaryWithCapacity:[mmcParticipantTransientIDMap count]];
    }
    
    if ((mmcParticipantsCount = [mmcParticipants count]) > 0) 
    {
        participantInfos = [[self mutableArrayCreator] mutableArrayWithCapacity:mmcParticipantsCount];
        
        for (YAMMCParticipant *mmcParticipant in mmcParticipants) 
        {
            transientID = [mmcParticipantTransientIDMap objectForKey:[mmcParticipant participantID]];
            
            participant = [[self mmcParticipantToParticipantInfoTranslator] participantInfoFromMMCParticipant:mmcParticipant withTransientID:transientID];
            
            if ([mmcParticipant isConversationCreator]) 
            {
                sender = participant;
            }
            
            [participantInfos addObject:participant];
            
            if (transientID) 
            {
                [participantInfosByTransientID setObject:participant forKey:transientID];
            }
        }
    }
    
    if (mmcRecentMessage) 
    {
        NSArray *nameParts = [self namePartsForSenderOfMostRecentMessage:mmcRecentMessage];
        NSString *firstName = nil;
        NSString *lastName = nil;
        NSPredicate *predicate = nil;
        
        if ([nameParts count]==1) {
            firstName = [nameParts objectAtIndex:0];
            predicate = [NSPredicate predicateWithFormat:@"firstName == '%@'", firstName];
        }
        else if([nameParts count]==2) {
            firstName = [nameParts objectAtIndex:0];
            lastName = [nameParts objectAtIndex:1];
            predicate = [NSPredicate predicateWithFormat:@"firstName == '%@' AND lastName == '%@'", firstName, lastName];
        }
                
        if (predicate) 
        {
            NSArray *senderParticipantInfo = [[self arrayFilterer] filterArray:participantInfos usingPredicate:predicate];
            
            if ([senderParticipantInfo count] > 0) 
            {
                sender = [senderParticipantInfo objectAtIndex:0];
            }
        }
        
        mostRecentMessageInfo = [[self mmcMessageToMessageInfoTranslator] messageInfoFromMMCRecentMessage:mmcRecentMessage withSender:sender];
    }
    
    if ((mmcMessagesCount = [mmcMessages count]) > 0) 
    {
        messageInfos = [[self mutableArrayCreator] mutableArrayWithCapacity:mmcMessagesCount];
        
        for (YAMMCMessage *mmcMessage in mmcMessages) 
        {
            [messageInfos addObject:[[self mmcMessageToMessageInfoTranslator] messageInfoFromMMCMessage:mmcMessage]];
        }
    }
    
    return [[YAConversationInfo alloc] initWithConversationID:[anMMCConversation conversationID] 
                                                       status:YAConversationStatusSaved 
                                                    timestamp:[mostRecentMessageInfo timestamp]
                                                        topic:[anMMCConversation topic] 
                                                totalMessages:[anMMCConversation totalMessages] 
                                               unreadMessages:[anMMCConversation unreadMessages] 
                                      conversationContextInfo:nil 
                                                 messageInfos:messageInfos 
                                             participantInfos:participantInfos 
                                participantInfosByTransientID:participantInfosByTransientID 
                                                       sender:sender 
                                        mostRecentMessageInfo:mostRecentMessageInfo
                                            userIsParticipant:[anMMCConversation userIsParticipant]];
}

- (NSArray *)namePartsForSenderOfMostRecentMessage:(YAMMCRecentMessage *)mostRecentMessage
{
    NSString *senderName = [mostRecentMessage sender];
    
    if (!senderName) 
    {
        return nil;
    }
    
    NSRange rangeOfFirstSpace = [senderName rangeOfString:@" "];
    
    if (rangeOfFirstSpace.location == NSNotFound || rangeOfFirstSpace.location + 1 == [senderName length]) 
    {
        return [NSArray arrayWithObject:senderName];
    }
    
    NSString *firstName = [senderName substringToIndex:rangeOfFirstSpace.location];
    NSString *lastName = [senderName substringFromIndex:rangeOfFirstSpace.location + 1];
    
    return [NSArray arrayWithObjects:firstName, lastName, nil];
}

@end
