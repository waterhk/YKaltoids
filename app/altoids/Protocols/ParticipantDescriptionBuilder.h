//
//  ParticipantDescriptionBuilder.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 8/25/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ParticipantDescriptionBuilder <NSObject>

#pragma mark -
#pragma mark @required
@required

- (NSString *)descriptionForParticipantInfos:(NSArray *)theParticipantInfos forDisplayInLabel:(UILabel *)theLabel;

- (NSString *)descriptionForParticipantInfos:(NSArray *)theParticipantInfos sizeWithFont:(UIFont *)theFont constraintedToSize:(CGSize)theConstrainedSize;

- (NSString *)descriptionForParticipants:(NSArray *)theParticipants forDisplayInLabel:(UILabel *)theLabel;

- (NSString *)descriptionForParticipants:(NSArray *)theParticipants sizeWithFont:(UIFont *)theFont constraintedToSize:(CGSize)theConstrainedSize;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
