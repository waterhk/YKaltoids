//
//  YAParticipantAggregator.m
//  altoids
//
//  Created by Jon Herron on 2/14/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAParticipantAggregator.h"
#import "MutableDictionaryCreator.h"
#import "YAAddressInfo.h"
#import "YAConversationInfo.h"
#import "YAParticipantInfo.h"

@implementation YAParticipantAggregator

@synthesize mutableDictionaryCreator = mutableDictionaryCreator_;

- (NSDictionary *)participantInfosByAddressHandleInConverstationInfos:(NSArray *)conversationInfos
{
    NSMutableDictionary *participantsByAddressHandle = [[self mutableDictionaryCreator] mutableDictionaryWithCapacity:[conversationInfos count] * kMaxNumberOfParticipants];
    
    for (YAConversationInfo *conversation in conversationInfos) 
    {
        for (YAParticipantInfo *participant in [conversation participantInfos]) 
        {
            YAAddressInfo *participantAddress = [participant addressInfo];
            NSString *addressHandle = [participantAddress handle];
            
            if ([addressHandle length] == 0 || [participantsByAddressHandle objectForKey:addressHandle]) 
            {
                continue;
            }
            
            [participantsByAddressHandle setObject:participant forKey:addressHandle];
        }
    }
    
    return participantsByAddressHandle;
}

@end
