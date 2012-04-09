//
//  YANavigationBarButtonItemRepositoryTests.m
//  altoids
//
//  Created by Derrick Whittle on 1/19/12.
//  Copyright 2012 Yahoo!. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <OCMock/OCMock.h>

#import "YANavigationBarButtonItemRepository.h"
#import "ButtonCreator.h"
#import "BarButtonItemCreator.h"


@interface YANavigationBarButtonItemRepositoryTests : SenTestCase
{
    YANavigationBarButtonItemRepository* repository;
    id buttonCreator;
    id barButtonItemCreator;

    UIButton* stubButton;
    UIBarButtonItem* stubBarButtonItem;
    id stubTarget;
    SEL stubAction;
}
@end


@implementation YANavigationBarButtonItemRepositoryTests

- (void)setUp
{
    buttonCreator = [OCMockObject mockForProtocol:@protocol(ButtonCreator)];
    barButtonItemCreator = [OCMockObject mockForProtocol:@protocol(BarButtonItemCreator)];
    
    repository = [[YANavigationBarButtonItemRepository alloc] init];
    [repository setButtonCreator:buttonCreator];
    [repository setBarButtonItemCreator:barButtonItemCreator];

    stubTarget = [NSObject alloc];
    stubAction = @selector(stubSelector);
    stubButton = [UIButton alloc];
    stubBarButtonItem = [UIBarButtonItem alloc];
}

- (void)stubSelector
{
}

- (void)expectButtonAndBarItemToBeCreatedWithExpectedTargetAndActionAndTitle:(NSString*)title
                                                   normalBackgroundImageName:(NSString*)normalBackgroundImageName
                                                  pressedBackgroundImageName:(NSString*)pressedBackgroundImageName
{
    [[[buttonCreator expect] andReturn:stubButton] autosizingNavigationBarButtonWithTitle:title normalBackgroundImageName:normalBackgroundImageName pressedBackgroundImageName:pressedBackgroundImageName target:stubTarget action:stubAction];
    [[[barButtonItemCreator expect] andReturn:stubBarButtonItem] createBarButtonItemWithCustomView:stubButton];    
}

- (void)expectButtonAndBarItemToBeCreatedWithExpectedTargetAndActionAndImageNamed:(NSString*)imageName
                                                        normalBackgroundImageName:(NSString*)normalBackgroundImageName
                                                       pressedBackgroundImageName:(NSString*)pressedBackgroundImageName
{
    [[[buttonCreator expect] andReturn:stubButton] autosizingNavigationBarButtonWithImageNamed:imageName normalBackgroundImageName:normalBackgroundImageName pressedBackgroundImageName:pressedBackgroundImageName target:stubTarget action:stubAction];
    [[[barButtonItemCreator expect] andReturn:stubBarButtonItem] createBarButtonItemWithCustomView:stubButton];    
}

- (void)verifyExpectationsAndReturnedBarButtonItem:(UIBarButtonItem*)barButtonItem
{
    STAssertEqualObjects(stubBarButtonItem, barButtonItem, @"expected stub bar button item instead");
    [buttonCreator verify];
    [barButtonItemCreator verify];
}


- (void)testDoneButtonShouldReturnButtonCreatedWithEmphasizedColorAndGivenTargetAndActionAndExpectedText
{
    [self expectButtonAndBarItemToBeCreatedWithExpectedTargetAndActionAndTitle:kDoneButtonText normalBackgroundImageName:kNavigationBarButtonEmphasizedImageBackground pressedBackgroundImageName:kNavigationBarButtonEmphasizedPressedImageBackground];

    UIBarButtonItem* result = [repository doneButtonItemWithTarget:stubTarget action:stubAction];
    [self verifyExpectationsAndReturnedBarButtonItem:result];
}

- (void)testSendButtonShouldReturnButtonCreatedWithEmphasizedColorAndGivenTargetAndActionAndExpectedText
{
    [self expectButtonAndBarItemToBeCreatedWithExpectedTargetAndActionAndTitle:kSendButtonText normalBackgroundImageName:kNavigationBarButtonEmphasizedImageBackground pressedBackgroundImageName:kNavigationBarButtonEmphasizedPressedImageBackground];

    UIBarButtonItem* result = [repository sendButtonItemWithTarget:stubTarget action:stubAction];
    [self verifyExpectationsAndReturnedBarButtonItem:result];
}

- (void)testEditButtonShouldReturnButtonCreatedWithNormalColorAndGivenTargetAndActionAndExpectedText
{
    [self expectButtonAndBarItemToBeCreatedWithExpectedTargetAndActionAndTitle:kEditButtonText normalBackgroundImageName:kNavigationBarButtonNormalImageBackground pressedBackgroundImageName:kNavigationBarButtonNormalPressedImageBackground];

    UIBarButtonItem* result = [repository editButtonItemWithTarget:stubTarget action:stubAction];
    [self verifyExpectationsAndReturnedBarButtonItem:result];
}

- (void)testCancelButtonShouldReturnButtonCreatedWithNormalColorAndGivenTargetAndActionAndExpectedText
{
    [self expectButtonAndBarItemToBeCreatedWithExpectedTargetAndActionAndTitle:kCancelButtonText normalBackgroundImageName:kNavigationBarButtonNormalImageBackground pressedBackgroundImageName:kNavigationBarButtonNormalPressedImageBackground];
    
    UIBarButtonItem* result = [repository cancelButtonItemWithTarget:stubTarget action:stubAction];
    [self verifyExpectationsAndReturnedBarButtonItem:result];
}

- (void)testAddContactButtonShouldReturnButtonCreatedWithNormalColorAndGivenTargetAndActionAndExpectedImage
{
    [self expectButtonAndBarItemToBeCreatedWithExpectedTargetAndActionAndImageNamed:kNavigationBarButtonIconAddContact normalBackgroundImageName:kNavigationBarButtonNormalImageBackground pressedBackgroundImageName:kNavigationBarButtonNormalPressedImageBackground];
    
    UIBarButtonItem* result = [repository addContactButtonItemWithTarget:stubTarget action:stubAction];
    [self verifyExpectationsAndReturnedBarButtonItem:result];
}

- (void)testComposeButtonShouldReturnButtonCreatedWithNormalColorAndGivenTargetAndActionAndExpectedImage
{
    [self expectButtonAndBarItemToBeCreatedWithExpectedTargetAndActionAndImageNamed:kNavigationBarButtonIconCompose normalBackgroundImageName:kNavigationBarButtonNormalImageBackground pressedBackgroundImageName:kNavigationBarButtonNormalPressedImageBackground];

    UIBarButtonItem* result = [repository composeButtonItemWithTarget:stubTarget action:stubAction];
    [self verifyExpectationsAndReturnedBarButtonItem:result];
}

- (void)testRefreshButtonShouldReturnButtonCreatedWithNormalColorAndGivenTargetAndActionAndExpectedImage
{
    [self expectButtonAndBarItemToBeCreatedWithExpectedTargetAndActionAndImageNamed:kNavigationBarButtonIconRefresh normalBackgroundImageName:kNavigationBarButtonNormalImageBackground pressedBackgroundImageName:kNavigationBarButtonNormalPressedImageBackground];
    
    UIBarButtonItem* result = [repository refreshButtonItemWithTarget:stubTarget action:stubAction];
    [self verifyExpectationsAndReturnedBarButtonItem:result];
}

- (void)testSettingsButtonShouldReturnButtonCreatedWithNormalColorAndGivenTargetAndActionAndExpectedImage
{
    [self expectButtonAndBarItemToBeCreatedWithExpectedTargetAndActionAndImageNamed:kNavigationBarButtonIconSettings normalBackgroundImageName:kNavigationBarButtonNormalImageBackground pressedBackgroundImageName:kNavigationBarButtonNormalPressedImageBackground];
    
    UIBarButtonItem* result = [repository settingsButtonItemWithTarget:stubTarget action:stubAction];
    [self verifyExpectationsAndReturnedBarButtonItem:result];
}


@end