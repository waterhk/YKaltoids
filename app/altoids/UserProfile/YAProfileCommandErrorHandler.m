//
//  YAProfileCommandErrorHandler.m
//  altoids
//
//  Created by Anand Biligiri on 12/21/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAProfileCommandErrorHandler.h"

// Private class extension
@interface YAProfileCommandErrorHandler ()

// @property definitions
@property (strong, nonatomic) id<ProfileErrorCreator> profileErrorCreator;
@property (strong, nonatomic) id<ErrorHandler> errorHandler;
// methods

@end

@implementation YAProfileCommandErrorHandler

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize profileErrorCreator = profileErrorCreator_;
@synthesize errorHandler = errorHandler_;

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

- (id)initWithErrorHandler:(id<ErrorHandler>)errorHandler profileErrorCreator:(id<ProfileErrorCreator>)profileErrorCreator
{
  self = [super init];
  if (self) {
      profileErrorCreator_ = profileErrorCreator;
      errorHandler_ = errorHandler;
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
#pragma mark CommandErrorHandler methods
//{"error":{"uri":"http://www.yahooapis.com/v1/errors/400","lang":"en-US","description":"Request has malformed syntax or bad query",
//    "detail":"=20004= Invalid image format:gif. Valid formats are jpg/png"}} 
- (BOOL)parsedJSONResponseHasError:(NSDictionary *)theParsedJSONResponse error:(NSError *__autoreleasing *)anError
{
    id error = [theParsedJSONResponse valueForKey:@"error"];
    
    if ([error respondsToSelector:@selector(objectForKey:)]) {
        YAProfileErrorCodes errorCode = YAProfileErrorCodeUnknownError;
        NSString *detail = [error objectForKey:@"detail"];
        if ([detail respondsToSelector:@selector(characterAtIndex:)]) {
            NSUInteger detailLength = [detail length];
            if ([detail characterAtIndex:0] == '=' && detailLength > 1) {
                NSUInteger index = 1;
                while (index < detailLength && [detail characterAtIndex:index] != '=') {
                    index++;
                }
                
                if (index != detailLength) {
                    errorCode = [[detail substringWithRange:NSMakeRange(1, index - 1)] intValue];
                }
            }
        }
        
        *anError = [[self profileErrorCreator] errorWithCode:errorCode];
        
        return YES;
    }
    
    return NO;
}

- (void)handleError:(NSError *)theError
{
    [[self errorHandler] handleError:theError];
}

- (BOOL)urlRequestHasError:(NSURLRequest *)theURLRequest error:(NSError *__autoreleasing *)anError
{
    if (theURLRequest)
        return NO;
    
    *anError = [[self profileErrorCreator] errorWithCode:YAProfileErrorCodeInvalidURLRequest];
    
    return YES;
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
#pragma mark YAProfileCommandErrorHandler ()

@end
