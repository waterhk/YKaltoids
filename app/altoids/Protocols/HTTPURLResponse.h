//
//  HTTPURLResponse.h
//  altoids
//
//  Created by Anand Subba Rao on 9/9/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HTTPURLResponse <NSObject>

#pragma mark -
#pragma mark @required
@required
- (NSURL *)URL;
- (NSString *)MIMEType;
- (long long)expectedContentLength;
- (NSString *)textEncodingName;
- (NSString *)suggestedFilename;
- (NSInteger)statusCode;
- (NSDictionary *)allHeaderFields;
/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
