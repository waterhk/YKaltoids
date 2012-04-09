//
//  YAURLParameterEncoder.m
//  altoids
//
//  Created by Jon Herron on 10/13/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAURLParameterEncoder.h"

// Private class extension
@interface YAURLParameterEncoder ()

// @property definitions

// methods

@end

@implementation YAURLParameterEncoder

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

- (id)init
{
  self = [super init];
    
  if (self) 
  {
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
#pragma mark URLParameterEncoder delegate methods

- (NSString *)encodeURLParameter:(NSString *)theURLParameter
{   
    if ([theURLParameter length] == 0)
    {
        return theURLParameter;
    }
    
    // rfc: http://tools.ietf.org/html/rfc3986#section-2.1
    
    NSMutableString *encodedURLParameter = [NSMutableString stringWithString:theURLParameter];
    NSString *encodedCharacter = nil;
    NSUInteger urlParameterLegth = [encodedURLParameter length];
    unichar urlParameterCharacter = 0;
    
    for (int i = urlParameterLegth - 1; i >= 0; --i) 
    {
        urlParameterCharacter = [encodedURLParameter characterAtIndex:i];
        
        if ((urlParameterCharacter >= '0' && urlParameterCharacter <= '9') ||
            (urlParameterCharacter >= 'A' && urlParameterCharacter <= 'Z') ||
            (urlParameterCharacter >= 'a' && urlParameterCharacter <= 'z') ||
            urlParameterCharacter == '-' ||
            urlParameterCharacter == '.' ||
            urlParameterCharacter == '_' ||
            urlParameterCharacter == '~')
        {   
            continue;
        }
        
        encodedCharacter = [NSString stringWithFormat:@"%%%X", urlParameterCharacter];
        [encodedURLParameter replaceCharactersInRange:NSMakeRange(i, 1) withString:encodedCharacter];
    }
    
    return encodedURLParameter;
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
#pragma mark YAURLParameterEncoder ()

@end
