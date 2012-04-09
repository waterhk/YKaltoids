//
//  ParticipantAggregator.h
//  altoids
//
//  Created by Jon Herron on 2/14/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ParticipantAggregator <NSObject>

- (NSDictionary *)participantInfosByAddressHandleInConverstationInfos:(NSArray *)conversationInfos;

@end
