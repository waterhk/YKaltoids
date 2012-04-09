//
//  YAReportProblemWebServiceParameters.h
//  altoids
//
//  Created by Xianzhe Ma on 2/10/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReportProblemWebServiceParameters.h"

@protocol URLParameterEncoder;

@interface YAReportProblemWebServiceParameters : NSObject <ReportProblemWebServiceParameters>

@property (nonatomic, strong) NSString *logFileName;
@property (nonatomic, strong) NSString *userComment;

@property (nonatomic, strong) id<URLParameterEncoder> urlParameterEncoder;

- (id)init;

@end
