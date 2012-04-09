//
//  ParticipantRepositoryImageDelegate.h
//  altoids
//
//  Created by Anand Biligiri on 11/11/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ParticipantRepositoryImageDelegate <NSObject>

#pragma mark -
#pragma mark @required
@required
- (void)imageReady:(UIImage *)participantImage forParticipantPhotoURL:(NSString *)photoURL;
/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
