//
//  YAMMCErrorHandler.h
//  altoids
//
//  Created by Jon Herron on 11/28/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ErrorHandler.h"
#import "ManagedObjectContextFactory.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAMMCErrorHandler : NSObject <ErrorHandler>

#pragma mark @property declarations
@property (strong, nonatomic, readonly) NSManagedObjectContext *managedObjectContext;

#pragma mark  Class methods

#pragma mark Instance methods

- (id)initWithManagedObjectContextFactory:(id<ManagedObjectContextFactory>)theManagedObjectContextFactory;

- (NSManagedObject *)managedObjectWithID:(NSManagedObjectID *)theManagedObjectID;

- (void)handleMgrError:(NSError *)theError;
- (void)handleMgrErrorInternalServerError:(NSError *)theError;
- (void)handleMgrErrorInvalidCrumb:(NSError *)theError;
- (void)handleMgrErrorInvalidCredentials:(NSError *)theError;
- (void)handleMgrErrorInvalidContentType:(NSError *)theError;
- (void)handleMgrErrorInvalidArguments:(NSError *)theError;
- (void)handleMgrErrorParticipantAddressNotSupported:(NSError *)theError;
- (void)handleMgrErrorParticipantAddFailed:(NSError *)theError;
- (void)handleMgrErrorConversationDoesNotExist:(NSError *)theError;
- (void)handleMgrErrorConversationAccessDenied:(NSError *)theError;
- (void)handleMgrErrorParticipantDoesNotExist:(NSError *)theError;
- (void)handleMgrErrorParticipantDeleteFailed:(NSError *)theError;
- (void)handleMgrErrorMaxParticipantsExceeded:(NSError *)theError;
- (void)handleMgrErrorDeviceRegistrationRequired:(NSError *)theError;
- (void)handleMgrErrorParticipantExists:(NSError *)theError;

- (void)handleMwsError:(NSError *)theError;
- (void)handleMwsErrorConversationNotFound:(NSError *)theError;
- (void)handleMwsErrorConversationOffsetNotFound:(NSError *)theError;
- (void)handleMwsErrorMissingOrInactiveMailbox:(NSError *)theError;
- (void)handleMwsErrorMessageOffsetNotFound:(NSError *)theError;
- (void)handleMwsErrorInvalidCrumb:(NSError *)theError;
- (void)handleMwsErrorInvalidCredentials:(NSError *)theError;
- (void)handleMwsErrorInvalidArguments:(NSError *)theError;
- (void)handleMwsErrorInvalidContentType:(NSError *)theError;
- (void)handleMwsErrorMessageNotFound:(NSError *)theError;
- (void)handleMwsErrorInternalServerError:(NSError *)theError;

- (BOOL)isMgrError:(NSError *)theError;
- (BOOL)isMwsError:(NSError *)theError;

@end
