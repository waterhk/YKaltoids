//
//  RefreshServiceFactoryProtocol.h
//  SessionManager4
//
//  Created by Lei Cai on 8/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RefreshService.h"

@protocol RefreshServiceFactory <NSObject>
- (id<RefreshService>)createWithRefreshServiceDelegate:(id<RefreshServiceDelegate>)aRefreshServiceDelegate;
@end
