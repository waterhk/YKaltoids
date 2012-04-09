//
//  YANavigationControllerContainer.m
//  altoids
//
//  Created by Srinivas Raovasudeva on 8/30/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YANavigationControllerContainer.h"

// Private class extension
@interface YANavigationControllerContainer ()

// @property definitions

// methods

@end

@implementation YANavigationControllerContainer

// Class methods
#pragma mark -
#pragma mark Class methods

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

- (id)init
{
  self = [super init];
  if (self) {
    // Initialization code here.
  }
  
  return self;
}

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark <Protocol Name> delegate methods

- (NSArray*)createContainersForRootViewControllers:(NSArray*)viewControllers
{
    NSMutableArray *containers = [NSMutableArray array];
    
    for (UIViewController *viewController in viewControllers) {
        UINavigationController *navigationController = [self createContainerForRootViewController:viewController];
        [containers addObject:navigationController];
    }
    
    return containers;
}

- (UINavigationController *)createContainerForRootViewController:(UIViewController *)rootViewController
{
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    
    [[navigationController navigationBar] setBarStyle:UIBarStyleBlack];
    
    if ([[navigationController navigationBar] respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) 
    {
        [[navigationController navigationBar] setBackgroundColor:[UIColor blackColor]];
        [[navigationController navigationBar] setBackgroundImage:[UIImage imageNamed:kNavigationBarBackgroundImage] forBarMetrics:UIBarMetricsDefault];
    }
    
    return navigationController;
}

// Public methods
#pragma mark -
#pragma mark Public methods

// Protected methods
#pragma mark -
#pragma mark Protected methods

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods
#pragma mark -
#pragma mark YANavigationControllerContainer ()

@end
