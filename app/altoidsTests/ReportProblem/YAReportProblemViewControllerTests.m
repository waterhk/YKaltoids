//
//  YAReportProblemViewControllerTests.m
//  altoids
//
//  Created by Xianzhe Ma on 2/9/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//
#import <OCMock/OCMock.h>

#import "YAReportProblemViewControllerTests.h"

#import "YAReportProblemViewController.h"
#import "ProblemReporter.h"

@implementation YAReportProblemViewControllerTests

// All code under test must be linked into the Unit Test bundle

- (void)testSendReportShouldCallProblemReporterWithUserCommentAsParameterAsExpected {
    id bundleMock = [OCMockObject mockForClass:[NSBundle class]];
    YAReportProblemViewController *reportProblemViewController = [[YAReportProblemViewController alloc] initWithNibName:nil bundle:bundleMock];
    
    id textViewMock = [OCMockObject mockForClass:[UITextView class]];    
    NSString *userComment = @"iOS Hub is awesome!!!";
    [[[textViewMock stub] andReturn:userComment] text];
    [[textViewMock expect] setText:@""];
    
    [reportProblemViewController setTextViewReportProblem:textViewMock];
    
    id problemReporterMock = [OCMockObject mockForProtocol:@protocol(ProblemReporter)];
    [[problemReporterMock expect] reportProblemWithUserComment:userComment];
    
    [reportProblemViewController setProblemReporter:problemReporterMock];
    
    [reportProblemViewController sendReport:textViewMock];
    
    [problemReporterMock verify];
}

@end
