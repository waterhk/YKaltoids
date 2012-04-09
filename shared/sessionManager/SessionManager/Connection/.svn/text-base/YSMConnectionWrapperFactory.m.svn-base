//
//  ConnectionWrapperFactory.m
//  SessionManager3
//
//  Created by Lei Cai on 8/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "YSMConnectionWrapperFactory.h"
#import "YSMConnectionWrapper.h"

@implementation YSMConnectionWrapperFactory

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (id<ConnectionWrapper>)createWithConnectionWrapperDelegate:(id<ConnectionWrapperDelegate>)aConnectionWrapperDelegate;
{
    YSMConnectionWrapper *connectionWrapper = [[YSMConnectionWrapper alloc] init];
    connectionWrapper.delegate = aConnectionWrapperDelegate;
    return connectionWrapper;
}

@end
