//
//  YSMErrors.h
//  SessionManager
//
//  Created by Srinivas Raovasudeva on 11/29/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

#define YSMErrorDomain(domain) @"com.yahoo.hub." #domain "ErrorDomain"

static NSString *const YSMAuthenticationErrorDomain = YSMErrorDomain(Authentication);

typedef enum
{
    YSMAuthenticationErrorCodeFailedToRetrieveSessionCrumb,
    YSMAuthenticationErrorCodeFailedToRetrieveProfileCrumb,
    YSMAuthenticationErrorCodeSessionCrumbExpired,
    YSMAuthenticationErrorCodeProfileCrumbExpired,
    YSMAuthenticationErrorCodeCookiesExpired,
    YSMAuthenticationErrorCodeSessionHasExpired,
    YSMAuthenticationErrorCodeEmptyUsernameOrPassword,
    YSMAuthenticationErrorCodeInvalidUsernameOrPassword
} YSMAuthenticationErrorCodes;

//
// YSMAuthenticationErrorDomain error messages
//
#define YSMAuthenticationErrorFailedToRetrieveSessionCrumb NSLocalizedString(@"Failed to retrieve session crumb", @"Failed to retrieve session crumb error message")
#define YSMAuthenticationErrorFailedToRetrieveProfileCrumb NSLocalizedString(@"Failed to retrieve profile crumb", @"Failed to retrieve profile crumb error message")
#define YSMAuthenticationErrorSessionCrumbExpired NSLocalizedString(@"Session crumb has expired", @"Session crumb expired error message")
#define YSMAuthenticationErrorProfileCrumbExpired NSLocalizedString(@"Profile crumb has expired", @"Profile crumb expired error message")
#define YSMAuthenticationErrorCookiesExpired NSLocalizedString(@"Cookies have expired", @"Cookies have expired error message")
#define YSMAuthenticationErrorSessionHasExpired NSLocalizedString(@"Your session has expired, please sign in again.", @"Session has expired error message")
#define YSMAuthenticationErrorEmptyUsernameOrPassword NSLocalizedString(@"Username and password are required, please try again.", @"Empty username or password error message")
#define YSMAuthenticationErrorInvalidUsernameOrPassword NSLocalizedString(@"Invalid username or password, please try again.", @"Invalid username or password error message")