//
//  YAParticipantTransientIDFormatter.m
//  altoids
//
//  Created by Jon Herron on 10/5/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAParticipantTransientIDFormatter.h"
#import "AddressHandleFormatter.h"
#import "ParticipantHandler.h"
#import "YAAddress.h"
#import "YAParticipant.h"

@implementation YAParticipantTransientIDFormatter

@synthesize addressHandleFormatter = addressHandleFormatter_;
@synthesize participantHandler = participantHandler_;

- (NSString *)transientIDForParticipant:(YAParticipant *)theParticipant
{
    YAAddress *participantAddress = [[self participantHandler] addressForParticipant:theParticipant];    
    if (!participantAddress)
    {
        return nil;
    }
    
    return [addressHandleFormatter_ formatAddressHandleForServerRequest:participantAddress];
}

@end
