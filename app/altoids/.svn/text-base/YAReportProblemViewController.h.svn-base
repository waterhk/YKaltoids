//
//  YAReportProblemViewController.h
//  altoids
//
//  Created by Stephane Karoubi on 11/23/11.
//  Copyright (c) 2011 Yahoo!. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YABaseViewController.h"
#import "ReportProblemViewController.h"

@protocol NavigationBarButtonItemRepository;
@protocol ProblemReporter;

@interface YAReportProblemViewController : UITableViewController <ReportProblemViewController>

@property (nonatomic, strong) id<NavigationBarButtonItemRepository> navigationBarButtonItemRepository;
@property (nonatomic, strong) IBOutlet UITextView *textViewReportProblem;
@property (nonatomic, strong) id<ProblemReporter> problemReporter;

- (void)sendReport:(id)sender;

@end
