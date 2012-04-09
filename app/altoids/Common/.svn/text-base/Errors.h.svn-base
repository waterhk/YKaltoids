//
//  Errors.h
//  altoids
//
//  Created by Jon Herron on 9/8/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef ALTOIDS_ERRORS_H
#define ALTOIDS_ERRORS_H

#define YAErrorDomain(domain) @"com.yahoo.hub." #domain "ErrorDomain"

static NSString *const YAConversationErrorDomain = YAErrorDomain(Conversation);
static NSString *const YAMessageErrorDomain = YAErrorDomain(Message);
static NSString *const YAParticipantErrorDomain = YAErrorDomain(Participant);
static NSString *const YAAddressErrorDomain = YAErrorDomain(Address);
static NSString *const YAProfileErrorDomain = YAErrorDomain(Profile);
static NSString *const YASettingsErrorDomain = YAErrorDomain(Settings);
static NSString *const YARegistrationErrorDomain = YAErrorDomain(Registration);
static NSString *const YAValidationErrorDomain = YAErrorDomain(Validation);
static NSString *const YACommandErrorDomain = YAErrorDomain(Command);

typedef enum 
{
    YAConversationErrorCodeFailedToFetchConversationFromLocalStorage,
    YAConversationErrorCodeFailedToFetchConversationsFromLocalStorage,
    YAConversationErrorCodeFailedToRetrieveConversationFromServer,
    YAConversationErrorCodeFailedToRetrieveConversationsFromServer,
    YAConversationErrorCodeFailedToCreateConversationLocally,
    YAConversationErrorCodeFailedToCreateConversationRemotely,
    YAConversationErrorCodeFailedToEditConversationRemotely,
    YAConversationErrorCodeFailedToSaveConversationLocally, 
    YAConversationErrorCodeFailedToSaveConversationsLocally,
    YAConversationErrorCodeFailedToAddMessageToConversation,
    YAConversationErrorCodeFailedToDeleteAllConversation,
    YAConversationErrorCodeFailedToDeleteConversation,
    YAConversationErrorCodeFailedToReplyToConversation,
    YAConversationErrorCodeFailedToLeaveConversation,
    YAConversationErrorCodeFailedToAddParticipantToConversation,
    YAConversationErrorCodeFailedToAddParticipantsToConversation,
    YAConversationErrorCodeFailedToUpdateParticipantsInConversation,
} YAConversationErrorCodes;

typedef enum 
{
    YAMessageErrorCodeFailedToFetchMessagesFromLocalStorage,
    YAMessageErrorCodeFailedToRetrieveMessageFromServer,
    YAMessageErrorCodeFailedToRetrieveMessagesFromServer,
    YAMessageErrorCodeFailedToCreateMessageLocally,
    YAMessageErrorCodeFailedToDeleteAllMessagesInConversation,
    YAMessageErrorCodeFailedToSaveMessageLocally,
} YAMessageErrorCodes;

typedef enum 
{
    YAParticipantErrorCodeFailedToCreateParticipantLocally,
    YAParticipantErrorCodeMaximumNumberOfParticipantsExceeded,
    YAParticipantErrorCodeFailedToAddParticipantAsContact,
    YAParticipantErrorCodeFailedToRetrieveImageForParticipant,
    YAParticipantErrorCodeFailedToRemoveParticipantFromConversation,
    YAParticipantErrorCodeFailedToRemotelyValidateParticipant,
    YAParticipantErrorCodeFailedToSaveParticipantLocally,
    YAParticipantErrorCodeFailedToFindUserInParticipantList
} YAParticipantErrorCodes;

typedef enum 
{
    YAAddressErrorCodeFailedToCreateAddressLocally,
    YAAddressErrorCodeFailedToFormatAddress,
    YAAddressErrorCodeFailedToNormalizeAddress,
    YAAddressErrorCodeUnknownAddressType,
} YAAddressErrorCodes;

typedef enum
{
    YAProfileErrorCodeFailedToCreateUserProfileLocally,
    YAProfileErrorCodeFailedToFetchUserProfileFromLocalStorage,
    YAProfileErrorCodeFailedToRetrieveUserProfile,
    YAProfileErrorCodeFailedToSaveUserProfile,
    YAProfileErrorCodeInvalidURLRequest,
    YAProfileErrorCodeUnknownError,
} YAProfileErrorCodes;

typedef enum 
{
    YARegistrationErrorCodeFailedToFetchRegistrationInformationFromLocalStorage,
    YARegistrationErrorCodeFailedToSaveRegistrationInformationLocally,
    YARegistrationErrorCodeFailedToRetrieveToken,
    YARegistrationErrorCodeFailedToVerifyToken,
    YARegistrationErrorCodeFailedToRenewRegistration,
    YARegistrationErrorCodeFailedToVerfiyCarrier,
    YARegistrationErrorCodeUnableToSendSMS,
    YARegistrationErrorCodeFailedToSaveRegistrationInformation,
    YARegistrationErrorCodeGeneralError
} YARegistrationErrorCodes;

typedef enum
{
    YASettingsErrorCodeFailedToFetchSettingsFromLocalStorage,
    YASettingsErrorCodeFailedToSaveSettingsLocally,
    YASettingsErrorCodeFailedToReportAProblem,
    YASettingsErrorCodeFailedToDetactivateApplication,
} YASettingsErrorCodes;

typedef enum 
{
    YAValidationErrorCodeConversationIsNil,
    YAValidationErrorCodeConversationIDIsNil,
    YAValidationErrorCodeConversationSenderIsNil,
    YAValidationErrorCodeConversationHasNoMessages,
    YAValidationErrorCodeConversationHasNoParticipants,
    YAValidationErrorCodeMessageIsNil,
    YAValidationErrorCodeMessageSenderIsNil,
    YAValidationErrorCodeParticipantIsNil,
    YAValidationErrorCodeAddressIsNil,
    YAValidationErrorCodeInvalidAddressType,
    YAValidationErrorCodeInvalidAddressHandle,
} YAValidationErrorCodes;

typedef enum
{
    YACommandErrorCodeNilURLRequest,
    YACommandErrorCodeNilParsedJSONResponse,
    YACommandErrorCodeException,
} YACommandErrorCodes;

// MMC Error Namespace/Codes

static NSString *const YAMMCErrorNamespaceMgr = @"mgr";
static NSString *const YAMMCErrorNamespaceMws = @"mws";

typedef enum 
{
    YAMMCMgrErrorCodeInternalServerError = 1,
    YAMMCMgrErrorCodeInvalidCrumb,
    YAMMCMgrErrorCodeInvalidCredentials,
    YAMMCMgrErrorCodeInvalidContentType,
    YAMMCMgrErrorCodeInvalidArguments,
    YAMMCMgrErrorCodeParticipantAddressNotSupported,
    YAMMCMgrErrorCodeParticipantAddFailed,
    YAMMCMgrErrorCodeConversationDoesNotExist,
    YAMMCMgrErrorCodeConversationAccessDenied,
    YAMMCMgrErrorCodeParticipantDoesNotExist,
    YAMMCMgrErrorCodeParticipantDeleteFailed,
    YAMMCMgrErrorCodeMaxParticipantsExceeded,
    YAMMCMgrErrorCodeDeviceRegistrationRequired,
    YAMMCMgrErrorCodeParticipantExists,
} YAMMCMgrErrorCodes;

typedef enum
{
    YAMMCMwsErrorCodeConversationNotFound = 1,
    YAMMCMwsErrorCodeConversationOffsetNotFound,
    YAMMCMwsErrorCodeMissingOrInactiveMailbox,
    YAMMCMwsErrorCodeMessageOffsetNotFound,
    YAMMCMwsErrorCodeInvalidCrumb = 400,
    YAMMCMwsErrorCodeInvalidCredentials,
    YAMMCMwsErrorCodeInvalidArguments,
    YAMMCMwsErrorCodeInvalidContentType,
    YAMMCMwsErrorCodeMessageNotFound,
} YAMMCMwsErrorCodes;

// todo: replace with enum above during error handling overhaul
typedef enum 
{
    YAConversationValidationNilConversationErrorCode = 1001,
    YAConversationValidationTooFewMessagesErrorCode = 1002,
    YAConversationValidationTooFewParticipantsErrorCode = 1003,
    YAConversationValidationNilContextErrorCode = 1004,
    YAConversationValidationNilSenderErrorCode = 1005,
    YAConversationValidationInvalidGapPlaceholderConversationErrorCode = 1006,
    YAConversationValidationInvalidConversationID = 1007,
} YAConversationValidationErrors;

// todo: move these out of this file
typedef enum
{
    //see http://en.wikipedia.org/wiki/List_of_HTTP_status_codes to add more codes
    YAHTTPStatusOk = 200,
    //client error codes
    YAHTTPStatusBadRequest = 400,
    YAHTTPStatusUnauthorized = 401,
    //server error codes
    YAHTTPStatusInternalServerError = 500,
    YAHTTPStatusNotImplemented = 501,
}YAHTTPStatusCode;


typedef enum
{
    YAMMCServerErrorServerInternal = 1,
    YAMMCServerErrorCrumbNotValid = 2,
    YAMMCServerErrorCredentialsNotValid = 3,
    YAMMCServerErrorContentNotValidType = 4,
    YAMMCServerErrorArgumentsNotValid = 5,
    YAMMCServerErrorParticipantAddressNotSupported = 6,
    YAMMCServerErrorPaticipantAddFailed = 7,
    YAMMCServerErrorConversationDoesNotExist = 8,
    YAMMCServerErrorConversationPermissionDenied = 9,
    YAMMCServerErrorParticipantDoesNotExist = 10,
    YAMMCServerErrorParticipantDeleteFailed = 11,
    YAMMCServerErrorMaxParticipantsExceeded = 12,
    YAMMCServerErrorDeviceRegistrationRequired = 13,
    YAMMCServerErrorParticipantExists = 14,
    //This should always be the last one
    YAMMCServerErrorMax
}YAMMCServerError;
// todo: drop these after we overhaul error handling
#define kConversationValidationNilConversationErrorMsg @"Invalid nil conversation received."
#define kConversationValidationTooFewMessagesErrorMsg @"Must have at least one message when saving a conversation."
#define kConversationValidationTooFewParticipantsErrorMsg @"Must have at least one participant when saving a conversation."
#define kConversationValidationNilContextErrorMsg @"Invalid nil context for conversation"
#define kConversationValidationNilSenderErrorMsg @"Invalid nil sender for conversation"
#define kConversationValidationInvalidConversationID @"Invalid conversation ID"

#define kConversationValidationInvalidGapPlaceholderConversationErrorMsg @"Invalid gap placeholder conversation"

#endif
