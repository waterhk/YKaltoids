//
//  Response.h
//  altoids
//
//  Created by Anand Subba Rao on 8/24/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Response <NSObject>

#pragma mark -
#pragma mark @required
@required
@property (nonatomic) int statusCode;
@property (nonatomic) int contentLength;
@property (nonatomic, strong) NSDictionary *body;
@property (nonatomic, strong) NSError *error;
/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
