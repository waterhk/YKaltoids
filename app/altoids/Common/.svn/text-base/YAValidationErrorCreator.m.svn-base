//
//  YAValidationErrorCreator.m
//  altoids
//
//  Created by Jon Herron on 11/15/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAValidationErrorCreator.h"

// Private class extension
@interface YAValidationErrorCreator ()

// @property definitions
@property (strong, nonatomic) id<ErrorCreator> errorCreator;

// methods
- (NSString *)localizedDescriptionForErrorCode:(YAValidationErrorCodes)theErrorCode;

@end

@implementation YAValidationErrorCreator

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize errorCreator = errorCreator_;

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

- (id)initWithErrorCreator:(id<ErrorCreator>)theErrorCreator
{
    self = [super init];
    
  if (self) 
  {
      errorCreator_ = theErrorCreator;
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
#pragma mark ValidationErrorCreator delegate methods

- (NSError *)errorWithCode:(YAValidationErrorCodes)theErrorCode
{
    return [self errorWithCode:theErrorCode underlyingError:nil];
}

- (NSError *)errorWithCode:(YAValidationErrorCodes)theErrorCode underlyingError:(NSError *)theUnderlyingError
{
    NSString *localizedDescription = [self localizedDescriptionForErrorCode:theErrorCode];
    
    return [[self errorCreator] errorWithDomain:YAValidationErrorDomain code:theErrorCode localizedDescription:localizedDescription underlyingError:theUnderlyingError];
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
#pragma mark YAValidationErrorCreator ()

- (NSString *)localizedDescriptionForErrorCode:(YAValidationErrorCodes)theErrorCode
{
    switch (theErrorCode) 
    {
		case YAValidationErrorCodeConversationIsNil:
			return YAValidationErrorConversationIsNil;
		case YAValidationErrorCodeConversationIDIsNil:
			return YAValidationErrorConversationIDIsNil;
		case YAValidationErrorCodeConversationSenderIsNil:
			return YAValidationErrorConversationSenderIsNil;
		case YAValidationErrorCodeConversationHasNoMessages:
			return YAValidationErrorConversationHasNoMessages;
		case YAValidationErrorCodeConversationHasNoParticipants:
			return YAValidationErrorConversationHasNoParticipants;
		case YAValidationErrorCodeMessageIsNil:
			return YAValidationErrorMessageIsNil;
		case YAValidationErrorCodeMessageSenderIsNil:
			return YAValidationErrorMessageSenderIsNil;
		case YAValidationErrorCodeParticipantIsNil:
			return YAValidationErrorParticipantIsNil;
		case YAValidationErrorCodeAddressIsNil:
			return YAValidationErrorAddressIsNil;
		case YAValidationErrorCodeInvalidAddressType:
			return YAValidationErrorInvalidAddressType;
		case YAValidationErrorCodeInvalidAddressHandle:
			return YAValidationErrorInvalidAddressHandle;
        default:
            return nil;
    }
}

@end
