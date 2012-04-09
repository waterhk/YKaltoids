//
//  LoginServiceFactoryProtocol.h
//  SessionManager4
//
//  Created by Lei Cai on 8/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginService.h"

@protocol LoginServiceFactory <NSObject>
- (id<LoginService>)createWithLoginServiceDelegate:(id<LoginServiceDelegate>)aLoginServiceDelegate;
@end
