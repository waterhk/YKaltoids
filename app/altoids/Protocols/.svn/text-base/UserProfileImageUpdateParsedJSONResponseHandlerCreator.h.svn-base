//
//  UserProfileImageUpdateParsedJSONResponseHandlerCreator.h
//  altoids
//
//  Created by Anand Biligiri on 12/21/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserProfileImageUpdateParsedJSONResponseHandler.h"
#import "UserProfileUpdateCommandDelegate.h"

@class YAUser;
@protocol UserProfileImageUpdateParsedJSONResponseHandlerCreator <NSObject>

#pragma mark -
#pragma mark @required
@required
- (id<UserProfileImageUpdateParsedJSONResponseHandler>)createWithUser:(YAUser *)user profileImageData:(NSData *)theProfileImageData delegate:(id<UserProfileUpdateCommandDelegate>)theDelegate;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
