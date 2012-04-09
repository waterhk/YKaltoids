//
//  YAAddressMetaDataUpdater.m
//  altoids
//
//  Created by Jon Herron on 2/14/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAAddressMetaDataUpdater.h"
#import "AddressMetaDataHandler.h"
#import "AddressMetaDataRepository.h"
#import "AddressTypeDetector.h"
#import "ParticipantAggregator.h"
#import "YAAddressMetaData.h"
#import "YAParticipantInfo.h"

@implementation YAAddressMetaDataUpdater

@synthesize addressMetaDataHandler = addressMetaDataHandler_; 
@synthesize addressMetaDataRepository = addressMetaDataRepository_;
@synthesize addressTypeDetector = addressTypeDetector_;
@synthesize participantAggregator = participantAggregator_;

- (void)updateAddressMetaDataForParticipantInfosInConversationInfo:(YAConversationInfo *)conversationInfo inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    return [self updateAddressMetaDataForParticipantInfosInConversationInfos:[NSArray arrayWithObject:conversationInfo] inManagedObjectContext:managedObjectContext];
}

- (void)updateAddressMetaDataForParticipantInfosInConversationInfos:(NSArray *)conversationInfos inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    NSDictionary *participantInfosByAddressHandle = [[self participantAggregator] participantInfosByAddressHandleInConverstationInfos:conversationInfos];
    NSArray *addressHandles = [participantInfosByAddressHandle allKeys];
    
    NSDictionary *addressMetaDatasByHandle = [[self addressMetaDataRepository] addressMetaDatasByHandleForHandles:addressHandles inManagedObjectContext:managedObjectContext];
    
    for (NSString *addressHandle in addressHandles) 
    {
        YAAddressMetaData *addressMetaData = [addressMetaDatasByHandle objectForKey:addressHandle];
        
        if (!addressMetaData) 
        {
            continue;
        }
        
        YAParticipantInfo *participantInfo = [participantInfosByAddressHandle objectForKey:addressHandle];
        YAAddressInfo *participantAddress = [participantInfo addressInfo];
        
        if ([[self addressTypeDetector] isMMCAddressInfoWithSMSAddressHandle:participantAddress]) 
        {
            [[self addressMetaDataHandler] setHandleIsHub:YES forAddressMetaData:addressMetaData];
            [[self addressMetaDataHandler] setHandleIsValidSMS:YES forAddressMetaData:addressMetaData];
        }
        else if([[self addressTypeDetector] isMMCAddressInfo:participantAddress])
        {
            [[self addressMetaDataHandler] setHandleIsHub:YES forAddressMetaData:addressMetaData];
        }
        else if([[self addressTypeDetector] isSMSAddressInfo:participantAddress])
        {
            [[self addressMetaDataHandler] setHandleIsValidSMS:YES forAddressMetaData:addressMetaData];
        }
    }
}

@end
