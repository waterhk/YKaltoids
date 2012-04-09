//
//  YAMMCErrorHandler.m
//  altoids
//
//  Created by Jon Herron on 11/28/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAMMCErrorHandler.h"

// Private class extension
@interface YAMMCErrorHandler ()

// @property definitions
@property (strong, nonatomic) id<ManagedObjectContextFactory> managedObjectContextFactory;

// methods

@end

@implementation YAMMCErrorHandler

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize managedObjectContext = managedObjectContext_;
@synthesize managedObjectContextFactory = managedObjectContextFactory_;

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

- (id)initWithManagedObjectContextFactory:(id<ManagedObjectContextFactory>)theManagedObjectContextFactory
{
  self = [super init];
    
  if (self) 
  {
      managedObjectContextFactory_ = theManagedObjectContextFactory;
  }
  
  return self;
}

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark ErrorHandler delegate methods

- (void)handleError:(NSError *)theError
{
    if ([self isMgrError:theError]) 
    {
        [self handleMgrError:theError];
    }
    else if ([self isMwsError:theError])
    {
        [self handleMwsError:theError];
    }
    else
    {
        // unknown error provided, need to handle this
    }
}

- (NSManagedObjectContext *)managedObjectContext
{
    if (!managedObjectContext_) 
    {
        managedObjectContext_ = [[self managedObjectContextFactory] create];
    }
    
    return managedObjectContext_;
}

- (NSManagedObject *)managedObjectWithID:(NSManagedObjectID *)theManagedObjectID
{
    return [[self managedObjectContext] objectWithID:theManagedObjectID];
}

// Public methods
#pragma mark -
#pragma mark Public methods

// Protected methods
#pragma mark -
#pragma mark Protected methods

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods
#pragma mark -
#pragma mark YAMMCErrorHandler ()

- (void)handleMgrError:(NSError *)theError
{
    NSInteger errorCode = [theError code];
    
    switch (errorCode) 
    {
        case YAMMCMgrErrorCodeInvalidCrumb:
            [self handleMgrErrorInvalidCrumb:theError];
            break;
        case YAMMCMgrErrorCodeInvalidCredentials:
            [self handleMgrErrorInvalidCredentials:theError];                                                                                                                                                                                                                                                                      
            break;
        case YAMMCMgrErrorCodeInvalidContentType:
            [self handleMgrErrorInvalidContentType:theError];                                                                                                                                                                                                                                                                      
            break;
        case YAMMCMgrErrorCodeInvalidArguments:
            [self handleMgrErrorInvalidArguments:theError];                                                                                                                                                                                                                                                                        
            break;
        case YAMMCMgrErrorCodeParticipantAddressNotSupported:
            [self handleMgrErrorParticipantAddressNotSupported:theError];                                                                                                                                                                                                                                                          
            break;
        case YAMMCMgrErrorCodeParticipantAddFailed:
            [self handleMgrErrorParticipantAddFailed:theError];                                                                                                                                                                                                                                                                    
            break;
        case YAMMCMgrErrorCodeConversationDoesNotExist:
            [self handleMgrErrorConversationDoesNotExist:theError];                                                                                                                                                                                                                                                                
            break;
        case YAMMCMgrErrorCodeConversationAccessDenied:
            [self handleMgrErrorConversationAccessDenied:theError];                                                                                                                                                                                                                                                                
            break;
        case YAMMCMgrErrorCodeParticipantDoesNotExist:
            [self handleMgrErrorParticipantDoesNotExist:theError];                                                                                                                                                                                                                                                                 
            break;
        case YAMMCMgrErrorCodeParticipantDeleteFailed:
            [self handleMgrErrorParticipantDeleteFailed:theError];                                                                                                                                                                                                                                                                 
            break;
        case YAMMCMgrErrorCodeMaxParticipantsExceeded:
            [self handleMgrErrorMaxParticipantsExceeded:theError];                                                                                                                                                                                                                                                                 
            break;
        case YAMMCMgrErrorCodeDeviceRegistrationRequired:
            [self handleMgrErrorDeviceRegistrationRequired:theError];                                                                                                                                                                                                                                                            
            break;
        case YAMMCMgrErrorCodeParticipantExists:
            [self handleMgrErrorParticipantExists:theError];                                                                                                                                                                                                                                                                       
            break;
        default:
            [self handleMgrErrorInternalServerError:theError];
            break;
    }
    
}

- (void)handleMgrErrorInternalServerError:(NSError *)theError
{
    
}

- (void)handleMgrErrorInvalidCrumb:(NSError *)theError
{
    
}

- (void)handleMgrErrorInvalidCredentials:(NSError *)theError
{
    
}

- (void)handleMgrErrorInvalidContentType:(NSError *)theError
{
    
}

- (void)handleMgrErrorInvalidArguments:(NSError *)theError
{
    
}

- (void)handleMgrErrorParticipantAddressNotSupported:(NSError *)theError
{
    
}

- (void)handleMgrErrorParticipantAddFailed:(NSError *)theError
{
    
}

- (void)handleMgrErrorConversationDoesNotExist:(NSError *)theError
{
    
}

- (void)handleMgrErrorConversationAccessDenied:(NSError *)theError
{
    
}

- (void)handleMgrErrorParticipantDoesNotExist:(NSError *)theError
{
    
}

- (void)handleMgrErrorParticipantDeleteFailed:(NSError *)theError
{
    
}

- (void)handleMgrErrorMaxParticipantsExceeded:(NSError *)theError
{
    
}

- (void)handleMgrErrorDeviceRegistrationRequired:(NSError *)theError
{
    
}

- (void)handleMgrErrorParticipantExists:(NSError *)theError
{
    
}

- (void)handleMwsError:(NSError *)theError
{
    NSInteger errorCode = [theError code];
    
    switch (errorCode) 
    {
        case YAMMCMwsErrorCodeConversationNotFound:
            [self handleMwsErrorConversationNotFound:theError];
            break;
        case YAMMCMwsErrorCodeConversationOffsetNotFound:
            [self handleMwsErrorConversationOffsetNotFound:theError];
            break;
        case YAMMCMwsErrorCodeMissingOrInactiveMailbox:
            [self handleMwsErrorMissingOrInactiveMailbox:theError];
            break;
        case YAMMCMwsErrorCodeMessageOffsetNotFound:
            [self handleMwsErrorMessageOffsetNotFound:theError];
            break;
        case YAMMCMwsErrorCodeInvalidCrumb:
            [self handleMwsErrorInvalidCrumb:theError];
            break;
        case YAMMCMwsErrorCodeInvalidCredentials:
            [self handleMwsErrorInvalidCredentials:theError];
            break;
        case YAMMCMwsErrorCodeInvalidArguments:
            [self handleMwsErrorInvalidArguments:theError];
            break;
        case YAMMCMwsErrorCodeInvalidContentType:
            [self handleMwsErrorInvalidContentType:theError];
            break;
        case YAMMCMwsErrorCodeMessageNotFound:
            [self handleMwsErrorMessageNotFound:theError];
            break;
        default:
            [self handleMwsErrorInternalServerError:theError];
            break;
    }
}

- (void)handleMwsErrorConversationNotFound:(NSError *)theError
{
    
}

- (void)handleMwsErrorConversationOffsetNotFound:(NSError *)theError
{
    
}

- (void)handleMwsErrorMissingOrInactiveMailbox:(NSError *)theError
{
    
}

- (void)handleMwsErrorMessageOffsetNotFound:(NSError *)theError
{
    
}

- (void)handleMwsErrorInvalidCrumb:(NSError *)theError
{
    
}

- (void)handleMwsErrorInvalidCredentials:(NSError *)theError
{
    
}

- (void)handleMwsErrorInvalidArguments:(NSError *)theError
{
    
}

- (void)handleMwsErrorInvalidContentType:(NSError *)theError
{
    
}

- (void)handleMwsErrorMessageNotFound:(NSError *)theError
{
    
}

- (void)handleMwsErrorInternalServerError:(NSError *)theError
{
    
}

- (BOOL)isMgrError:(NSError *)theError
{
    return [[theError domain] isEqualToString:YAMMCErrorNamespaceMgr];
}

- (BOOL)isMwsError:(NSError *)theError
{
    return [[theError domain] isEqualToString:YAMMCErrorNamespaceMws];
}

@end
