//
//  YANotificationSoundsViewController.h
//  altoids
//
//  Created by Stephane Karoubi on 3/18/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewControllerAccessor.h"

@interface YANotificationSoundsViewController : UITableViewController<ViewControllerAccessor>

#pragma mark - @property declarations
@property (strong, nonatomic) NSArray* cellTitles;

#pragma mark - Instance methods
@end
