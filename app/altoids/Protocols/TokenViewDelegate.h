//
//  TokenViewDelegate.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 8/22/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YATokenView;
@class YATokenField;

@protocol TokenViewDelegate <NSObject>

#pragma mark -
#pragma mark @required
@required

- (void)tokenView:(YATokenView*)tokenView textFieldValueDidChange:(NSString*)changedValue;
- (void)tokenView:(YATokenView*)tokenView textFieldValueDidCommit:(NSString*)committedValue;
- (void)tokenView:(YATokenView *)tokenView didSelectInvalidToken:(YATokenField*)invalidToken withAddressHandle:(NSString *)addressHandle;
- (void)tokenView:(YATokenView *)tokenView didSelectValidToken:(YATokenField*)validToken withAddressHandle:(NSString *)addressHandle;
- (void)didReceiveFocus;
- (void)tokenView:(YATokenView *)tokenView didResizeToRect:(CGRect)toRect fromRect:(CGRect)fromRect;
- (void)tokenView:(YATokenView *)tokenView displayModeDidChange:(YATokenViewDisplayMode)displayMode;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
