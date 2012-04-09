//
//  ContactPickerDetailViewControllerDelegate.h
//  altoids
//
//  Created by Derrick Whittle on 3/29/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ContactPickerDetailViewController;
@class YAContactEndpoint;

@protocol ContactPickerDetailViewControllerDelegate <NSObject>

- (void) contactPickerDetailViewController:(id<ContactPickerDetailViewController>)contactPickerDetailViewController didSelectContactEndpoint:(YAContactEndpoint*)contactEndpoint;

@end
