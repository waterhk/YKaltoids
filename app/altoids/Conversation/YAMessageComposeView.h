//
//  YAMessageComposeView.h
//  altoids
//
//  Created by Jon Herron on 10/25/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageComposeViewDelegate.h"
#import "Delegater.h"

@interface YAMessageComposeView : UIView <UITextViewDelegate, Delegater>

typedef enum {
    ReplyStateDown = 0,
    ReplyStateUp,
    ReplyStateError
}YAReplyViewState;

@property (strong, nonatomic) IBOutlet UIView *textFieldContainterView;
@property (strong, nonatomic) IBOutlet UIView *charCountView;
@property (strong, nonatomic) IBOutlet UILabel *currentCharacterCount;
@property (strong, nonatomic) IBOutlet UIButton *sendButton;
@property (strong, nonatomic) IBOutlet UITextView *messageComposeTextView;
@property (strong, nonatomic) IBOutlet UIView *messageComposeView;

@property (assign, nonatomic) id<MessageComposeViewDelegate> messageComposeViewDelegate;
@property (assign, nonatomic) CGRect originalViewFrame;
@property (assign, nonatomic) NSUInteger maximumCharactersAllowed;
@property (assign, nonatomic) YAReplyViewState state;
@property (assign, nonatomic) CGFloat minHeight;
@property (assign, nonatomic) CGFloat maxHeight;

@property (assign, nonatomic) CGFloat textViewSingleLineHeight;
@property (assign, nonatomic) CGFloat textViewMaxHeight;
@property (assign, nonatomic) CGRect textViewDefaultFrame;
@property (assign, nonatomic) CGRect textViewMaxFrame;
@property (assign, nonatomic) CGRect containerViewDefaultFrame;
@property (assign, nonatomic) CGRect containerViewFrameWithControls;
@property (assign, nonatomic) CGSize userInputMaxSize;
@property (assign, nonatomic) CGRect messageComposeDefaultFrame;

//Allow UED to specify these values
@property (strong, nonatomic) IBOutlet UIView* ghostTextColorUED;
@property (strong, nonatomic) IBOutlet UITextField* cornerRadiusUED;
@property (strong, nonatomic) IBOutlet UITextField* borderWidthUED;
@property (strong, nonatomic) IBOutlet UIView* borderColorUED;
@property (strong, nonatomic) IBOutlet UIView* charExceededColorUED;

- (void)initialize;
- (void)renderDefaultState;
- (void)renderSingleLineEditMode;

- (void)messageComposeShouldEnd;

- (IBAction)messageSendTouchDown:(id)sender;

- (void)injectWithMessageComposeViewDelegate:(id<MessageComposeViewDelegate>)delegate 
                                         maximumCharactersAllowed:(NSUInteger)theMaximumCharactersAllowed;

@end
