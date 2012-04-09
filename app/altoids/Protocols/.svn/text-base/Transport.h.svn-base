//
//  Transport.h
//  altoids
//
//  Created by Robby Cahyadi Hendro Saputro on 8/18/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//
#import "HTTPURLResponse.h"

@protocol Transport <NSObject>
@required
- (void)sendSynchronousRequest:(NSURLRequest *)request returningResponse:(id<HTTPURLResponse> __autoreleasing *)response data:(NSData *__autoreleasing*)data
                         error:(NSError *__autoreleasing *)error;
- (void)startRequest:(NSURLRequest *)request withDelegate:(id<NSURLConnectionDataDelegate>)delegate;
@end
