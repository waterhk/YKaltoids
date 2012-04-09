//
//  TokenRequester.m
//  SessionManager4
//
//  Created by Lei Cai on 8/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "YSMTokenRequester.h"
#import "YSMAppInfo.h"
#import "NSString+URLParamEncoding.h"
#import "YSMErrorDescriptionGenerator.h"

@interface YSMTokenRequester()

- (NSError *)errorForSessionManagerErrorCode:(SessionManagerError)aSessionManagerErrorCode;

@end

@implementation YSMTokenRequester

@synthesize delegate = delegate_;

- (id)initWithConnectionWrapperFactory:(id<ConnectionWrapperFactory>)aConnectionWrapperFactory
          errorDescriptionGenerator:(id<ErrorDescriptionGenerator>)aErrorDescriptionGenerator
                              delegate:(id<TokenRequesterDelegate>)theDelegate
{
    self = [super init];
    if (self) {
        // Initialization code here.
        connectionWrapperFactory = aConnectionWrapperFactory;
        errorDescriptionGenerator = aErrorDescriptionGenerator;
        delegate_ = theDelegate;
        
        timeout_ = 30;
    }
    
    return self;
}

- (void)disposePendingRequest {
    [connection disposeCurrentRequest];
}

- (NSURL *)tokenRequestURLWithUserID:(NSString *)aUid andPassword:(NSString *)aPwd {
    NSString *urlString = [NSString stringWithFormat:@"https://%@/config/pwtoken_get?src=%@&login=%@&passwd=%@&.rand=%ul",
						   kLoginServer,
						   kIdentifier,
						   [aUid stringByURLEncodingAsStringParameter],
						   [aPwd stringByURLEncodingAsStringParameter],
						   (unsigned long)[[NSDate date] timeIntervalSince1970]];
    
	return [NSURL URLWithString:urlString];
}


- (void)requestTokenWithUsername:(NSString*)aUsername andPassword:(NSString*)aPassword
{
    NSError *error = nil;
        
    if (![aUsername length])
    {
        error = [self errorForSessionManagerErrorCode:RequiredFieldUserIDMissing];
    }
    else if (![aPassword length])
    {
        error = [self errorForSessionManagerErrorCode:RequiredFieldPasswordMissing];
    }

    if (error) 
    {
        [[self delegate] tokenRequester:self didFailWithError:error];
        return;
    }

    connection = [connectionWrapperFactory createWithConnectionWrapperDelegate:self];
    NSURL *tokenRequestURL = [self tokenRequestURLWithUserID:aUsername andPassword:aPassword];
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:tokenRequestURL
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
    NSString* token = nil;
    NSHTTPURLResponse *httpStatusCode = (NSHTTPURLResponse *)aResponse;
    
    NSString *stringResult = [[NSString alloc] initWithData:aData encoding:NSUTF8StringEncoding];
    
	NSArray *components = [stringResult componentsSeparatedByString:@"\r\n"];	
	if ([components count] >= 1) {
		result = [[components objectAtIndex: 0] integerValue];
	}
    
	NSString *tokenPrefix = [self tokenPrefix];
	for (NSString *item in components) {
		if ([item hasPrefix:tokenPrefix]) {
			token = [item substringFromIndex:tokenPrefix.length];
		}
	}
    
	if (result == 0 && [token length] == 0) {
		result = HttpTransportError;
	}
	
	if (result == 0) {
        [self.delegate tokenRequester:self didSucceedWithToken:token];
	} else {
		NSDictionary *userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:
								  [errorDescriptionGenerator descriptionFromErrorCode:result], NSLocalizedDescriptionKey,
								  [NSNumber numberWithInteger:[httpStatusCode statusCode]], @"httpStatusCode", nil];
        
		NSError *error = [NSError errorWithDomain:kLoginErrorDomain
											 code:result
										 userInfo:userInfo];
        
		[self.delegate tokenRequester:self didFailWithError:error];
	}

}

- (void)connectionWrapper:(id<ConnectionWrapper>)aConnectionWrapper didFailWithData:(NSError*)aError andURLResponse:(NSURLResponse*)aResponse
{
	[self.delegate tokenRequester:self didFailWithError:aError];
}

- (NSError *)errorForSessionManagerErrorCode:(SessionManagerError)aSessionManagerErrorCode
{
    return [NSError errorWithDomain:kLoginErrorDomain code:aSessionManagerErrorCode userInfo:[NSDictionary dictionaryWithObject:[errorDescriptionGenerator descriptionFromErrorCode:aSessionManagerErrorCode] forKey:NSLocalizedDescriptionKey]];
}

@end
