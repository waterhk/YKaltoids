//
//  ContactLocator.h
//  altoids
//
//  Created by Jon Herron on 11/3/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YAContactEndpoint, YAParticipant, YAParticipantInfo;

@protocol ContactLocator <NSObject>
@required

- (YAContactEndpoint*) contactEndpointMatchingParticipant:(YAParticipant*)participant;
- (YAContactEndpoint*) contactEndpointMatchingParticipantInfo:(YAParticipantInfo*)participantInfo;

// returns [YAContactEndpoint*]
- (NSArray*) contactEndpointsBeginningWithString:(NSString*)typeaheadQuery;

@end
