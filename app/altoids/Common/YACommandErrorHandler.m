//
//  YACommandErrorHandler.m
//  altoids
//
//  Created by Jon Herron on 11/23/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YACommandErrorHandler.h"

@interface YACommandErrorHandler ()

@property (strong, nonatomic) id<ErrorHandler> errorHandler;
@property (strong, nonatomic) id<CommandErrorCreator> commandErrorCreator;

@end

@implementation YACommandErrorHandler

@synthesize errorHandler = errorHandler_;
@synthesize commandErrorCreator = commandErrorCreator_;

- (id)initWithErrorHandler:(id<ErrorHandler>)theErrorHandler 
       commandErrorCreator:(id<CommandErrorCreator>)theCommandErrorCreator
{
  self = [super init];
    
  if (self) 
  {
      errorHandler_ = theErrorHandler;
      commandErrorCreator_ = theCommandErrorCreator;
  }
  
  return self;
}

- (BOOL)parsedJSONResponseHasError:(NSDictionary *)theParsedJSONResponse error:(NSError **)anError
{
    NSParameterAssert(anError);
    
    id errors = [theParsedJSONResponse valueForKey:@"errors"];
    
    if (!errors)
        return NO;
    
    if ([errors respondsToSelector:@selector(objectAtIndex:)]) {
        NSEnumerator *errorEnumerator = [errors reverseObjectEnumerator];
        
        NSError *prevError = nil;
        NSDictionary *errorDict = nil;
        while (errorDict = [errorEnumerator nextObject]) {
            NSDictionary *userInfo = nil;
            NSDictionary *errorDetails = [errorDict valueForKeyPath:@"error.detail"];
        
            if (errorDetails || prevError) {
                userInfo = [NSMutableDictionary dictionaryWithCapacity:2];
                
                if (errorDetails)
                    [userInfo setValue:errorDetails forKey:kMMCErrorDetailKey];
                
                if (prevError)
                    [userInfo setValue:prevError forKey:NSUnderlyingErrorKey];                    
            }
            
            *anError = [NSError errorWithDomain:[errorDict valueForKeyPath:@"error.ns"]
                                        code:[[errorDict valueForKeyPath:@"error.code"] intValue]
                                    userInfo:userInfo];
            prevError = *anError;
        }
    } else {
        *anError = [[self commandErrorCreator] errorWithCode:YACommandErrorCodeNilParsedJSONResponse];
    }
    
    return YES;
}

- (BOOL)urlRequestHasError:(NSURLRequest *)theURLRequest error:(NSError **)anError
{
    NSParameterAssert(anError);
    
    if (theURLRequest) 
    {
        return NO;
    }
    
    *anError = [[self commandErrorCreator] errorWithCode:YACommandErrorCodeNilURLRequest];
    
    return YES;
}

- (void)handleError:(NSError *)theError
{
    NSParameterAssert(theError);
    
    if ([theError code] == YAMMCServerErrorCredentialsNotValid ||
        [theError code] == YAMMCServerErrorCrumbNotValid) {
        //need some generic handling
        
        return;
    }
    
    [[self errorHandler] handleError:theError];
}

@end
