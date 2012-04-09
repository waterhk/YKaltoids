//
//  YAPullToRefreshView.h
//  altoids
//
//  Created by Xianzhe Ma on 2/29/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullToRefreshView.h"

@protocol DateFormatter;

@interface YAPullToRefreshView : UIView <PullToRefreshView>

- (id)initWithFrame:(CGRect)aFrame isPullDown:(BOOL)isPullDown withDirectionText:(NSString*)aDirectionText;

@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) IBOutlet UIImageView *arrowImageView;
@property (nonatomic, strong) IBOutlet UILabel *lastUpdateTimeLabel;
@property (nonatomic, strong) IBOutlet UILabel *messageLabel;
@property (nonatomic, strong) IBOutlet UIView* alignment;
@property (nonatomic, strong) IBOutlet UILabel* errorLabel;

@property (nonatomic, strong, readonly) NSDate *lastUpdateDate;
@property (nonatomic, strong) id<DateFormatter> dateFormatter;
@property (nonatomic, assign) PullToRefreshViewErrorCode errorCode;

@end
