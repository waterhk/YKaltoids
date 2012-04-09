//
//  YANetworkActivityIndicatorOverlay.h
//  altoids
//
//  Created by Devin Doman on 02/13/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "ActivityIndicatorOverlay.h"
#import "Threader.h"

@interface YAActivityIndicatorOverlay : UIView <ActivityIndicatorOverlay>

@property (strong, nonatomic) id<Threader> mainThreader;
@property (strong, nonatomic) IBOutlet UILabel* updatingLabel;
@property (strong, nonatomic) IBOutlet UIView *activityStatusView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorSpinner;
@property (strong, nonatomic) IBOutlet UIImageView *activityCompleteCheckMark;

@end

