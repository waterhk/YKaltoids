//
//  ServerConfiguration.h
//  altoids
//
//  Created by Anand Subba Rao on 8/23/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ServerConfiguration <NSObject>

#pragma mark -
#pragma mark @required
@required
- (NSString *)mmcServerHostname;
- (NSString *)registrationServer;
- (NSString *)mmcServiceName;
/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
