//
//  TokenRequesterFactory.m
//  SessionManager4
//
//  Created by Lei Cai on 8/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "YSMTokenRequesterFactory.h"
#import "YSMTokenRequester.h"

@implementation YSMTokenRequesterFactory
@synthesize connectionWrapperFactory = connectionWrapperFactory_;
@synthesize errorDescriptionGenerator = errorDescriptionGenerator_;

- (id<TokenRequester>)createWithTokenRequesterDelegate:(id<TokenRequesterDelegate>)aTokenRequesterDelegate
{
    return [[YSMTokenRequester alloc] initWithConnectionWrapperFactory:[self connectionWrapperFactory]
                                             errorDescriptionGenerator:[self errorDescriptionGenerator]
                                                              delegate:aTokenRequesterDelegate];
}

@end
