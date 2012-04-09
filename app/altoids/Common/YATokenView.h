//
//  YATokenView.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 8/18/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YAParticipantInfo.h"
#import "TokenFieldDelegate.h"
#import "TokenViewDelegate.h"
#import "ParticipantDescriptionBuilder.h"
#import "RegistrationRepository.h"
#import "RegistrationInfoCommandDelegate.h"
#import "SMSAddressHandleFormatValidator.h"
#import "ParticipantNameFormatter.h"

@class YATokenField;

FOUNDATION_EXPORT CGFloat const kTokenFieldHeight;
FOUNDATION_EXPORT CGFloat const kTokenFieldPaddingForOffsetY;

@interface YATokenView : UIView<TokenFieldDelegate, UITextFieldDelegate, RegistrationInfoCommandDelegate>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong, readonly) UIFont *defaultTokenFieldFont;
@property (nonatomic, strong, readonly) UITextField *textField;
@property (nonatomic, strong, readonly) NSArray *tokens;
@property (nonatomic, assign, readonly) IBOutlet id<TokenViewDelegate> delegate;

- (void)addTokenFieldWithInfo:(YAParticipantInfo *)tokenFieldInfo;
- (void)clearAllTokens;
- (NSString*)description;
- (YATokenViewDisplayMode)displayMode;
- (void)setDisplayMode:(YATokenViewDisplayMode)newDisplayMode;

- (void)injectWithParticipantDescriptionBuilder:(id<ParticipantDescriptionBuilder>)participantDescriptionBuilder 
                       participantNameFormatter:(id<ParticipantNameFormatter>)participantNameFormatter 
                smsAddressHandleFormatValidator:(id<SMSAddressHandleFormatValidator>)smsAddressHandleFormatValidator 
                         registrationRepository:(id<RegistrationRepository>)registrationRepository;

- (void)createLozengeFromPendingUserInput;

- (NSArray *)participantInfos;

@end
