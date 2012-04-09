//
//  LoginServiceTests.m
//  SessionManager3
//
//  Created by Lei Cai on 8/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "LoginServiceTests.h"
#import "LoginService.h"
#import "SMErrorDescriptionGenerator.h"
#import "ConnectionWrapperFactory.h"
#import "CookieCrumbRequesterFactory.h"
#import "TokenRequesterFactory.h"
#import "LoginServiceFactory.h"
#import "AccountInfoRepositoryFactory.h"
#import "SessionManager.h"
#import "NSString+URLParamEncoding.h"

@implementation LoginServiceTests
- (void)setUp
{
    loginServiceDelegateMock = [OCMockObject mockForProtocol:@protocol(LoginServiceDelegate)];
    SMErrorDescriptionGenerator *smErrorDescriptionGenerator = [[SMErrorDescriptionGenerator alloc] init];
    ConnectionWrapperFactory *connectionWrapperFactory = [[ConnectionWrapperFactory alloc] init];
    CookieCrumbRequesterFactory *cookieCrumbRequesterFactory = [[CookieCrumbRequesterFactory alloc] initWithConnectionWrapperFactory:connectionWrapperFactory andErrorDescriptionGenerator:smErrorDescriptionGenerator];
    TokenRequesterFactory *tokenRequesterFactory = [[TokenRequesterFactory alloc] initWithConnectionWrapperFactory:connectionWrapperFactory andErrorDescriptionGenerator:smErrorDescriptionGenerator];
    
    
    loginService = [[LoginService alloc] initWithTokenRequesterFactory:tokenRequesterFactory
                                        andCookieCrumbRequesterFactory:cookieCrumbRequesterFactory];
    loginService.delegate = loginServiceDelegateMock;
}

- (void)tearDown
{
}

/* because the OCMock doesn't work with assign property
 * we have to use realy delegate instead of mock one to verify.
 */

- (void)testCorrectUserInfo
{
    //[[loginServiceDelegateMock expect] loginService:loginService didSucceedWithAccount:OCMOCK_ANY];
    loginService.delegate = self;
    //loginService.delegate = loginServiceDelegateMock;
    [loginService loginWithUsername:@"cailei_flickrtest01" andPassword:@"agileapps"];
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:30]];
    
    //[loginServiceDelegateMock verify];
}

- (void)testWrongUserInfo
{
    //[[loginServiceDelegateMock expect] loginService:loginService didFailWithError:OCMOCK_ANY];
    loginService.delegate = self;
    //loginService.delegate = loginServiceDelegateMock;
    [loginService loginWithUsername:@"cailei_flickrtest01" andPassword:@"abcdefg"];
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:30]];
    
    //[loginServiceDelegateMock verify];
}

- (void)loginService:(id<LoginServiceProtocol>)aLoginService didSucceedWithAccount:(AccountInfo*)aAccountInfo
{
    STAssertTrue([@"cailei_flickrtest01" isEqualToString:aAccountInfo.userID], @"should be able to callback");
}

- (void)loginService:(id<LoginServiceProtocol>)aLoginService didFailWithError:(NSError*)aError
{
    STAssertNotNil(aError, @"should be able to callback");
}

@end
