//
//  YATokenField.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 8/18/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TokenFieldDelegate.h"
#import "YAParticipantInfo.h"
#import "ParticipantNameFormatter.h"
#import "SMSAddressHandleFormatValidator.h"

@interface YATokenField : UIView<UIKeyInput>

@property (nonatomic, assign, readwrite) BOOL selected;
@property (nonatomic, copy, readonly) NSString* text;
@property (nonatomic, assign, readonly) BOOL representsValidAddress;

- (id)initWithFrame:(CGRect)frame 
               text:(NSString *)text 
representsValidAddress:(BOOL)representsValidAddress
           delegate:(id<TokenFieldDelegate>)delegate;

@end
