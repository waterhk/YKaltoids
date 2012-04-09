//
//  YAProblemReporter.h
//  ProblemReporter
//
//  Created by Xianzhe Ma on 2/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProblemReporter.h"
#import "NetworkActivityIndicatorStatusBarSpawner.h"

@protocol ReportProblemWebService;
@protocol ReportProblemWebServiceParameters;
@protocol AuthInfoProvider;

@interface YAProblemReporter : NSObject <ProblemReporter>

@property (nonatomic, strong) id<ReportProblemWebService> reportProblemWebService;
@property (nonatomic, strong) id<ReportProblemWebServiceParameters> reportProblemWebServiceParameters;
@property (nonatomic, strong) id<AuthInfoProvider> authInfoProvider;
@property (nonatomic, strong) id<NetworkActivityIndicatorStatusBarSpawner> networkActivityIndicatorStatusBarSpawner;
@end
