//
//  Strings.h
//  altoids
//
//  Created by Jon Herron on 9/8/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#ifndef ALTOIDS_STRINGS_H
#define ALTOIDS_STRINGS_H

#define kOnText NSLocalizedString(@"On", @"On")
#define kOffText NSLocalizedString(@"Off", @"Off")
#define kErrorTitle NSLocalizedString(@"Error", @"Title for displaying error mesage")
#define kOkButtonText NSLocalizedString(@"OK", @"Generic OK button text")

#define kTimeElapsedJustNow NSLocalizedString(@"Just now", @"Used to indicate conversation created few seconds ago")

// button text
#define kBackButtonText NSLocalizedString(@"Back", @"Back button text")
#define kCancelButtonText NSLocalizedString(@"Cancel", @"Cancel button text")
#define kContinueButtonText NSLocalizedString(@"Continue", @"Continue button text")
#define kSendButtonText NSLocalizedString(@"Send", @"Send button text")
#define kEditButtonText NSLocalizedString(@"Edit", @"Edit button text")
#define kDoneButtonText NSLocalizedString(@"Done", @"Done button text")
#define kLoginButtonText NSLocalizedString(@"Sign In", @"Login button text")
#define kYahooButtonText NSLocalizedString(@"Sign Up", @"Sign up button text")

#define kReplyToConversationHint NSLocalizedString(@"Type a message...", @"Hint to the user this is where they reply to the conversation")

// label text
#define kUsernameLabelText NSLocalizedString(@"Yahoo! ID", @"Username label text")
#define kUsernameGhostText NSLocalizedString(@"example@yahoo.com", @"Username ghost text")
#define kPasswordLabelText NSLocalizedString(@"Password", @"Password label text")
#define kPasswordGhostText NSLocalizedString(@"Required", @"Password ghost text")
#define kDisclaimerText NSLocalizedString(@"Signing in will send a one time SMS message to verify your phone number. Carrier SMS charges may apply.", @"Disclaimer label text")
#define kVersionText NSLocalizedString(@"Version 1.0", @"Version # label text")
#define kCopyrightText NSLocalizedString(@"Copyright \xC2\xA9 2012 Yahoo! Inc. All rights reserved.", @"Copyright label text")

// Participant list description suffixes

#define kOneMoreParticipant NSLocalizedString(@"& 1 more", @"One more participant")
#define kTwoMoreParticipants NSLocalizedString(@"& 2 more", @"Two more participants")
#define kThreeMoreParticipants NSLocalizedString(@"& 3 more", @"Three more participants")
#define kFourMoreParticipants NSLocalizedString(@"& 4 more", @"Four more participants")
#define kFiveMoreParticipants NSLocalizedString(@"& 5 more", @"Five more participants")

#define kMoreParticipants NSLocalizedString(@" & %d more", @"More participants than can be displayed")
#define kAndUserAsParticipant NSLocalizedString(@" & You", @"User is participant in conversation")
#define kUserAsOnlyParticipant NSLocalizedString(@"You", @"User is only participant in conversation")

#define kZeroParticipants NSLocalizedString(@"Add participants", @"Add participants message when user steps off To: field without adding any participants")

#define kNoParticipantsInConversationMessage NSLocalizedString(@"No Participants", @"No participants in existing conversation")

#define kConversationDetailsTitle NSLocalizedString(@"Conversation Details", @"Conversation Details View Title")
#define kConversationDetailsMuteConversationText NSLocalizedString(@"Mute Conversation", @"Conversation Details Mute Conversation option")
#define kConversationDetailsMuteConversationSectionFooterText NSLocalizedString(@"Notifications for this Conversation", @"Mute Conversation section footer text")
#define kConversationDetailsParticipantsSectionHeaderText NSLocalizedString(@"Participants", @"Participants Section header text")
#define kConversationDetailsAddParticipantText NSLocalizedString(@"Add Participant...", @"Conversation Details Add Participant option")
#define kConversationDetailsLeaveConversationText NSLocalizedString(@"Leave Conversation", @"Conversation Details Leave Conversation option")

#define kParticipantInfoTitle NSLocalizedString(@"Participant Info", @"Participant Info Title")
#define kParticipantInfoParticipantIsNotAContact NSLocalizedString(@"Not in your Contacts", @"Participant is not a local contact")
#define KParticipantInfoRemoveFromConversation NSLocalizedString(@"Remove from Conversation", @"Participant Info remove from conversation option")

#define kRemoveFromConversationConfirmationDialogTitle NSLocalizedString(@"Remove from Conversation", @"Remove from Conversation confirmation dialog title")
#define kRemoveFromConverastionConfirmationDialogSingleParticipantText NSLocalizedString(@"Are you sure you want to remove the contact from the conversation?", @"Remove from conversation confirmation dialog body when removing a single participant")

#define kUserProfileViewControllerTitle NSLocalizedString(@"Profile", @"Title for user profile view controller")

// Settings View Controller
#define kSettingsOptionsHeaderTitle NSLocalizedString(@"Options", @"Section header title for settings view controller")
#define kSettingsOptionsHeaderCellOneTitle NSLocalizedString(@"Notification Sound", @"Title for the first cell of the options section header, for settings view controller")
#define kSettingsOptionsHeaderCellTwoTitle NSLocalizedString(@"Report a Problem", @"Title for the second cell of the options section header, for settings view controller")
#define kSettingsOptionsHeaderCellThreeTitle NSLocalizedString(@"About", @"Title for the third cell of the options section header, for settings view controller")
#define kSettingsOptionsHeaderCellFourTitle NSLocalizedString(@"Deactivate Device", @"Title for the fourth cell of the options section header, for settings view controller")
#define kSettingsAccountHeaderCellOneTitle NSLocalizedString(@"Upgrade Account", @"Title for the first cell of the account section header, for settings view controller")

// About View Controller
#define kAboutCellOneTitle NSLocalizedString(@"Version", @"Title for the first cell of the about table, for about view controller")
#define kAboutCellTwoTitle NSLocalizedString(@"Legal Notes", @"Title for the second cell of the about table, for about view controller")
#define kAboutTitle NSLocalizedString(@"About", @"About list view title")

// Report a Problem ViewController
#define kReportProblemViewControllerTitle NSLocalizedString(@"Report Problem", @"Title for report problem view controller")
#define kReportProblemCellTwoTitle NSLocalizedString(@"Debug Logs Included", @"Title for the second cell of the report problem table, for report problem view controller")

// Legal View Controller
#define kLegalCellOneTitle NSLocalizedString(@"Terms of Service", @"Title for the first cell of the legal table, for legal view controller")
#define kLegalCellTwoTitle NSLocalizedString(@"Privacy Policy", @"Title for the second cell of the legal table, for legal view controller")
#define kLegalCellThreeTitle NSLocalizedString(@"Copyright/Legal Notice", @"Title for the third cell of the legal table, for legal view controller")
#define kLegalTitle NSLocalizedString(@"Legal", @"Legal list view title")

// Legal Web Pages ViewController
#define kLegalWebPagesLoadingTitle NSLocalizedString(@"Loading...", @"Legal Web Pages list view title")

// Notification and Sounds View Controller
#define kSoundsCellOneTitle NSLocalizedString(@"Sound 1", @"Title for the first cell of the sounds table, for notification sounds view controller")
#define kSoundsCellTwoTitle NSLocalizedString(@"Sound 2", @"Title for the second cell of the sounds table, for notification sounds view controller")
#define kSoundsCellThreeTitle NSLocalizedString(@"Sound 3", @"Title for the third cell of the sounds table, for notification sounds view controller")
#define kSoundsCellFourTitle NSLocalizedString(@"Sound 4", @"Title for the fourth cell of the sounds table, for notification sounds view controller")
#define kSoundsCellFiveTitle NSLocalizedString(@"Sound 5", @"Title for the fifth cell of the sounds table, for notification sounds view controller")
#define kSoundsCellSixTitle NSLocalizedString(@"Sound 6", @"Title for the sixth cell of the sounds table, for notification sounds view controller")
#define kSoundsCellSevenTitle NSLocalizedString(@"Sound 7", @"Title for the seventh cell of the sounds table, for notification sounds view controller")
#define kSoundsCellEightTitle NSLocalizedString(@"Sound 8", @"Title for the eighth cell of the sounds table, for notification sounds view controller")
#define kNotificationSoundsTitle NSLocalizedString(@"Notification Sound", @"Notification and sounds list view title")

// Deactivate View Controller
#define kDeactivateCellOneTitle NSLocalizedString(@"Deactivate", @"Title for the first cell of the deactivate table, for deactivate view controller")
#define kDeactivateTitle NSLocalizedString(@"Deactivate Device", @"Deactivate device list view title")
#define kDeactivateInformationalText NSLocalizedString(@"By deactivating your Hub account you are removing all information from this device.", @"Deactivate information disclaimer")
#define kDeactivateDialogTitle  NSLocalizedString(@"Deactivate your Hub account?", @"Deactivate dialog title")
#define kDeactivateDialogMessage NSLocalizedString(@"By deactivating your Hub account, we will remove the association with your phone number. Furthermore, you will be automatically removed from your conversations.", @"Deactivate dialog title")
#define kDeactivateDialogOKbuttonText NSLocalizedString(@"Deactivate", @"Deactivate dialog OK button")
#define kDeactivateSuccessfulDialogTitle NSLocalizedString(@"Deactivation Successful", @"Deactivation successful dialog title")
#define kDeactivateFailedDialogTitle NSLocalizedString(@"Deactivation Failed", @"Deactivation successful dialog title")
#define kDeactivateDialogOkayButton NSLocalizedString(@"Okay", @"Deactivation okay")
#define kDeactivateSuccessfulDialogMessage NSLocalizedString (@"You have been deactivated from Hub", @"Deactivation success dialog msg")
#define kDeactivateFailedDialogMessage NSLocalizedString (@"Hub Deactivation Failed", @"Deactivation failed dialog msg")



// Token view label
#define kTokenViewDefaultTitle NSLocalizedString(@"To:", @"To field label")

// Conversation Compose
#define kConversationComposeTitle NSLocalizedString(@"New Conversation", @"Title for Conversation Compose view controller")
#define kTextViewPlaceHolderText NSLocalizedString(@"Type a message...", @"Placeholder text for message in conversation compose view")

#define kEmailAddressType @"email"
#define kMMCAddressType @"mmc"
#define kSMSAddressType @"sms"

// Error keys
#define kInvalidAddressTypeKey  @"InvalidAddressType"
#define kInvalidAddressHandleKey  @"InvalidAddressHandle"

// Error domains
#define kAddressCreationError @"AddressCreationError"

// List view titles
#define kConversationsListTitle NSLocalizedString(@"Conversations", @"Conversations list view title")
#define kContactsListTitle NSLocalizedString(@"Contacts", @"Contacts list view title")
#define kSettingsListTitle NSLocalizedString(@"Settings", @"Settings list view title")
#define kUserProfileViewTitle NSLocalizedString(@"Profile", @"Profile view title")
#define kUserEditProfileViewTitle NSLocalizedString(@"Edit Profile", @"Edit profile view title")

// Contact Picker
#define kContactPickerTitle NSLocalizedString(@"Select Contacts", @"Contact Picker screen title")
#define kContactPickerMaxParticipantsAlertTitle NSLocalizedString(@"%u Participants Maximum", @"title of alert shown when user attempts to add more than the maximum number of participants allowed")
#define kContactPickerMaxParticipantsAlert NSLocalizedString(@"You have reached the %u participant maximum for a conversation.", @"alert shown when user attempts to add more than the maximum number of participants allowed")

// Contact info view title
#define kContactViewTitle NSLocalizedString(@"Contact Info", @"Title for contact info screen")

// User profile view controller
#define kNavigationItemText NSLocalizedString(@"Welcome to Hub", @"FTU Navigation Title")
#define kChoosePhotoSourceText NSLocalizedString(@"Please choose photo source", @"Choose Photo Source")
#define kCameraText NSLocalizedString(@"Take a Photo", @"Take a Photo text")
#define kPhotoLibraryText NSLocalizedString(@"Choose from Library", @"Choose from Library text")
#define kCancelText NSLocalizedString(@"Cancel", @"Cancel")
#define kFTUHeaderConfirmation NSLocalizedString(@"Hi there! Is your information correct?", @"FTU Header Confirmation")
#define kProfileImageUpdateErrorMessage NSLocalizedString(@"Unable to update your image. You can try again later from the Settings tab", @"Profile Image Update Error")
#define kProfileInfoUpdateErrorMessage NSLocalizedString(@"Unable to update your profile information. You can try again later from the Settings tab", @"Profile Info Update Error")
#define kUpdatingText NSLocalizedString(@"Updating", @"Updating")
#define kSendingSMSText NSLocalizedString(@"Sending SMS", @"Sending SMS")
#define kCompleteText NSLocalizedString(@"Complete", @"Complete")

#define kAddedParticipantSystemMessage NSLocalizedString(@"%@ added %@", @"System message for added participants")
#define kRemovedParticipantSystemMessage NSLocalizedString(@"%@ removed %@", @"System message for removed participants")
#define kAddRemoveParticipantConjunction NSLocalizedString(@" and removed %@", @"Conjunction for combining add and remove messages")
#define kLeftConversationSystemMessage NSLocalizedString(@"%@ left the conversation", @"System message for left conversation")
#define kConversationDeletedSystemMessage NSLocalizedString(@"Conversation has been deleted", @"Conversation deleted system message")
#define kConversationMigrateSystemMessage NSLocalizedString(@"%@ downloaded altoids", @"User migrated to altoids client system message")

#define kUnknownSystemMessage NSLocalizedString(@"Unknown system message", @"Unknown system message")

#define kPendingStatusMessage NSLocalizedString(@"SENDING...", @"Pending message or conversation")

#define kUnableToCreateConvoTitle NSLocalizedString(@"Unable to Create Conversation", @"Unable to Create Conversation Alert Title")
#define kUnableToCreateConvoMessage NSLocalizedString(@"Could not create conversation at this time. Please try again.", @"Could not create conversation alert message")

//
// YAConversationErrorDomain error messages
//
#define YAConversationErrorFailedToFetchConversationFromLocalStorage NSLocalizedString(@"Failed to retrieve conversation.", @"Failed to retrieve conversation error message")
#define YAConversationErrorFailedToFetchConversationsFromLocalStorage NSLocalizedString(@"Failed to retrieve conversations.", @"Failed to retrieve conversations error message")
#define YAConversationErrorFailedToRetrieveConversationFromServer NSLocalizedString(@"Failed to retrieve conversation.", @"Failed to retrieve conversation error message")
#define YAConversationErrorFailedToRetrieveConversationsFromServer NSLocalizedString(@"Failed to retrieve conversations.", @"Failed to retrieve conversations error message")
#define YAConversationErrorFailedToCreateConversationLocally NSLocalizedString(@"Failed to create conversation.", @"Failed to create conversation error message")
#define YAConversationErrorFailedToCreateConversationRemotely NSLocalizedString(@"Failed to create conversation.", @"Failed to create conversation error message")

#define YAConversationErrorFailedToEditConversationRemotely NSLocalizedString(@"Failed to update conversation.", @"Failed to update conversation error message")
#define YAConversationErrorFailedToSaveConversationLocally NSLocalizedString(@"Failed to save conversation.", @"Failed to save conversation error message")
#define YAConversationErrorFailedToSaveConversationsLocally NSLocalizedString(@"Failed to save conversations.", @"Failed to save conversations error message")
#define YAConversationErrorFailedToAddMessageToConversation NSLocalizedString(@"Failed to add message to conversation.", @"Failed to add message to conversation error message")
#define YAConversationErrorFailedToDeleteAllConversation NSLocalizedString(@"Failed to delete conversations.", @"Failed to delete conversations error message")
#define YAConversationErrorFailedToDeleteConversation NSLocalizedString(@"Failed to delete conversation.", @"Failed to delete conversation error message")
#define YAConversationErrorFailedToReplyToConversation NSLocalizedString(@"Failed to reply to conversation.", @"Failed to reply to conversation error message")
#define YAConversationErrorFailedToLeaveConversation NSLocalizedString(@"Failed to leave conversation.", @"Failed to leave conversation error message")
#define YAConversationErrorFailedToAddParticipantToConversation NSLocalizedString(@"Failed to add participant to conversation.", @"Failed to add participant to conversation error message")
#define YAConversationErrorFailedToAddParticipantsToConversation NSLocalizedString(@"Failed to add participants to conversation.", @"Failed to add participants to conversation error message")
#define YAConversationErrorFailedToUpdateParticipantsInConversation NSLocalizedString(@"Failed to update participants in conversation.", @"Failed to update participants in conversation error message")

//
// YAMessageErrorDomain error messages
//
#define YAMessageErrorFailedToFetchMessagesFromLocalStorage NSLocalizedString(@"Failed to retrieve messages.", @"Failed to retrieve messages error message")
#define YAMessageErrorFailedToRetrieveMessageFromServer NSLocalizedString(@"Failed to retrieve message.", @"Failed to retrieve message error message")
#define YAMessageErrorFailedToRetrieveMessagesFromServer NSLocalizedString(@"Failed to retrieve messages.", @"Failed to retrieve messages error message")
#define YAMessageErrorFailedToCreateMessageLocally NSLocalizedString(@"Failed to create message.", @"Failed to create message error message")
#define YAMessageErrorFailedToDeleteAllMessagesInConversation NSLocalizedString(@"Failed to delete messages.", @"Failed to delete messages error message")
#define YAMessageErrorFailedToSaveMessageLocally NSLocalizedString(@"Failed to save messsage.", @"Failed to save message error message")

//
// YAParticipantErrorDomain error messages
//
#define YAParticipantErrorFailedToCreateParticipantLocally NSLocalizedString(@"Failed to create participant.", @"Failed to create participant error message")
#define YAParticipantErrorMaximumNumberOfParticipantsExceeded NSLocalizedString(@"Maximum number of participants exceeded.", @"Maximum number of participants exceeded error message")
#define YAParticipantErrorFailedToAddParticipantAsContact NSLocalizedString(@"Failed to add participant as a contact.", @"Failed to add participant as a contact error message")
#define YAParticipantErrorFailedToRetrieveImageForParticipant NSLocalizedString(@"Failed to retrieve image for participant.", @"Failed to retrieve image for participant error message")
#define YAParticipantErrorFailedToRemoveParticipantFromConversation NSLocalizedString(@"Failed to remove participant from conversation.", @"Failed to remove participant from conversation error message")
#define YAParticipantErrorFailedToRemotelyValidateParticipant NSLocalizedString(@"Invalid participant.", @"Invalid participant error message")
#define YAParticipantErrorFailedToSaveParticipantLocally NSLocalizedString(@"Failed to save participant.", @"Failed to save participant error message")
#define YAParticipantErrorFailedToFindUserInParticipantList NSLocalizedString(@"Failed to find participant.", @"Failed to find participant error message")
//
// YAAddressErrorDomain error messages
//
#define YAAddressErrorFailedToCreateAddressLocally NSLocalizedString(@"Failed to create address.", @"Failed to create address error message")
#define YAAddressErrorFailedToFormatAddress NSLocalizedString(@"Failed to format address.", @"Failed to format address error message")
#define YAAddressErrorFailedToNormalizeAddress NSLocalizedString(@"Failed to normalize address.", @"Failed to normalize address error message")
#define YAAddressErrorUnknownAddressType NSLocalizedString(@"Unsupported address detected.", @"Unsupported address error message")

//
// YAProfileErrorDomain error messages
//
#define YAProfileErrorFailedToCreateUserProfileLocally NSLocalizedString(@"Failed to create user profile.", @"Failed to create user profile error message")
#define YAProfileErrorFailedToFetchUserProfileFromLocalStorage NSLocalizedString(@"Failed to retrieve user profile.", @"Failed to retrieve user profile error message")
#define YAProfileErrorFailedToRetrieveUserProfile NSLocalizedString(@"Failed to retrieve user profile.", @"Failed to retrieve user profile error message")
#define YAProfileErrorFailedToSaveUserProfile NSLocalizedString(@"Failed to save user profile.", @"Failed to save user profile error message")
#define YAProfileErrorUnknownError NSLocalizedString(@"Unable to save or retrieve user profile.", @"Failed to save or retrieve user profile error message")

//
// YARegistrationErrorDomain error messages
//
#define YARegistrationErrorFailedToFetchRegistrationInformationFromLocalStorage NSLocalizedString(@"Failed to retrieve registration information", @"Failed to retrieve registration information error message")
#define YARegistrationErrorFailedToSaveRegistrationInformationLocally NSLocalizedString(@"Failed to save registration information.", @"Failed to save registration information error message")
#define YARegistrationErrorFailedToRetrieveToken NSLocalizedString(@"Failed to retrieve registration token.", @"Failed to retrieve registration token error message")
#define YARegistrationErrorFailedToVerifyToken NSLocalizedString(@"Failed to verify registration token.", @"Failed to verify registration token error message")
#define YARegistrationErrorFailedToRenewRegistration NSLocalizedString(@"Failed to renew registration token.", @"Failed to renew registration token error message")
#define YARegistrationErrorFailedToVerfiyCarrier NSLocalizedString(@"Invalid carrier.", @"Invalid carrier error message")
#define YARegistrationErrorUnableToSendSMS NSLocalizedString(@"Failed to send SMS.", @"Failed to send SMS error message")
#define YARegistrationErrorFailedToSaveRegistrationInformation NSLocalizedString(@"Failed to save registration information.", @"Failed to save registration information error message")
#define YARegistrationErrorGeneralError NSLocalizedString(@"Failed to register device.", @"Failed to register device information error message")

//
// YASettingsErrorDomain error messages
//
#define YASettingsErrorFailedToFetchSettingsFromLocalStorage NSLocalizedString(@"Failed to retrieve settings.", @"Failed to retrieve settings error message")
#define YASettingsErrorFailedToSaveSettingsLocally NSLocalizedString(@"Failed to save settings.", @"Failed to save settings error message")
#define YASettingsErrorFailedToReportAProblem NSLocalizedString(@"Unable to report problem, please try again.", @"Failed to report a problem error message")
#define YASettingsErrorFailedToDetactivateApplication NSLocalizedString(@"Failed to detactivate application.", @"Failed to deactivate application error message")

//
// YAValidationErrorDomain error messages
//
#define YAValidationErrorConversationIsNil NSLocalizedString(@"Invalid nil conversation.", @"Nil conversation error message")
#define YAValidationErrorConversationIDIsNil NSLocalizedString(@"Invalid conversation ID.", @"Invalid conversation ID error message")
#define YAValidationErrorConversationSenderIsNil NSLocalizedString(@"Conversation sender is nil.", @"Conversation sender is nil error message")
#define YAValidationErrorConversationHasNoMessages NSLocalizedString(@"Conversation has no messages.", @"Conversation has no messages error message")
#define YAValidationErrorConversationHasNoParticipants NSLocalizedString(@"Conversation has no participants.", @"Conversation has no participants error message")
#define YAValidationErrorMessageIsNil NSLocalizedString(@"Invalid nil message.", @"Nil message error message")
#define YAValidationErrorMessageSenderIsNil NSLocalizedString(@"Message sender is nil.", @"Nil message sender error message")
#define YAValidationErrorParticipantIsNil NSLocalizedString(@"Participant is nil.", @"Nil participant error message")
#define YAValidationErrorAddressIsNil NSLocalizedString(@"Address is nil.", @"Nil address error message")
#define YAValidationErrorInvalidAddressType NSLocalizedString(@"Address type is invalid.", @"Address type is invalid error message")
#define YAValidationErrorInvalidAddressHandle NSLocalizedString(@"Address handle is invalid.", @"Address handle is invalid error message")

//
// YACommandErrorDomain error messages
//
#define YACommandErrorNilURLRequest NSLocalizedString(@"Invalid nil URLRequest.", @"Nil urlRequest error message")
#define YACommandErrorNilParsedJSONResponse NSLocalizedString(@"Invalid nil parsed JSON response.", @"Nil parsed JSON reponse error message")
#define YACommandErrorException NSLocalizedString(@"An unhandled exception occurred.", @"Unhandled exception occurred")

//
// Contact/Profile strings
//

#define kMobileNumberLabelText NSLocalizedString(@"Mobile", @"Mobile number label text")
#define kProfileInformationWillBeMadePublicMessage NSLocalizedString(@"This information will be shared with people in conversations.", @"Profile information will be made public message")
#define kFirstNamePlaceholderText NSLocalizedString(@"First name", @"First name placeholder text")
#define kLastNamePlaceholderText NSLocalizedString(@"Last name", @"Last name placeholder text")
#define kContactsListAlphabeticIndexes NSLocalizedString(@"A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,#", @"Alphabet separated by kContactsListAlphabeticIndexesSeparator, for scroll index of contacts list (as in native Contacts app); use kContactsListAlphabeticIndexesNumberSection for non-alphabetical section")
#define kContactsListAlphabeticIndexesDelimiter NSLocalizedString(@",", @"Character used to delimit sections within kContactsListAlphabeticIndexes")
#define kContactsListAlphabeticIndexesNumberSection NSLocalizedString(@"#", @"Character used for section title of non-alphabetic entries in kContactsListAlphabeticIndexes")

//
// YAPullToRefreshView message label strings
//
#define kRefreshPullUpToUpdateMessage NSLocalizedString(@"Pull up to update...", @"Refresh pull up to update message")
#define kRefreshPullDownToUpdateMessage NSLocalizedString(@"Pull down to update...", @"Refresh pull down to update message")
#define kRefreshReleaseToUpdateMessage NSLocalizedString(@"Release to update...", @"Refresh header release to update message")
#define kRefreshUpdatingMessage NSLocalizedString(@"Updating...", @"Refresh header updating message")
#define kLastUpdatedLabelStringPrefix NSLocalizedString(@"Last updated:", @"Last updated label string prefix")
#define kRefreshNetworkErrorMessage NSLocalizedString(@"Could not update. Please check your network connection.", @"Refresh network error message")
#define kRefreshErrorMessage NSLocalizedString(@"Could not update.", @"Refresh error message")

//
// Fail to Send UIActionSheet button label strings
//
#define kActionSheetDeleteButtonLabel NSLocalizedString(@"Delete", @"Action Sheet Delete Button Label")
#define kActionSheetResendButtonLabel NSLocalizedString(@"Resend", @"Action Sheet Resend Button Label")
#define kActionSheetCancelButtonLabel NSLocalizedString(@"Cancel", @"Action Sheet Cancel Button Label")

//
// YADateFormatter time quantities
//

#define kNowTimeQuantity NSLocalizedString(@"JUST NOW", @"Time quantity for right now");
#define kOneMinuteTimeQuantity NSLocalizedString(@"MIN", @"Time quantity for one minute");
#define kTwoMinuteTimeQuantity NSLocalizedString(@"MINS", @"Time quantity for two minutes");
#define kFewMinutesTimeQuantity NSLocalizedString(@"MINS", @"Time quantity for a few minutes");

#define kOneHourTimeQuantity NSLocalizedString(@"HOUR", @"Time quantity for one hour");
#define kTwoHourTimeQuantity NSLocalizedString(@"HOURS", @"Time quantity for two hours");
#define kFewHoursTimeQuantity NSLocalizedString(@"HOURS", @"Time quantity for a few hours");

#define kOneYearTimeQuantity NSLocalizedString(@"YEAR", @"Time quantity for one year");

//
//YASessionLogger filtered string replacement
//
#define kFilteredStringReplacement NSLocalizedString(@"-Hidden for protecting privacy-", @"filtered string replacement, may not need to be localized.")

#endif
