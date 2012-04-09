//
//  ProblemReporter.h
//  ProblemReporter
//
//  Created by Xianzhe Ma on 2/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ProblemReporter <NSObject>

- (void)reportProblemWithUserComment:(NSString *)aUserComment;

@end