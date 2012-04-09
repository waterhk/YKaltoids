//
//  SMErrorDescriptionGenerator.m
//  SessionManager4
//
//  Created by Lei Cai on 8/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "YSMErrorDescriptionGenerator.h"

@implementation YSMErrorDescriptionGenerator

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (NSString*)descriptionFromErrorCode:(NSInteger)aErrorCode
{
    NSString *errorDescription = nil;
	
	switch (aErrorCode) {
		case HttpTransportError:
			errorDescription = NSLocalizedString(@"Failed to retrieve data from the server", @"Login server error description");
			break;
		case GeneralError:
			errorDescription = NSLocalizedString(@"General server error", @"Login server error description");
			break;
		case UDBisDownError:
			errorDescription = NSLocalizedString(@"UDB is down", @"Login server error description");
			break;
		case InvalidCredentialsError:
			errorDescription = NSLocalizedString(@"Invalid user ID or password", @"Login server error description");
			break;
		case AntibotStateError:
			errorDescription = NSLocalizedString(@"Account is in antibot state", @"Login server error description");
			break;
		case AntibotStateMaxTriesError:
			errorDescription = NSLocalizedString(@"Account is in antibot state, maximum tries reached", @"Login server error description");
			break;
		case LockedStateError:
			errorDescription = NSLocalizedStringWithDefaultValue(@"Login server forgot password error", nil, [NSBundle mainBundle],
																 @"Your account has been locked. Please use 'Forgot Password...' flow on the Yahoo! Messenger client on your desktop to start the unlocking process.",
																 @"Login server error description");
			break;
		case SpecialHandlingFlagError:
			errorDescription = NSLocalizedString(@"Special handling flag is set, try to login from web", @"Login server error description");
			break;
		case InvalidUidError:
			errorDescription = NSLocalizedString(@"User ID is invalid", @"Login server error description");
			break;
		case SystemIsDownError:
			errorDescription = NSLocalizedString(@"System is momemtarily down", @"Login server error description");
			break;
		case UserIsUnderAge:
			errorDescription = NSLocalizedString(@"User is under age", @"Login server error description");
			break;
        case RequiredFieldUserIDMissing:
            errorDescription = NSLocalizedString(@"User ID is required", @"Required field User ID is missing");
            break;
        case RequiredFieldPasswordMissing:
            errorDescription = NSLocalizedString(@"Password is required", @"Required field Password is missing");
            break;
		default:
			errorDescription = NSLocalizedString(@"Failed due to an unknown reason", @"Login server error description");
			break;
	}
    
	return errorDescription;
}

@end
