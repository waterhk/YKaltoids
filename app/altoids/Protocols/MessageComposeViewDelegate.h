//
//  MessageComposeViewDelegate.h
//  altoids
//
//  Created by Jon Herron on 10/25/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MessageComposeViewDelegate <NSObject>

@required

- (void)didBeginComposingMessage;
- (void)didEndComposingMessage;
- (void)messageComposedWithText:(NSString *)messageText;

- (void)messageComposeViewDidResizeFromFrame:(CGRect)originalFrame toFrame:(CGRect)newFrame;

- (BOOL)messageComposeViewCanEnableSendButton;

@end
