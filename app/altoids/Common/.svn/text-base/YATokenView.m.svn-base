//
//  YATokenView.m
//  altoids
//
//  Created by Srinivas Raovasudeva on 8/18/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "YATokenView.h"
#import "YATokenField.h"
#import "YAParticipantNameFormatter.h"
#import "YASMSAddressHandleFormatValidator.h"

@interface YATokenView () 

@property (nonatomic, strong, readwrite) UITextField *textField;
@property (nonatomic, assign, readwrite) IBOutlet id<TokenViewDelegate> delegate;
@property (nonatomic, assign) CGPoint offSet;

@property (nonatomic, strong, readwrite) UILabel *titleLabel;
@property (nonatomic, strong, readwrite) UILabel *descriptionLabel;
@property (nonatomic, assign, readwrite) YATokenViewDisplayMode displayMode;
@property (strong, nonatomic) YAParticipantNameFormatter *participantNameFormatter;
@property (strong, nonatomic) YASMSAddressHandleFormatValidator *smsAddressHandleFormatValidator;
@property (strong, nonatomic) id<ParticipantDescriptionBuilder> participantDescriptionBuilder;
@property (nonatomic, strong) id<RegistrationRepository> registrationRepository;
@property (strong, nonatomic) NSCharacterSet *nonPhoneNumberCharacters;

@property (strong, nonatomic) NSMutableArray *tokenFields;
@property (strong, nonatomic) NSMutableDictionary *tokenFieldsToParticipantInfos;

- (void)initialize;
- (void)upsertTextFieldAndSetFirstResponder;
- (void)textFieldDidChange:(UITextField*)aTextField;

- (void)updateViewForTokenField:(YATokenField*)tokenField;
- (void)updateTokenOffset:(CGPoint)anOffset;
- (void)clearSelectionForAllTokens;
- (BOOL)hasTokenInfo:(YAParticipantInfo *)aTokenInfo;
- (void)displayErrorForMaxParticipants:(NSUInteger)maxParticipants;
- (void)didReceiveFocus;
- (void)didLoseFocus;

- (void)markAllTokensAsVisible:(BOOL)visible;

- (void)addTitleViewWithTitle:(NSString*)aTitle;
- (void)upsertDescriptionLabelWithText:(NSString*)newDescription;

- (void)createLozengeFromCurrentUserInputInTextField:(UITextField *)textField;

@end

CGFloat const kTitleLabelOffsetX = 5.0;
CGFloat const kTitleLabelOffsetY = 10.0;
CGFloat const kTitleLabelMaxWidth = 40.0;
CGFloat const kTitleLabelMaxHeight = 15.0;

CGFloat const kDescriptionLabelOffsetX = 5.0;
CGFloat const kDescriptionLabelOffsetY = 10.0;
CGFloat const kDescriptionLabelMinWidth = 200.0; // TODO: Remove if not necessary
CGFloat const kDescriptionLabelMaxHeight = 15.0;

CGFloat const kTokenFieldStartOffsetX = 5.0;
CGFloat const kTokenFieldStartOffsetY = 5.0;
CGFloat const kTokenFieldStartHeightPadding = 5.0;

CGFloat const kTokenFieldMaxConstrainedWidth = 200.0;
CGFloat const kTokenFieldMinConstrainedWidth = 100.0;
CGFloat const kTokenFieldHeight = 22.0; // FOUNDATION_EXPORT
CGFloat const kTokenFieldWidthPadding = 10.0;

CGFloat const kTokenFieldPaddingForOffsetX = 8.0; // FOUNDATION_EXPORT
CGFloat const kTokenFieldPaddingForOffsetY = 10.0;

CGFloat const kTokenFieldDefaultFontSize = 14.0;

NSString* const kTextFieldEmptySpacePlaceHolder = @"\u200B";

@implementation YATokenView

@synthesize title = title_;
@synthesize defaultTokenFieldFont = defaultTokenFieldFont_;
@synthesize offSet = offSet_;
@synthesize tokens = tokens_;
@synthesize delegate = delegate_;

@synthesize textField = textField_;
@synthesize titleLabel = titleLabel_;
@synthesize descriptionLabel = descriptionLabel_;
@synthesize displayMode = displayMode_;
@synthesize participantDescriptionBuilder = participantDescriptionBuilder_;

@synthesize participantNameFormatter = participantNameFormatter_;
@synthesize smsAddressHandleFormatValidator = smsAddressHandleFormatValidator_;

@synthesize registrationRepository = registrationRepository_;

@synthesize nonPhoneNumberCharacters = nonPhoneNumberCharacters_;

@synthesize tokenFields = tokenFields_;
@synthesize tokenFieldsToParticipantInfos = tokenFieldsToParticipantInfos_;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        CGRect frame = [self frame];
        frame.size.height = kTokenFieldHeight + kTokenFieldPaddingForOffsetY + kTokenFieldStartHeightPadding;
        [self setFrame:frame];        

        displayMode_ = YATokenViewDisplayTokens;
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    [self addTitleViewWithTitle:[self title]];
    
    CGPoint initialOffset = CGPointMake([self titleLabel].frame.origin.x+[self titleLabel].frame.size.width, kTokenFieldStartOffsetY);
    offSet_ = initialOffset;
    
    [self upsertDescriptionLabelWithText:nil];
    [self upsertTextFieldAndSetFirstResponder];
    
    tokenFields_ = [NSMutableArray arrayWithCapacity:kMaxNumberOfParticipants];
    tokenFieldsToParticipantInfos_ = [NSMutableDictionary dictionaryWithCapacity:kMaxNumberOfParticipants];
    
    [textField_ setKeyboardType:UIKeyboardTypeEmailAddress];
}

- (void)dealloc
{
    [[self textField] removeTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)injectWithParticipantDescriptionBuilder:(id<ParticipantDescriptionBuilder>)participantDescriptionBuilder 
                       participantNameFormatter:(id<ParticipantNameFormatter>)participantNameFormatter 
                smsAddressHandleFormatValidator:(id<SMSAddressHandleFormatValidator>)smsAddressHandleFormatValidator 
                         registrationRepository:(id<RegistrationRepository>)registrationRepository
{
    [self setParticipantDescriptionBuilder:participantDescriptionBuilder];
    [self setParticipantNameFormatter:participantNameFormatter];
    [self setSmsAddressHandleFormatValidator:smsAddressHandleFormatValidator];
    [self setRegistrationRepository:registrationRepository];
}

- (void)addTokenFieldWithInfo:(YAParticipantInfo *)participantInfo
{
    if ([self hasTokenInfo:participantInfo]) {
        [[self textField] setText:kTextFieldEmptySpacePlaceHolder];
        return;        
    }
    
    if ([[self tokens] count] >= kMaxNumberOfParticipants) {
        [[self textField] setText:kTextFieldEmptySpacePlaceHolder];
        [self displayErrorForMaxParticipants:kMaxNumberOfParticipants];
        return;
    }
    
    YAAddressInfo *address = [participantInfo addressInfo];
    
    [[self registrationRepository] requestRegistrationInformationForAddress:address delegate:self];
    
    // todo: move this logic to tokenFieldCreator
    NSString *tokenfieldText = [participantNameFormatter_ formatDisplayNameForParticipantInfo:participantInfo];
    BOOL tokenRepresentsValidAddress = [smsAddressHandleFormatValidator_ validHandleForSMSAddress:[participantInfo addressInfo]];
        
    CGRect frame = CGRectMake([self offSet].x, [self offSet].y, 0, kTokenFieldHeight);
    
    YATokenField *tokenField = [[YATokenField alloc] initWithFrame:frame 
                                                              text:tokenfieldText 
                                           representsValidAddress:tokenRepresentsValidAddress
                                                          delegate:self];
    
    [self storeTokenField:tokenField withParticipantInfo:participantInfo];
    
    [self addSubview:tokenField];
    
    [self updateViewForTokenField:tokenField];    
}

- (UIFont*)defaultTokenFieldFont
{
    return [UIFont boldSystemFontOfSize:kTokenFieldDefaultFontSize];
}

- (NSArray*)tokens
{
    return tokenFields_;
}

- (NSArray *)participantInfos
{
    return [tokenFieldsToParticipantInfos_ allValues];
}

- (NSString*)title
{
    if (!title_) {
        [self setTitle:kTokenViewDefaultTitle];
    }
    
    return title_;
}

- (NSString*)description
{   
    return [[self participantDescriptionBuilder] descriptionForParticipantInfos:[tokenFieldsToParticipantInfos_ allValues] forDisplayInLabel:[self descriptionLabel]];
}

- (void)clearAllTokens
{
    for (id tokenField in [self subviews]) {
        if ([tokenField isKindOfClass:[YATokenField class]]) {
            [tokenField removeFromSuperview];
            [self forgetTokenField:tokenField];
        }
    }
    
    CGPoint initialOffset = CGPointMake([self titleLabel].frame.origin.x+[self titleLabel].frame.size.width, kTokenFieldStartOffsetY);
    [self setOffSet:initialOffset];
    [self upsertTextFieldAndSetFirstResponder];
        
    CGRect tokenViewFrame = [self frame];
    tokenViewFrame.size.height = kTokenFieldHeight+kTokenFieldPaddingForOffsetY;
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         [self setFrame:tokenViewFrame];
                     }completion:^(BOOL finished) {
                     }];
}

- (YATokenViewDisplayMode)displayMode
{
    return displayMode_;
}

- (void)setDisplayMode:(YATokenViewDisplayMode)newDisplayMode
{
    if ([self displayMode]==newDisplayMode) {
        return;
    }
    
    displayMode_ = newDisplayMode;
    
    switch ([self displayMode]) {
        case YATokenViewDisplayTokens:
            [self markAllTokensAsVisible:YES];
            [[self descriptionLabel] setHidden:YES];
            
            break;

        case YATokenViewDisplayDescription:
            [self markAllTokensAsVisible:NO];
            [self upsertDescriptionLabelWithText:[self description]];
            [[self descriptionLabel] setHidden:NO];

            break;
            
        default:
            [self markAllTokensAsVisible:YES];
            [[self descriptionLabel] setHidden:YES];            
            break;
    }
    
    [self setNeedsLayout];
    [[self delegate] tokenView:self displayModeDidChange:[self displayMode]];
}

- (void)createLozengeFromPendingUserInput
{
    [self createLozengeFromCurrentUserInputInTextField:[self textField]];
}

- (void)layoutSubviews
{
    if (displayMode_ == YATokenViewDisplayDescription) 
    {
        [self layoutSubviewsForDescriptionDisplay];
    }
    else 
    {
        [self layoutSubviewsForTokenDisplay];
    }
}

- (void)layoutSubviewsForDescriptionDisplay
{
    CGRect tokenViewFrame = [self frame];
    CGFloat descriptionHeight = kDescriptionLabelMaxHeight + kDescriptionLabelOffsetY + kDescriptionLabelOffsetY;
    
    if (tokenViewFrame.size.height != descriptionHeight) 
    {
        CGRect oldTokenViewFrame = tokenViewFrame;
        
        tokenViewFrame.size.height = descriptionHeight;
        
        [UIView animateWithDuration:0.3 animations:^{
            [self setFrame:tokenViewFrame];
            [delegate_ tokenView:self didResizeToRect:tokenViewFrame fromRect:oldTokenViewFrame];
        }];
    }
}

- (void)layoutSubviewsForTokenDisplay
{
    CGRect tokenViewFrame = [self frame];
    CGRect textFieldFrame = [textField_ frame];
    
    CGFloat tokenViewBottom = tokenViewFrame.origin.y + tokenViewFrame.size.height;
    CGFloat textFieldBottom = tokenViewFrame.origin.y + textFieldFrame.origin.y + textFieldFrame.size.height;
    
    CGFloat expectedTokenViewBottom = textFieldBottom + kTokenFieldPaddingForOffsetY;
    
    if (tokenViewBottom != expectedTokenViewBottom)
    {
        CGRect oldTokenViewFrame = tokenViewFrame;
        CGFloat heightDifference = expectedTokenViewBottom - tokenViewBottom;
        
        tokenViewFrame.size.height += heightDifference;
        
        [UIView animateWithDuration:0.3 animations:^{
            [self setFrame:tokenViewFrame];
            [delegate_ tokenView:self didResizeToRect:tokenViewFrame fromRect:oldTokenViewFrame];
        }];
    }
}

- (void)willSelectToken:(YATokenField*)token
{
    [self clearSelectionForAllTokens];
}

- (void)didSelectToken:(YATokenField*)token
{
    [token setSelected:YES];
    
    YAParticipantInfo *participantInfo = [tokenFieldsToParticipantInfos_ objectForKey:[NSValue valueWithNonretainedObject:token]];
    NSString *addressHandle = [[participantInfo addressInfo] handle];
    
    if ([token representsValidAddress]) 
    {
        [delegate_ tokenView:self didSelectValidToken:token withAddressHandle:addressHandle];
    }
    else
    {
        [delegate_ tokenView:self didSelectInvalidToken:token withAddressHandle:addressHandle];
    }
}

- (void)willDeleteToken:(YATokenField*)token
{
    [self forgetTokenField:token];
    
    [[self textField] setText:kTextFieldEmptySpacePlaceHolder];
    [[self textField] becomeFirstResponder];
}

- (void)didDeleteToken:(YATokenField*)token
{
    BOOL canStartUpdatingOffset = NO;
    CGPoint currentTokenOffset = token.frame.origin;
    Class tokenFieldClass = [YATokenField class];
    
    for (id tokenField in [self subviews]) 
    {
        if (![tokenField isKindOfClass:tokenFieldClass]) 
        {
            continue;
        }
        
        if (tokenField == token) 
        {
            canStartUpdatingOffset = YES;
            continue;
        }
        
        if (!canStartUpdatingOffset) 
        {
            continue;
        }
        
        CGRect tokenFieldFrame = [tokenField frame];
        
        // If we cannot move the token to the current token offset
        // so we simply ensure the token is at the start offset for x (=5)
        if (currentTokenOffset.x + tokenFieldFrame.size.width > self.frame.size.width) 
        {
            if (tokenFieldFrame.origin.x != kTokenFieldStartOffsetX) 
            {
                tokenFieldFrame.origin.x = kTokenFieldStartOffsetX;
            }
            
            // ...AND we update the token's y offset only if there is a gap
            // greater than the height of a token
            if (tokenFieldFrame.origin.y - currentTokenOffset.y + kTokenFieldHeight > kTokenFieldHeight) 
            {
                tokenFieldFrame.origin.y -= kTokenFieldHeight + kTokenFieldPaddingForOffsetY;
            }
            
        }
        else 
        {
            // The token can be moved to the current offset
            // so update x and y
            tokenFieldFrame.origin = currentTokenOffset;
        }
        
        [tokenField setFrame:tokenFieldFrame];
        
        // Now update the current offset
        CGFloat newOffsetX = tokenFieldFrame.origin.x + tokenFieldFrame.size.width + kTokenFieldPaddingForOffsetX;                
        currentTokenOffset = CGPointMake(newOffsetX, tokenFieldFrame.origin.y);
    }
    
    // update the offset for the text field
    // remove the token from the tokens array
    [self updateTokenOffset:currentTokenOffset];
    [self upsertTextFieldAndSetFirstResponder];
    [self forgetTokenField:token];
    
    [self setNeedsDisplay];
}

- (NSCharacterSet *)nonPhoneNumberCharacters
{
    if (nonPhoneNumberCharacters_) 
    {
        return nonPhoneNumberCharacters_;
    }
    
    nonPhoneNumberCharacters_ = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789+.()-"] invertedSet];
    
    return nonPhoneNumberCharacters_;
}

- (BOOL)textField:(UITextField *)aTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@""] && [[aTextField text] isEqualToString:kTextFieldEmptySpacePlaceHolder]){
        // Backspace called on 'empty' field.
        
        [[tokenFields_ lastObject] setSelected:YES];

        return NO;
    }
    
    if ([string isEqualToString:@","] || [string isEqualToString:@";"]) 
    {
        [self createLozengeFromPendingUserInput];
        
        return NO;
    }
    
    if ([string isEqualToString:@" "]) 
    {
        NSString *userInput = [[aTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSRange nonPhoneNumberCharacterRange = [userInput rangeOfCharacterFromSet:[self nonPhoneNumberCharacters]];
        
        if (nonPhoneNumberCharacterRange.location == NSNotFound) 
        {
            [self createLozengeFromPendingUserInput];
            
            return NO;
        }
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)aTextField
{
    [self createLozengeFromCurrentUserInputInTextField:aTextField];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self didReceiveFocus];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self didLoseFocus];
}

- (void)textFieldDidChange:(UITextField*)aTextField
{
    NSString* changedValue = [[aTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    [[self delegate] tokenView:self textFieldValueDidChange:changedValue];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[self textField] setAlpha:1.0];
    [[self textField] setText:kTextFieldEmptySpacePlaceHolder];
    [[self textField] becomeFirstResponder];

    [self didReceiveFocus];
}

- (void)addTitleViewWithTitle:(NSString*)aTitle
{
    if (![self titleLabel]) {
        [self setTitleLabel:[[UILabel alloc] initWithFrame:CGRectMake(kTitleLabelOffsetX, kTitleLabelOffsetY, kTitleLabelMaxWidth, kTitleLabelMaxHeight)]];
        [[self titleLabel] setNumberOfLines:1];
        [[self titleLabel] setTextAlignment:UITextAlignmentCenter];
        [[self titleLabel] setTextColor:[UIColor grayColor]];
        [[self titleLabel] setUserInteractionEnabled:NO];
        [[self titleLabel] setFont:[UIFont systemFontOfSize:14]];
        [[self titleLabel] setText:aTitle];
        
        [self addSubview:[self titleLabel]];
    }
}

- (void)upsertTextFieldAndSetFirstResponder
{
    if (![self textField]) {
        [self setTextField:[[UITextField alloc] initWithFrame:CGRectMake([self offSet].x, [self offSet].y, kTokenFieldMinConstrainedWidth, kTokenFieldHeight)]];
        [[self textField] setDelegate:self];
        [[self textField] setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [[self textField] setAutocorrectionType:UITextAutocorrectionTypeNo];
        
        // Add a "textFieldDidChange" notification method to the text field control.
        [[self textField] addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

        [self addSubview:[self textField]];
    }
    else {
        CGRect textFieldFrame = [[self textField] frame];
        textFieldFrame.origin.x = [self offSet].x;
        textFieldFrame.origin.y = [self offSet].y;
        [[self textField] setFrame:textFieldFrame];
    }
    
    [[self textField] setText:kTextFieldEmptySpacePlaceHolder];
    [[self textField] becomeFirstResponder];
}

- (void)updateViewForTokenField:(YATokenField*)tokenField
{
    CGSize tokenFieldSizeForDefaultFont = [[tokenField text] sizeWithFont:[self defaultTokenFieldFont] 
                                                                 forWidth:kTokenFieldMaxConstrainedWidth 
                                                            lineBreakMode:UILineBreakModeMiddleTruncation];
    
    CGRect tokenFieldFrame = [tokenField frame];
    
    if (tokenFieldFrame.size.width < tokenFieldSizeForDefaultFont.width) {
        tokenFieldFrame.size.width = tokenFieldSizeForDefaultFont.width+kTokenFieldWidthPadding;
        
        CGFloat newOffsetX = tokenFieldFrame.origin.x+tokenFieldFrame.size.width+kTokenFieldPaddingForOffsetX;
        
        CGFloat newOffsetY = tokenFieldFrame.origin.y;
        BOOL didMoveTokenToNewRow = NO;
        
        // If the token field's offset overlaps with the token view's
        // frame, then move the token field to next row
        if (newOffsetX > self.frame.size.width) {
            newOffsetX = kTokenFieldStartOffsetX;
            newOffsetY += kTokenFieldHeight+kTokenFieldPaddingForOffsetY;
            
            tokenFieldFrame.origin.x = newOffsetX;
            tokenFieldFrame.origin.y = newOffsetY;
            
            didMoveTokenToNewRow = YES;
        }

        if (didMoveTokenToNewRow) 
        {
            [self updateTokenOffset:CGPointMake(newOffsetX+tokenFieldFrame.size.width+kTokenFieldPaddingForOffsetX, newOffsetY)];
        }
        else 
        {
            [self updateTokenOffset:CGPointMake(newOffsetX, newOffsetY)];    
        }
        
        [self setNeedsLayout];
        
        // update text field and make it the first responder
        [self upsertTextFieldAndSetFirstResponder];
        
        [tokenField setFrame:tokenFieldFrame];
    }
}

- (void)updateTokenOffset:(CGPoint)anOffset
{
    // Even after adjusting the token field to fit on the row
    // we still need to check if the text field has enough space
    // (dictated by kTokenFieldMinConstrainedWidth) for user to type
    // If the text field does not have enough space on the same line
    // then we move it down to next row
    CGFloat newOffsetX = anOffset.x;
    CGFloat newOffsetY = anOffset.y;
    
    CGFloat gapAfterTokenField = self.frame.size.width - newOffsetX;

    if (gapAfterTokenField < kTokenFieldMinConstrainedWidth) {
        newOffsetX = kTokenFieldStartOffsetX;
        newOffsetY += kTokenFieldHeight+kTokenFieldPaddingForOffsetY;
        
        [self setOffSet:CGPointMake(newOffsetX, newOffsetY)];
    }
    else {
        [self setOffSet:CGPointMake(newOffsetX, newOffsetY)];
    }    
}

- (void)clearSelectionForAllTokens
{
    for (YATokenField *tokenField in [self tokens]) {
        [tokenField setSelected:NO];
    }    
}

- (BOOL)hasTokenInfo:(YAParticipantInfo *)aTokenInfo
{
    for (YATokenField *tokenField in [self tokens]) {
        YAParticipantInfo *representedObject = [tokenFieldsToParticipantInfos_ objectForKey:[NSValue valueWithNonretainedObject:tokenField]];
        if ([[[self participantNameFormatter] formatDisplayNameForParticipantInfo:representedObject] isEqualToString:[[self participantNameFormatter] formatDisplayNameForParticipantInfo:aTokenInfo]] &&
            [[[representedObject addressInfo] handle] isEqualToString:[[aTokenInfo addressInfo] handle]]) {
            return YES;
        }
    }
    
    return NO;
}

- (void)displayErrorForMaxParticipants:(NSUInteger)maxParticipants
{
    NSString *alertTitle = [NSString stringWithFormat:@"%d Contacts Maximum",maxParticipants];
    NSString *message = [NSString stringWithFormat:@"You have reached the %d contact maximum for a group conversation",maxParticipants];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(alertTitle, @"YAMultiParticipantPickerViewController - _displayMaxParticipantsSelectedError method") 
                                                    message:NSLocalizedString(message, @"YAMultiParticipantPickerViewController - _displayMaxParticipantsSelectedError method") 
                                                   delegate:nil 
                                          cancelButtonTitle:NSLocalizedString(@"Ok", @"YAMultiParticipantPickerViewController - _displayMaxParticipantsSelectedError method") 
                                          otherButtonTitles:nil, nil];
    [alert show];
}

- (void)didReceiveFocus
{
    [self clearSelectionForAllTokens];

    [self setDisplayMode:YATokenViewDisplayTokens];
    
    // invoke delegate
    if ([self delegate] && [[self delegate] respondsToSelector:@selector(didReceiveFocus)]) {
        [[self delegate] didReceiveFocus];
    }
}

- (void)didLoseFocus
{   
    for (YATokenField *tokenField in [self tokens]) {
        if ([tokenField selected]) {
            return;
        }
    }
    
    [self setDisplayMode:YATokenViewDisplayDescription];
}

- (void)markAllTokensAsVisible:(BOOL)visible
{
    for (YATokenField *tokenField in [self tokens]) {
        [tokenField setHidden:!visible];
    }
}

- (void)upsertDescriptionLabelWithText:(NSString*)newDescription
{
    if (![self descriptionLabel]) {
        UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDescriptionLabelOffsetX, kDescriptionLabelOffsetY, [self frame].size.width-40, kDescriptionLabelMaxHeight)];
        [descLabel setFont:[UIFont systemFontOfSize:14.0]];
        [descLabel setMinimumFontSize:12.0];
        [descLabel setNumberOfLines:1];
        [descLabel setTextColor:[UIColor blackColor]];
        [descLabel setTextAlignment:UITextAlignmentLeft];
        [descLabel setHidden:YES];
        
        [self setDescriptionLabel:descLabel];
        [self addSubview:[self descriptionLabel]];
    }
    
    [[self descriptionLabel] setText:newDescription];
}

- (void)registrationInfoDidFailToSaveWithError:(NSError *)error
{
}

- (void)registrationInfoDidSaveWithHandleToObjectIDMap:(NSDictionary *)handleToObjectIDMap
{   
}

- (void)createLozengeFromCurrentUserInputInTextField:(UITextField *)textField
{
    NSString* committedValue = [[textField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([committedValue length] > 0) 
    {
        [[self delegate] tokenView:self textFieldValueDidCommit:committedValue];
    }
}

- (void)storeTokenField:(YATokenField *)tokenField withParticipantInfo:(YAParticipantInfo *)participantInfo
{
    [tokenFieldsToParticipantInfos_ setObject:participantInfo forKey:[NSValue valueWithNonretainedObject:tokenField]];
    [tokenFields_ addObject:tokenField];
}

- (void)forgetTokenField:(YATokenField *)tokenField
{
    [tokenFields_ removeObject:tokenField];
    [tokenFieldsToParticipantInfos_ removeObjectForKey:[NSValue valueWithNonretainedObject:tokenField]];
}

@end
