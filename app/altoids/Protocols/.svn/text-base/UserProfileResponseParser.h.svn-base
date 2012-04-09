//
//  UserProfileResponseParser.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 9/13/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YAFetchUserProfileResponse;
@protocol UserProfileResponseParser <NSObject>

#pragma mark -
#pragma mark @required
@required

- (YAFetchUserProfileResponse *)parseFetchUserProfileResponse:(NSData *)response error:(NSError *)error;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
