//
//  YADeactivateViewController.h
//  altoids
//
//  Created by Stephane Karoubi on 3/19/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewControllerAccessor.h"
#import "UIAlertViewFactory.h"
#import "UIAlertViewSelectionDetector.h"
#import "DeactivationCommandCreator.h"
#import "CommandQueue.h"
#import "TransactionCommandDelegate.h"
#import "CommandTransaction.h"
#import "AppConfiguration.h"



@interface YADeactivateViewController : UITableViewController<ViewControllerAccessor, UIAlertViewDelegate, TransactionCommandDelegate>

#pragma mark - @property declarations
@property (strong, nonatomic) NSArray* cellTitles;
@property (strong, nonatomic) id<UIAlertViewFactory> uiAlertViewFactory;
@property (strong, nonatomic) id<UIAlertViewSelectionDetector> uiAlertViewSelectionDetector;
@property (strong, nonatomic) id<DeactivationCommandCreator> deactivationCommandCreator;
@property (strong, nonatomic) id<CommandQueue> mmcCommandQueue;
@property (strong, nonatomic) id<CommandTransaction> deactivationCommandTransaction;
@property (strong, nonatomic) id<AppConfiguration> appConfiguration;


#pragma mark - Instance methods
@end
