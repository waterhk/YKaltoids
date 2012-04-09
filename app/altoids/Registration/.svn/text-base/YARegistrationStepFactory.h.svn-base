//
//  YARegistrationStepFactory.h
//  altoids
//
//  Created by Jon Herron on 9/2/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CarrierInformationCreator.h"
#import "RegistrationConfiguration.h"
#import "RegistrationService.h"
#import "RegistrationStepFactory.h"
#import "RegistrationTransientStateMutator.h"
#import "UIAlertViewFactory.h"
#import "UIAlertViewSelectionDetector.h"
#import "UIAlertViewDismisser.h"

@protocol ActivityIndicatorOverlayInstanceFactory;

@interface YARegistrationStepFactory : NSObject <RegistrationStepFactory>

@property (strong, nonatomic, setter=setUiAlertViewFactory:) id<UIAlertViewFactory> UIAlertViewFactory;
@property (strong, nonatomic, setter=setUiAlertViewSelectionDetector:) id<UIAlertViewSelectionDetector> UIAlertViewSelectionDetector;
@property (strong, nonatomic, setter=setUiAlertViewDismisser:) id<UIAlertViewDismisser> UIAlertViewDismisser;
@property (strong, nonatomic) id<RegistrationConfiguration> registrationConfiguration;
@property (strong, nonatomic) id<RegistrationTransientStateMutator> registrationTransientStateMutator;
@property (strong, nonatomic) id<RegistrationService> registrationService;
@property (strong, nonatomic) id<CarrierInformationCreator> carrierInformationCreator;
@property (strong, nonatomic) id<ActivityIndicatorOverlayInstanceFactory> activityIndicatorOverlayInstanceFactory;

@end
