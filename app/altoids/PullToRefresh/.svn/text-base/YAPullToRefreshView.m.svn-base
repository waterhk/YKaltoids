//
//  YAPullToRefreshView.m
//  altoids
//
//  Created by Xianzhe Ma on 2/29/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAPullToRefreshView.h"
#import "DateFormatter.h"
#import <QuartzCore/QuartzCore.h>

@interface YAPullToRefreshView ()
{
    NSString* directionText_;
    NSString* errorText_;
}

@property (nonatomic, strong, readwrite) NSDate *lastUpdateDate;
@property (nonatomic, strong) UIImage *pullDownToUpdateImage;
@property (nonatomic, strong) UIImage *releaseToUpdateImage;

- (void)spinArrowFromDegree:(NSNumber *)aFrom ToDegree:(NSNumber *)aTo;
- (void)setUIToNormalState;
- (void)setUIToPullingState;
- (void)setPullingStateArrow;
- (void)setUIToLoadingState;
- (void)setUIToErrorState;

@end

@implementation YAPullToRefreshView

@synthesize activityIndicator = activityIndicator_;
@synthesize lastUpdateTimeLabel = lastUpdateTimeLabel_;
@synthesize messageLabel = messageLabel_;
@synthesize arrowImageView = arrowImageView_;
@synthesize alignment = alignment_;
@synthesize errorLabel = errorLabel_;

@synthesize state = state_;
@synthesize errorCode = errorCode_;
@synthesize lastUpdateDate = lastUpdateDate_;
@synthesize pullDownToUpdateImage = pullDownToUpdateImage_;
@synthesize releaseToUpdateImage = releaseToUpdateImage_;
@synthesize dateFormatter = dateFormatter_;

- (id)initWithFrame:(CGRect)aFrame isPullDown:(BOOL)isPullDown withDirectionText:(NSString*)aDirectionText
{
    self = [super initWithFrame:aFrame];
    if (self) 
    {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"YAPullToRefreshView" owner:self options:nil];
        self = [nibs objectAtIndex:0];
        
        pullDownToUpdateImage_ = [UIImage imageNamed:kPullDownToUpdateImage];
        releaseToUpdateImage_ = [UIImage imageNamed:kReleaseToUpdateImage];
        directionText_ = aDirectionText;
        errorCode_ = PullToRefreshViewErrorCodeDefault;

        CGRect viewFrame = [self frame];
        CGRect alignmentFrame = [alignment_ frame];
        CGPoint top = CGPointMake(0, 0);
        CGPoint bottom = CGPointMake(0, viewFrame.size.height - alignmentFrame.size.height);
        
        if (isPullDown)
        {
            alignmentFrame.origin = bottom;
            CGRect frameAboveTableContent = CGRectOffset([self frame], 0.0f, - [self frame].size.height);
            [self setFrame:frameAboveTableContent];
        }
        else 
        {
            alignmentFrame.origin = top;
        }
        
        [alignment_ setFrame:alignmentFrame];
        
        [self setLastUpdateDateToCurrentDate];
        [self setState:PullToRefreshViewStateNormal];
        
    }
    return self;
}

- (void)setState:(PullToRefreshViewState)aState
{
    switch (aState) 
    {
        case PullToRefreshViewStateNormal:
            if ([self state] == PullToRefreshViewStatePulling) 
            {
                [self spinArrowFromDegree:[NSNumber numberWithInt:M_PI] ToDegree:[NSNumber numberWithInt:M_PI * 2]];
            }
            [self setUIToNormalState];
            break;
        case PullToRefreshViewStatePulling:
            if ([self state] == PullToRefreshViewStateNormal ||
                [self state] == PullToRefreshViewStateError) 
            {
                [self spinArrowFromDegree:[NSNumber numberWithInt:M_PI] ToDegree:[NSNumber numberWithInt:0]];
            }
            if ([self state] == PullToRefreshViewStateError)
            {
                [self setPullingStateArrow];
            }
            else 
            {
                [self setUIToPullingState];
            }
            break;
        case PullToRefreshViewStateLoading:
            [self setUIToLoadingState];
            break;
        case PullToRefreshViewStateError:
            [self setUIToErrorState];
            break;
        default:
            break;
    }
    state_ = aState;
}

- (void)setErrorCode:(PullToRefreshViewErrorCode)aErrorCode
{
    switch (aErrorCode)
    {
        case PullToRefreshViewErrorCodeNetwork:
            errorText_ = kRefreshNetworkErrorMessage;
            break;
        default:
            errorText_ = kRefreshErrorMessage;
            break;
    }
    errorCode_ = aErrorCode;
}

- (void)setErrorStateWithCode:(PullToRefreshViewErrorCode)aErrorCode
{
    [self setErrorCode:aErrorCode];
    [self setState:PullToRefreshViewStateError];
}

- (void)setLastUpdateDate:(NSDate *)aLastUpdateDate 
{
    lastUpdateDate_ = aLastUpdateDate;
    NSString *formattedDateTime = [[self dateFormatter] shortStyleStringFromDate:[self lastUpdateDate]];
    [[self lastUpdateTimeLabel] setText:[NSString stringWithFormat:@"%@ %@", kLastUpdatedLabelStringPrefix, formattedDateTime]];
}

- (void)spinArrowFromDegree:(NSNumber *)aFrom ToDegree:(NSNumber *)aTo 
{
    CABasicAnimation *spin = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    [spin setFromValue:aFrom];
    [spin setToValue:aTo];
    [spin setDuration:0.15];
    [[[self arrowImageView]layer] addAnimation:spin forKey:@"spinAnimation"];
}

- (void)setUIToNormalState 
{
    [[self messageLabel] setText:directionText_];
    [errorLabel_ setText:@""];
    [[self arrowImageView] setHidden:NO];
    [[self arrowImageView] setImage:[self pullDownToUpdateImage]];
    [[self activityIndicator] stopAnimating];
}

- (void)setUIToPullingState 
{
    [[self messageLabel] setText:kRefreshReleaseToUpdateMessage];
    [errorLabel_ setText:@""];
    [self setPullingStateArrow];
}

- (void)setPullingStateArrow 
{
    [[self arrowImageView] setHidden:NO];
    [[self arrowImageView] setImage:[self releaseToUpdateImage]];
    [[self activityIndicator] stopAnimating];
}

- (void)setUIToLoadingState 
{
    [[self messageLabel] setText:kRefreshUpdatingMessage];
    [errorLabel_ setText:@""];
    [[self arrowImageView] setHidden:YES];
    [[self activityIndicator] startAnimating];
}

- (void)setUIToErrorState 
{
    [errorLabel_ setText:errorText_];
    [[self messageLabel] setText:@""];
    [[self lastUpdateTimeLabel] setText:@""];
    [[self arrowImageView] setHidden:NO];
    [[self arrowImageView] setImage:[self pullDownToUpdateImage]];
    [[self activityIndicator] stopAnimating];
}

- (CGFloat)heightOfMessageArea 
{
    return alignment_.frame.size.height;
}

- (void)setLastUpdateDateToCurrentDate 
{
    [self setLastUpdateDate:[NSDate date]];
}

- (UIView<PullToRefreshView> *)viewValue 
{
    return self;
}

@end
