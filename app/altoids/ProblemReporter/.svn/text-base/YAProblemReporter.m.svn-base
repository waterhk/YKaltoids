//
//  YAProblemReporter.m
//  ProblemReporter
//
//  Created by Xianzhe Ma on 2/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "YAProblemReporter.h"
#import "ReportProblemWebService.h"
#import "ReportProblemWebServiceParameters.h"
#import "AuthInfoProvider.h"
#import "YASessionLogger.h"

@interface YAProblemReporter ()

@property (nonatomic, strong, readwrite) NSOperationQueue *reportProblemNetworkQueue;

@end

@implementation YAProblemReporter

@synthesize reportProblemNetworkQueue = reportProblemNetworkQueue_;

@synthesize reportProblemWebService = reportProblemWebService_;
@synthesize reportProblemWebServiceParameters = reportProblemWebServiceParameters_;
@synthesize authInfoProvider = authInfoProvider_;
@synthesize networkActivityIndicatorStatusBarSpawner = networkActivityIndicatorStatusBarSpawner_;

- (id)init {
    if (self = [super init]) {
        [self setReportProblemNetworkQueue:[[NSOperationQueue alloc] init]];
    }
    return self;
}

- (void)reportProblemWithUserComment:(NSString *)aUserComment {    
    [[self reportProblemWebServiceParameters] setUserComment:aUserComment];
    NSMutableURLRequest *reportRequest = [[self reportProblemWebService] reportProblemURLRequestWithParameters:[self reportProblemWebServiceParameters]];
    
    //set cookies
    NSString *yCookie = [[self authInfoProvider] yCookie];
    NSString *tCookie = [[self authInfoProvider] tCookie];
    NSString *cookieHeaderFieldValue = [NSString stringWithFormat:@"Y=%@; T=%@", yCookie, tCookie];
    [reportRequest setValue:cookieHeaderFieldValue forHTTPHeaderField:@"Cookie"];
    
    //set log file as HTTP Body
    NSData *logFileAsHttpBodyData = [[YASessionLogger sharedSessionLogger] sessionLogData];
    if ([logFileAsHttpBodyData length] == 0) {
        static NSString *httpBodyStringForEmptySessionLog = @"no data";
        logFileAsHttpBodyData = [httpBodyStringForEmptySessionLog dataUsingEncoding:NSUTF8StringEncoding];
    }
    
    [reportRequest setHTTPBody:logFileAsHttpBodyData];
        
    [[self reportProblemNetworkQueue] addOperationWithBlock:^(void){
        NSError *error = nil;
        
        [[self networkActivityIndicatorStatusBarSpawner] networkActivityDidBegin];
        NSData *responseData = [NSURLConnection sendSynchronousRequest:reportRequest returningResponse:nil error:&error];
        [[self networkActivityIndicatorStatusBarSpawner] networkActivityDidEnd];

        if (!responseData || error) {
            YALogError(@"Report Problem failed with Error: %@", [error localizedDescription]);
        }
    }];
}

@end
