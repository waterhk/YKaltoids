//
//  YAParticipantDescriptionBuilder.m
//  altoids
//
//  Created by Jon Herron on 10/20/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAParticipantDescriptionBuilder.h"

#define kParticipantNameSeparator @", "

// Private class extension
@interface YAParticipantDescriptionBuilder ()

// @property definitions

// methods
- (NSString *)descriptionForFormattedParticipantsSansUser:(NSMutableArray *)theFormattedParticipants sizeWithFont:(UIFont *)theFont constraintedToSize:(CGSize)theConstrainedSize userIsParticipant:(BOOL)theUserIsParticipant;

@end

@implementation YAParticipantDescriptionBuilder

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize mutableArrayCreator = mutableArrayCreator_;
@synthesize participantNameFormatter = participantNameFormatter_;
@synthesize stringSizeCalculator = stringSizeCalculator_;
@synthesize participantHandler = participantHandler_;
@synthesize sortDescriptors = sortDescriptors_;

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark ParticipantDescriptionBuilder delegate methods

- (NSString *)descriptionForParticipantInfos:(NSArray *)theParticipantInfos forDisplayInLabel:(UILabel *)theLabel
{
    return [self descriptionForParticipantInfos:theParticipantInfos sizeWithFont:[theLabel font] constraintedToSize:[theLabel frame].size];
}

- (NSString *)descriptionForParticipantInfos:(NSArray *)theParticipantInfos sizeWithFont:(UIFont *)theFont constraintedToSize:(CGSize)theConstrainedSize
{
    BOOL userIsParticipant = NO;
    NSMutableArray *participants = nil;
    NSString *formattedParticipantName = nil;
    NSUInteger participantCount = 0;
    
    if ((participantCount = [theParticipantInfos count]) == 0) 
    {
        return kNoParticipantsInConversationMessage;
    }
    
    participants = [[self mutableArrayCreator] mutableArrayWithCapacity:participantCount];
    
    theParticipantInfos = [theParticipantInfos sortedArrayUsingDescriptors:[self sortDescriptors]];
    
    for (YAParticipantInfo *participantInfo in theParticipantInfos) 
    {
        if ([participantInfo isUser]) 
        {
            userIsParticipant = YES;
            
            continue;
        }
        
        if (!(formattedParticipantName = [[self participantNameFormatter] formatShortNameForParticipantInfo:participantInfo])) 
        {
            continue;
        }
        
        [participants addObject:formattedParticipantName];
    }
    
    return [self descriptionForFormattedParticipantsSansUser:participants sizeWithFont:theFont constraintedToSize:theConstrainedSize userIsParticipant:userIsParticipant];
}

- (NSString *)descriptionForParticipants:(NSArray *)theParticipants forDisplayInLabel:(UILabel *)theLabel
{
    return [self descriptionForParticipants:theParticipants sizeWithFont:[theLabel font] constraintedToSize:[theLabel frame].size];
}

- (NSString *)descriptionForParticipants:(NSArray *)theParticipants sizeWithFont:(UIFont *)theFont constraintedToSize:(CGSize)theConstrainedSize
{
    BOOL userIsParticipant = NO;
    NSMutableArray *participants = nil;
    NSString *formattedParticipantName = nil;
    NSUInteger participantCount = 0;
    
    if ((participantCount = [theParticipants count]) == 0) 
    {
        return kNoParticipantsInConversationMessage;
    }
    
    participants = [[self mutableArrayCreator] mutableArrayWithCapacity:participantCount];
    
    theParticipants = [theParticipants sortedArrayUsingDescriptors:[self sortDescriptors]];
    
    for (YAParticipant *participant in theParticipants) 
    {
        if ([[self participantHandler] participantIsUser:participant]) 
        {
            userIsParticipant = YES;
            
            continue;
        }
        
        if (!(formattedParticipantName = [[self participantNameFormatter] formatShortNameForParticipant:participant])) 
        {
            continue;
        }
        
        [participants addObject:formattedParticipantName];
    }
    
    return [self descriptionForFormattedParticipantsSansUser:participants sizeWithFont:theFont constraintedToSize:theConstrainedSize userIsParticipant:userIsParticipant];
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
#pragma mark YAParticipantDescriptionBuilder ()

- (NSString *)descriptionForFormattedParticipantsSansUser:(NSMutableArray *)theFormattedParticipants sizeWithFont:(UIFont *)theFont constraintedToSize:(CGSize)theConstrainedSize userIsParticipant:(BOOL)theUserIsParticipant
{
    CGFloat maxWidth = theConstrainedSize.width + 1;
    CGFloat widthToLop = 0;
    CGSize formattedParticipantSize = {0};
    CGSize participantDescriptionSize = {0};
    CGSize participantSeparatorSize = {0};
    CGSize suffixSize = {0};
    NSArray *participantsToCommaDelimit;
    NSMutableArray *formattedParticipantWidths = nil;
    NSString *suffix = @"";
    NSUInteger numberOfParticipants = 0;
    NSUInteger numberOfTruncatedParticipants = 0;
    
    numberOfParticipants = [theFormattedParticipants count];
    
    if (theUserIsParticipant) 
    {
        if (numberOfParticipants == 0) 
        {
            return kUserAsOnlyParticipant;
        }
        
        [theFormattedParticipants addObject:kAndUserAsParticipant];
        
        ++numberOfParticipants;
    }
    
    formattedParticipantWidths = [[self mutableArrayCreator] mutableArrayWithCapacity:numberOfParticipants];
    participantSeparatorSize = [[self stringSizeCalculator] sizeOfString:kParticipantNameSeparator withFont:theFont];
    
    for (NSString *formattedParticipant in theFormattedParticipants) 
    {
        formattedParticipantSize = [[self stringSizeCalculator] sizeOfString:formattedParticipant withFont:theFont];
        [formattedParticipantWidths addObject:[NSNumber numberWithFloat:formattedParticipantSize.width]];
        
        participantDescriptionSize.width += formattedParticipantSize.width + participantSeparatorSize.width;
    }
    
    participantDescriptionSize.width -= participantSeparatorSize.width;
    suffixSize.width = 0;
    
    while (participantDescriptionSize.width + suffixSize.width > maxWidth) 
    {
        ++numberOfTruncatedParticipants;
        
        if (numberOfTruncatedParticipants == numberOfParticipants) 
        {
            // todo: per requirements this really should truncate the first name until & X more fit.
            return [theFormattedParticipants objectAtIndex:0];
        }
        
        widthToLop = [[formattedParticipantWidths objectAtIndex:numberOfParticipants - numberOfTruncatedParticipants] floatValue];
        widthToLop += participantSeparatorSize.width;
        participantDescriptionSize.width -= widthToLop;
        
        suffix = [NSString stringWithFormat:kMoreParticipants, numberOfTruncatedParticipants];
        suffixSize = [[self stringSizeCalculator] sizeOfString:suffix withFont:theFont];
    }
    
    if (theUserIsParticipant && numberOfTruncatedParticipants == 0) 
    {
        participantsToCommaDelimit = [theFormattedParticipants subarrayWithRange:NSMakeRange(0, numberOfParticipants - 1)];
        suffix = [theFormattedParticipants lastObject];
    }
    else
    {
        participantsToCommaDelimit = [theFormattedParticipants subarrayWithRange:NSMakeRange(0, numberOfParticipants - numberOfTruncatedParticipants)];
    }
    
    return [NSString stringWithFormat:@"%@%@", [participantsToCommaDelimit componentsJoinedByString:kParticipantNameSeparator], suffix];
}

@end
