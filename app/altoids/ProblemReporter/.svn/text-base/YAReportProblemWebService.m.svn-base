//
//  YAReportProblemWebService.m
//  altoids
//
//  Created by Xianzhe Ma on 2/10/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAReportProblemWebService.h"
#import "ReportProblemWebServiceParameters.h"

@implementation YAReportProblemWebService

- (id)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (NSMutableURLRequest *)reportProblemURLRequestWithParameters:(id<ReportProblemWebServiceParameters>)aParameters {
    static NSString * const reportProblemURLStringFormat = @"http://submit.msg.yahoo.com/upload?intl=%@&f=%@&bn=%@&r=%@&vid=%@&ctg=%@&sctg=%@";
    NSString *reportProblemURLString = [NSString stringWithFormat:reportProblemURLStringFormat,
                                        [aParameters international],
                                        [aParameters logFileName],
                                        [aParameters applicationVersion],
                                        [aParameters userComment],
                                        [aParameters vendorId],
                                        [aParameters category],
                                        [aParameters subCagegory]];
    
    NSURL *reportProblemURL = [[NSURL alloc] initWithString:reportProblemURLString];
    
    NSMutableURLRequest *reportProblemRequest = [[NSMutableURLRequest alloc] initWithURL:reportProblemURL cachePolicy:[self requestCachePolicy] timeoutInterval:[self timeIntervalInSeconds]];
    
    [reportProblemRequest setHTTPShouldHandleCookies:NO];
    [reportProblemRequest setHTTPMethod:@"POST"];
    [reportProblemRequest setValue:@"text/plain" forHTTPHeaderField:@"Content-Type"];
    
    return reportProblemRequest;
}

- (NSTimeInterval)timeIntervalInSeconds {
    return 30.0;
}

- (NSURLRequestCachePolicy)requestCachePolicy {
    return NSURLRequestReloadIgnoringLocalCacheData;
}

@end
