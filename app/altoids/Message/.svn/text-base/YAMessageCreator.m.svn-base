//
//  YAMessageCreator.m
//  altoids
//
//  Created by Xianzhe Ma on 4/2/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAMessageCreator.h"
#import "MessageHandler.h"

@interface YAMessageCreator ()

@property (nonatomic, strong) id<MessageHandler> messageHandler;

/*
 @property (nonatomic, retain) NSString * body;
 @property (nonatomic, retain) NSString * messageID;
 @property (nonatomic, retain) NSNumber * read;
 @property (nonatomic, retain) NSString * snippet;
 @property (nonatomic, retain) NSDate * timestamp;
 @property (nonatomic, retain) NSNumber * status;
 @property (nonatomic, retain) YAConversation *conversation;
 @property (nonatomic, retain) YAConversation *mostRecentForConversation;
 @property (nonatomic, retain) YAParticipant *sender;
 */

- (YAMessage *)createBrandNewMessageInManagedObjectContext:(NSManagedObjectContext *)aManagedObjectContext 
                                   withMessageBody:(NSString *)aMessageBody 
                                         messageID:(NSString *)aMessageID 
                                        readStatus:(BOOL)aReadStatus 
                                           snippet:(NSString *)aSnippet 
                                         timestamp:(NSDate *)aTimestamp 
                                            status:(YAMessageStatus)aStatus 
                                      conversation:(YAConversation *)aConversation 
                         mostRecentForConversation:(YAConversation *)aMostRecentForConversation 
                                            sender:(YAParticipant *)aSender;

@end

@implementation YAMessageCreator

@synthesize messageHandler = messageHandler_;

- (id)initWithMessageHandler:(id<MessageHandler>)aMessageHandler
{
    if (self = [super init]) {
        messageHandler_ = aMessageHandler;
    }
    return self;
}

- (YAMessage *)createMessageForReplyingToConversation:(YAConversation *)aConversation withMessageBody:(NSString *)aMessageBodyString sender:(YAParticipant *)aSender
{
    return [self createBrandNewMessageInManagedObjectContext:[aConversation managedObjectContext] 
                                             withMessageBody:aMessageBodyString 
                                                   messageID:nil 
                                                  readStatus:YES 
                                                     snippet:aMessageBodyString 
                                                   timestamp:nil 
                                                      status:YAMessageStatusPending 
                                                conversation:aConversation 
                                   mostRecentForConversation:aConversation 
                                                      sender:aSender];
}

- (YAMessage *)createMessageForNewConversation:(YAConversation *)aConversation withMessageBody:(NSString *)aMessageBody
{
    //TODO: should the status be NEW?
    return [self createBrandNewMessageInManagedObjectContext:[aConversation managedObjectContext] 
                                             withMessageBody:aMessageBody 
                                                   messageID:nil 
                                                  readStatus:YES 
                                                     snippet:aMessageBody 
                                                   timestamp:nil 
                                                      status:YAMessageStatusNew 
                                                conversation:aConversation 
                                   mostRecentForConversation:aConversation 
                                                      sender:[aConversation sender]];
}

- (YAMessage *)createBrandNewMessageInManagedObjectContext:(NSManagedObjectContext *)aManagedObjectContext 
                                   withMessageBody:(NSString *)aMessageBody 
                                         messageID:(NSString *)aMessageID 
                                        readStatus:(BOOL)aReadStatus 
                                           snippet:(NSString *)aSnippet 
                                         timestamp:(NSDate *)aTimestamp 
                                            status:(YAMessageStatus)aStatus 
                                      conversation:(YAConversation *)aConversation 
                         mostRecentForConversation:(YAConversation *)aMostRecentForConversation 
                                            sender:(YAParticipant *)aSender
{
    YAMessage *message = [[self messageHandler] createMessageEntityInManagedObjectContext:aManagedObjectContext];
    [[self messageHandler] setBody:aMessageBody forMessage:message];
    [[self messageHandler] setMessageID:aMessageID forMessage:message];
    [[self messageHandler] setRead:aReadStatus forMessage:message];
    [[self messageHandler] setSnippet:aSnippet forMessage:message];
    
    //When timestamp is nil, then awakeFromInsert will automatically set it to current datetime.
    if (aTimestamp) {
        [[self messageHandler] setTimestamp:aTimestamp forMessage:message];
    }
    
    [[self messageHandler] setStatus:aStatus forMessage:message];
    [[self messageHandler] setParticipantAsSender:aSender ofMessage:message];
    
    //TODO: What happened to :conversation and :mostRecentForConversation?
    
    return message;
}

@end
