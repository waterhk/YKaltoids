//
//  CookieCrumbRequester.h
//  SessionManager4
//
//  Created by Lei Cai on 8/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CookieCrumbRequester.h"
#import "ConnectionWrapperFactory.h"
#import "ErrorDescriptionGenerator.h"

@interface YSMCookieCrumbRequester : NSObject <CookieCrumbRequester, ConnectionWrapperDelegate> {
@private
    NSTimeInterval timeout_;
    id<ConnectionWrapperFactory> connectionWrapperFactory;
    id<ConnectionWrapper> connection;
    id<ErrorDescriptionGenerator> errorDescriptionGenerator;
}

@property (nonatomic, assign) id<CookieCrumbRequesterDelegate> delegate;

- (id)initWithConnectionWrapperFactory:(id<ConnectionWrapperFactory>)aConnectionWrapperFactory
          errorDescriptionGenerator:(id<ErrorDescriptionGenerator>)aErrorDescriptionGenerator;

@end
