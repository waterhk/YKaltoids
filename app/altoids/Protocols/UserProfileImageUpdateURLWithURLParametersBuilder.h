//
//  UserProfileImageUpdateURLWithURLParametersBuilder.h
//  altoids
//
//  Created by Anand Subba Rao on 12/15/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URLRequestURLWithURLParametersBuilder.h"

@protocol UserProfileImageUpdateURLWithURLParametersBuilder <URLRequestURLWithURLParametersBuilder>

#pragma mark -
#pragma mark @required
@required

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
