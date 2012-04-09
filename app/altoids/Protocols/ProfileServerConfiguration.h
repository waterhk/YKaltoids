//
//  ProfileServerConfiguration.h
//  altoids
//
//  Created by Anand Subba Rao on 11/16/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ProfileServerConfiguration <NSObject>

#pragma mark -
#pragma mark @required
@required
- (NSString *)serverHostname;
/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
