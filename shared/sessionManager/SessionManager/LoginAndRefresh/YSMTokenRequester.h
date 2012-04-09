//
//  TokenRequester.h
//  SessionManager4
//
//  Created by Lei Cai on 8/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TokenRequester.h"
#import "ConnectionWrapperFactory.h"
#import "ErrorDescriptionGenerator.h"

@interface YSMTokenRequester : NSObject <TokenRequester, ConnectionWrapperDelegate> {
 @private
    NSTimeInterval timeout_;
    id<ConnectionWrapperFactory> connectionWrapperFactory;
    id<ConnectionWrapper> connection;
    id<ErrorDescriptionGenerator> errorDescriptionGenerator;
}

@property (nonatomic, assign) id<TokenRequesterDelegate> delegate;

- (id)initWithConnectionWrapperFactory:(id<ConnectionWrapperFactory>)aConnectionWrapperFactory
             errorDescriptionGenerator:(id<ErrorDescriptionGenerator>)aErrorDescriptionGenerator
                              delegate:(id<TokenRequesterDelegate>)theDelegate;

@end
