//
//  YATextFormatter.m
//  altoids
//
//  Created by Devin Doman on 3/21/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YATextFormatter.h"

@interface YATextFormatter ()

- (NSString *)convertHTMLEntitiesInString:(NSString *)theText;
@property (nonatomic, strong) NSMutableString* resultString;

@end

@implementation YATextFormatter
@synthesize resultString = resultString_;

- (id)init
{
    self = [super init];
    
    if(self) 
    {
        resultString_ = [[NSMutableString alloc] init];
    }
    return self;
}

#pragma mark -
#pragma mark UITextFilter protocol methods

- (NSString *)formatTextForDisplay:(NSString *)theText
{
    return [self convertHTMLEntitiesInString:theText];
}

#pragma mark -
#pragma mark NSXMLParser delegate methods

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)theText 
{
    [resultString_ appendString:theText];
}

#pragma mark -
#pragma mark private methods

- (NSString *)convertHTMLEntitiesInString:(NSString *)theText 
{
    if(theText == nil) 
    {
        return nil;
    }
    
    NSString* parsed;
    @synchronized(resultString_)
    {
        NSString* xmlStr = [NSString stringWithFormat:@"<d>%@</d>", theText];
        NSData* data = [xmlStr dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        NSXMLParser* xmlParse = [[NSXMLParser alloc] initWithData:data];
        [xmlParse setDelegate:self];
        [xmlParse parse];
        
        parsed = [NSString stringWithFormat:@"%@", resultString_];
        [resultString_ setString:@""];
    }
    return parsed;
}
@end
