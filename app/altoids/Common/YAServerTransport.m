//
//  YAServerTransport.m
//  altoids
//
//  Created by Robby Cahyadi Hendro Saputro on 8/23/11.
//  Copyright (c) 2011 Yahoo!. All rights reserved.
//

#import "YAServerTransport.h"
#import "YASessionLogger.h"
#import "NetworkActivityIndicatorStatusBarSpawner.h"

#undef kYALogComponent
#define kYALogComponent lcl_cTransportServer

@interface YAServerTransportHTTPURLResponse : NSObject <HTTPURLResponse>
- (id)initWithHTTPURLResponse:(NSHTTPURLResponse *)httpURLResponse;
@end

@interface YAServerTransportHTTPURLResponse()
@property (nonatomic, strong) NSHTTPURLResponse *httpURLResponse;
@end

@implementation YAServerTransportHTTPURLResponse
@synthesize httpURLResponse = httpURLResponse_;

- (id)initWithHTTPURLResponse:(NSHTTPURLResponse *)httpURLResponse
{
    self = [super init];
    if (self) {
        httpURLResponse_ = httpURLResponse;
    }
    
    return self;
}

- (NSURL *)URL
{
    return [[self httpURLResponse] URL];
}

- (NSString *)MIMEType
{
    return [[self httpURLResponse] MIMEType];
}

- (NSString *)suggestedFilename
{
    return [[self httpURLResponse] suggestedFilename];
}

- (NSInteger)statusCode
{
    return [[self httpURLResponse] statusCode];
}

- (NSString *)textEncodingName
{
    return [[self httpURLResponse] textEncodingName];
}

- (long long)expectedContentLength
{
    return [[self httpURLResponse] expectedContentLength];
}

- (NSDictionary*)allHeaderFields
{
    return [[self httpURLResponse] allHeaderFields];
}
@end

@implementation YAServerTransport

@synthesize networkActivityIndicatorStatusBarSpawner = networkActivityIndicatorStatusBarSpawner_;

- (void)sendSynchronousRequest:(NSURLRequest *)request returningResponse:(id<HTTPURLResponse> __autoreleasing *)urlResponse data:(NSData *__autoreleasing *)data
                         error:(NSError *__autoreleasing *)error
{
    YALogInfo(@"Sending request\n\t%@\nbody\n\t%@\nheader\n%@\n",
              [[request URL] absoluteString],
              [[NSString alloc] initWithData:[request HTTPBody] encoding:NSUTF8StringEncoding],
              [request allHTTPHeaderFields]);
    
    YASessionLogDebug(@"Sending request\n\t%@\nbody\n\t%@\nheader\n%@\n",
                      [[request URL] absoluteString],
                      [[NSString alloc] initWithData:[request HTTPBody] encoding:NSUTF8StringEncoding],
                      [request allHTTPHeaderFields]);

    NSHTTPURLResponse *httpUrlResponse = nil;
    
    [networkActivityIndicatorStatusBarSpawner_ networkActivityDidBegin];
    
    *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&httpUrlResponse error:error];
    
    [networkActivityIndicatorStatusBarSpawner_ networkActivityDidEnd];
    
    *urlResponse = [[YAServerTransportHTTPURLResponse alloc] initWithHTTPURLResponse:httpUrlResponse];
    
    YALogInfo(@"Received\n\t%d bytes\nstatus\n\t%d\nheader\n\t%@\n",
              [*data bytes],
              [httpUrlResponse statusCode],
              [httpUrlResponse allHeaderFields]);

    YALogTrace(@"Response data\n\t%@\n",
               [[NSString alloc] initWithData:*data encoding:NSUTF8StringEncoding]);
}

- (void)startRequest:(NSURLRequest *)request withDelegate:(id<NSURLConnectionDataDelegate>)delegate
{
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:delegate startImmediately:NO];
    [connection start];
}
@end
