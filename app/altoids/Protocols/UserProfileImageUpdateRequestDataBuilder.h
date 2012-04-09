//
//  UserProfileImageUpdateRequestDataBuilder.h
//  altoids
//
//  Created by Anand Subba Rao on 12/16/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YAUser;

@protocol UserProfileImageUpdateRequestDataBuilder <NSObject>
#pragma mark -
#pragma mark @required
@required
- (NSDictionary *)requestDataForProfileImageUpdateWithImageData:(NSData *)imageData;
/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
