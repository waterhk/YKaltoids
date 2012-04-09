//
//  LoginServiceTests.h
//  SessionManager3
//
//  Created by Lei Cai on 8/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

//  Logic unit tests contain unit test code that is designed to be linked into an independent test executable.
//  See Also: http://developer.apple.com/iphone/library/documentation/Xcode/Conceptual/iphone_development/135-Unit_Testing_Applications/unit_testing_applications.html

#import <SenTestingKit/SenTestingKit.h>
#import "LoginService.h"
#import "TokenRequesterFactoryProtocol.h"
#import "CookieCrumbRequesterFactoryProtocol.h"

@interface LoginServiceTests : SenTestCase <LoginServiceDelegate>{
    LoginService *loginService;
    id loginServiceDelegateMock;
    
    id<TokenRequesterFactoryProtocol> tokenRequesterFactory_;
    id<CookieCrumbRequesterFactoryProtocol> cookieCrumbRequesterFactory_;    
}

@end
