//
//  RegistrationConfiguration.h
//  altoids
//
//  Created by Anand Subba Rao on 11/18/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RegistrationConfiguration <NSObject>

#pragma mark -
#pragma mark @required
@required
- (NSString *)smsPrefix;
- (BOOL)shouldSkipRegistrationSMS;
/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
