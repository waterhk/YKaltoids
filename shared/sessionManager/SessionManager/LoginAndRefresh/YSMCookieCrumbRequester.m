//
//  CookieCrumbRequester.m
//  SessionManager4
//
//  Created by Lei Cai on 8/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "YSMCookieCrumbRequester.h"
#import "YSMAppInfo.h"
#import "NSString+URLParamEncoding.h"
#import "YSMErrorDescriptionGenerator.h"

@implementation YSMCookieCrumbRequester
- (void)dealloc
{
    
}

- (id)initWithConnectionWrapperFactory:(id<ConnectionWrapperFactory>)aConnectionWrapperFactory
          errorDescriptionGenerator:(id<ErrorDescriptionGenerator>)aErrorDescriptionGenerator
{
    self = [super init];
    if (self) {
        // Initialization code here.
        connectionWrapperFactory = aConnectionWrapperFactory;
        errorDescriptionGenerator = aErrorDescriptionGenerator;
        
        timeout_ = 30;
    }
    
    return self;
}

- (void)disposePendingRequest {
    [connection disposeCurrentRequest];
}

- (NSURL *)tokenAuthenticationURLForToken:(NSString *)aToken {
	NSString *urlString = [NSString stringWithFormat:@"https://%@/config/pwtoken_login?src=%@&token=%@&.rand=%ul",
						   kLoginServer,
						   kIdentifier,
						   [aToken stringByURLEncodingAsStringParameter],
						   (unsigned long)[[NSDate date] timeIntervalSince1970]];
    
	return [NSURL URLWithString:urlString];
}

- (void)requestCookieCrumbWithToken:(NSString*)aToken
{
    NSParameterAssert(aToken != nil);
	NSParameterAssert([aToken length] != 0);
    
    connection = [connectionWrapperFactory createWithConnectionWrapperDelegate:self];
	NSURL *tokenAuthenticationURL = [self tokenAuthenticationURLForToken:aToken];
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:tokenAuthenticationURL
																cachePolicy:NSURLRequestReloadIgnoringCacheData
															timeoutInterval:timeout_];
	[request setHTTPShouldHandleCookies:NO];
	[connection executeWithRequest:request];
}

- (NSString *)tokenPrefix {
	NSString *tokenPrefix = [[NSString alloc] initWithFormat:@"%@=", kIdentifier];
	return tokenPrefix;
}

- (void)connectionWrapper:(id<ConnectionWrapper>)aConnectionWrapper didSucceedWithData:(NSData*)aData andURLResponse:(NSURLResponse*)aResponse
{
    NSInteger result = HttpTransportError;
	NSString *yCookie = nil;
	NSString *tCookie = nil;
	NSString *crumb = nil;
	NSDate *expirationDate = nil;
    NSHTTPURLResponse *httpStatusCode = (NSHTTPURLResponse *)aResponse;
    
    NSString *httpBody = [[NSString alloc] initWithData:aData encoding:NSUTF8StringEncoding];
    
    NSMutableString *stringResult = [[NSMutableString alloc] init];
    NSDictionary *httpHeaders = [(NSHTTPURLResponse*)aResponse allHeaderFields];
    NSString *cookies = [httpHeaders objectForKey:@"Set-Cookie"];
    if (cookies) {
        [stringResult appendString:httpBody];
        // the y & t cookie are seperated by space in header while \r\n in body
        NSArray *sections = [cookies componentsSeparatedByString:@" "];
        NSString *cookiesString = [sections componentsJoinedByString:@"\n"];
        [stringResult appendString:cookiesString];
        
        expirationDate = [httpHeaders objectForKey:@"Expires"];
    }
    else
    {
        stringResult = [NSString stringWithString:httpBody];
    }
    
	//NSString *stringResult = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	NSArray *components = [stringResult componentsSeparatedByString:@"\n"];	
	if ([components count] >= 1) {
		result = [[components objectAtIndex: 0] integerValue];
	}
	
	for (NSString *item in components) {
		if ([item hasPrefix:@"crumb="]) {
			crumb = [item substringFromIndex:6];
		}
		if ([item hasPrefix:@"Y="]) {
			NSRange semiColonRange = [item rangeOfString:@";"];
			NSRange range = NSMakeRange(2, (semiColonRange.length ? semiColonRange.location-2 : item.length-2));
			yCookie = [item substringWithRange:range];
		}
		if ([item hasPrefix:@"T="]) {
			NSRange semiColonRange = [item rangeOfString:@";"];
			NSRange range = NSMakeRange(2, (semiColonRange.length ? semiColonRange.location-2 : item.length-2));
			tCookie = [item substringWithRange:range];
		}
		if ([item hasPrefix:@"Expiration="]) {
			NSInteger validFor = [[item substringFromIndex:15] integerValue];
			expirationDate = [NSDate dateWithTimeIntervalSinceNow:validFor];
		}
	}
	if (result == 0 && (![yCookie length] || ![tCookie length])) {
		result = HttpTransportError;
	}
	if (!expirationDate) {
		// if there is no expiration specified, we assume that it's the standard two weeks.
		expirationDate = [NSDate dateWithTimeIntervalSinceNow:(14 * 24 * 3600)];
	}
	
	if (result == 0) {
        [self.delegate cookieCrumbRequester:self didSucceedWithYCookie:yCookie andTCookie:tCookie andCrumb:crumb andExpirationDate:expirationDate];
	} else {
		NSDictionary *userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:
								  [errorDescriptionGenerator descriptionFromErrorCode:result], NSLocalizedDescriptionKey,
								  [NSNumber numberWithInteger:[httpStatusCode statusCode]], @"httpStatusCode", nil];
        
		NSError *error = [NSError errorWithDomain:kLoginErrorDomain
											 code:result
										 userInfo:userInfo];
		
		[self.delegate cookieCrumbRequester:self didFailWithError:error];
	}
}

- (void)connectionWrapper:(id<ConnectionWrapper>)aConnectionWrapper didFailWithData:(NSError*)aError andURLResponse:(NSURLResponse*)aResponse
{
    [self.delegate cookieCrumbRequester:self didFailWithError:aError];
}

@synthesize delegate = delegate_;
@end
