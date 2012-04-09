//
//  UserProfileUpdateNameWithPermissionParsedJSONResponseHandler.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 12/13/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParsedJSONResponseHandler.h"

@protocol UserProfileUpdateNameWithPermissionParsedJSONResponseHandler <ParsedJSONResponseHandler>

#pragma mark -
#pragma mark @required
@required

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
