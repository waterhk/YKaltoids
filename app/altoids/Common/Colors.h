//
//  Colors.h
//  altoids
//
//  Created by Stephane Karoubi on 9/6/11.
//  Copyright (c) 2011 Yahoo!. All rights reserved.
//

#ifndef altoids_Colors_h
#define altoids_Colors_h

#define kNavigationBarTintColor [UIColor colorWithRed:85/255.0 green:85/255.0 blue:86/255.0 alpha:1.0]
#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define kSystemMessageBackgroundColor [UIColor colorWithRed:246.0/255 green:246.0/255 blue:246.0/255 alpha:1]
#define kUnreadMessageTimestampTextColor [UIColor colorWithRed:0.0/255 green:171.0/255 blue:227.0/255 alpha:1]
#define kMessageTimestampTextColor [UIColor darkGrayColor]
#define kUnreadMessageBackgroundColor [UIColor colorWithRed:235/255.0 green:248/255.0 blue:253/255.0 alpha:1.0]
#define kConversationListCellSelectionStyleColor [UIColor colorWithRed:(135.0 / 255.0) green:(206.0 / 255.0) blue:(235.0 / 255.0) alpha: 0.3]
#define kNotificationSoundsSelectedCellTextColor [UIColor colorWithRed:0.0/255 green:171.0/255 blue:227.0/255 alpha:1]

#define kLozengeBackgroundColorForParticipantWithValidAddress RGB(198, 221, 237)
#define kLozengeBackgroundColorForParticipantWithInvalidAddress RGB(254, 147, 147)

#define kLozengeBorderColorForParticipantWithValidAddress RGB(164, 198, 217)
#define kLozengeBorderColorForParticipantWithInvalidAddress RGB(223, 60, 60)

#define kLozengeFillColor [UIColor blackColor]

#define kSelectedLozengeBackgroundColor RGB(42, 120, 219)
#define kSelectedLozengeBorderColor [UIColor clearColor]
#define kSelectedLozengeFillColor [UIColor whiteColor]

#endif
