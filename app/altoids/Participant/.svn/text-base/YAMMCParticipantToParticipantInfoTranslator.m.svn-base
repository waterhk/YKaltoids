//
//  YAMMCParticipantToParticipantInfoTranslator.m
//  altoids
//
//  Created by Jon Herron on 9/20/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAMMCParticipantToParticipantInfoTranslator.h"

@implementation YAMMCParticipantToParticipantInfoTranslator

@synthesize addressInfoCreator = addressInfoCreator_;

- (YAParticipantInfo *)participantInfoFromMMCParticipant:(YAMMCParticipant *)anMMCParticipant withTransientID:(NSString *)theTransientID
{
    NSString *transientID = theTransientID ? theTransientID : [anMMCParticipant transientID];
    YAAddressInfo *addressInfo = [addressInfoCreator_ addressInfoWithMMCParticipant:anMMCParticipant];
    
    if (!addressInfo) 
    {
        YALogError(@"Error encountered when creating addressInfo from mmc response: %@ %@", [anMMCParticipant addressType], [anMMCParticipant address]);
        
        addressInfo = nil;
    }
    
    return [[YAParticipantInfo alloc] initWithParticipantID:[anMMCParticipant participantID] 
                                                  firstName:[anMMCParticipant firstName] 
                                                   lastName:[anMMCParticipant lastName]
                                                   imageURL:[anMMCParticipant imageURL]
                                                addressInfo:addressInfo
                                                  isContact:NO 
                                                  timestamp:[anMMCParticipant created] 
                                      isConversationCreator:[anMMCParticipant isConversationCreator] 
                                                     isUser:[anMMCParticipant isUser] 
                                                transientID:transientID];
}

@end
