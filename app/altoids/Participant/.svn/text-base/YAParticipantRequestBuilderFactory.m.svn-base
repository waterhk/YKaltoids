//
//  YAParticipantRequestBuilderFactory.m
//  altoids
//
//  Created by Robby Cahyadi Hendro Saputro on 8/26/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAParticipantRequestBuilderFactory.h"
#import <SBJson/SBJson.h>
#import "ServerConfiguration.h"
#import "YAParticipant.h"
#import "YAAddress.h"

// Private class extension
@interface YAParticipantRequestBuilderFactory ()

// @property definitions

// methods

@end

@implementation YAParticipantRequestBuilderFactory

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize serverConfiguration = serverConfiguration_;

// Class methods
#pragma mark -
#pragma mark Class methods

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

// Overrides
#pragma mark -
#pragma mark Overrides
- (NSURLRequest *)buildValidateParticipantsRequestWithParticipants:(NSArray *)participants
{
    NSURL *requestUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/participants?action=validateParticipants",[[self serverConfiguration] mmcServerHostname]]];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:requestUrl];
    
    [urlRequest setHTTPMethod:@"GET"];
    
    NSMutableArray *participantInfos = [NSMutableArray array];
    for (YAParticipant *participant in participants) {
        NSDictionary *participantInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                         [[participant address] handle], @"id",
                                         [participant firstName], @"firstname",
                                         [participant lastName], @"lastname",
                                         nil];
        [participantInfos addObject:participantInfo];
    }
    
    NSDictionary *body = [NSDictionary dictionaryWithObjectsAndKeys:participantInfos, @"participants", nil];

    SBJsonWriter *jsonWriter = [[SBJsonWriter alloc] init];
    NSData *data = [jsonWriter dataWithObject:body];
    [urlRequest setHTTPBody:data];
    
    return urlRequest;
}

// Delegate methods
#pragma mark -
#pragma mark <Protocol Name> delegate methods

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
#pragma mark YAParticipantRequestBuilderFactory ()

@end
