//
//  YAParticipantInfo.m
//  altoids
//
//  Created by Jon Herron on 8/18/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAParticipantInfo.h"

// Private class extension
@interface YAParticipantInfo ()

// @property definitions
@property (copy,   nonatomic) NSString *participantID;
@property (copy,   nonatomic) NSString *firstName;
@property (copy,   nonatomic) NSString *lastName;
@property (copy,   nonatomic) NSString *imageURL;
@property (strong, nonatomic) YAAddressInfo *addressInfo;
@property (assign, nonatomic) BOOL isContact;
@property (copy,   nonatomic) NSDate *timestamp;
@property (assign, nonatomic) BOOL isConversationCreator;
@property (assign, nonatomic) BOOL isUser;
@property (copy,   nonatomic) NSString *transientID;

// methods

@end

@implementation YAParticipantInfo

// Class methods
#pragma mark -
#pragma mark Class methods

+ (id)participantInfoWithFirstName:(NSString *)aFirstName 
                          lastName:(NSString *)aLastName 
                       addressInfo:(YAAddressInfo *)anAddress
{
    return [[YAParticipantInfo alloc] initWithParticipantID:nil firstName:aFirstName lastName:aLastName imageURL:nil addressInfo:anAddress isContact:NO timestamp:nil isConversationCreator:NO isUser:NO transientID:nil];
}

+ (id)participantInfoWithFirstName:(NSString *)aFirstName 
                          lastName:(NSString *)aLastName 
                       addressInfo:(YAAddressInfo *)anAddress 
                         isContact:(BOOL)aIsContact
{
    return [[YAParticipantInfo alloc] initWithParticipantID:nil firstName:aFirstName lastName:aLastName imageURL:nil addressInfo:anAddress isContact:aIsContact timestamp:nil isConversationCreator:NO isUser:NO transientID:nil];
}

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize participantID = participantID_;
@synthesize firstName = firstName_;
@synthesize lastName = lastName_;
@synthesize imageURL = imageURL_;
@synthesize addressInfo = addressInfo_;
@synthesize isContact = isContact_;
@synthesize timestamp = timestamp_;
@synthesize isConversationCreator = isConversationCreator_;
@synthesize isUser = isUser_;
@synthesize transientID = transientID_;

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

- (id)initWithParticipantID:(NSString *)aParticipantID
                  firstName:(NSString *)aFirstName
                   lastName:(NSString *)aLastName
                   imageURL:(NSString *)theImageURL
                addressInfo:(YAAddressInfo *)anAddress
                  isContact:(BOOL)anIsContact
                  timestamp:(NSDate *)aTimestamp
      isConversationCreator:(BOOL)anIsConversationCreator
                     isUser:(BOOL)anIsUser 
                transientID:(NSString *)aTransientID
{
    self = [super init];
    
    if (self) 
    {
        participantID_ = [aParticipantID copy];
        firstName_ = [aFirstName copy];
        lastName_ = [aLastName copy];
        imageURL_ = [theImageURL copy];
        addressInfo_ = anAddress;
        isContact_ = anIsContact;
        timestamp_ = [aTimestamp copy];
        isConversationCreator_ = anIsConversationCreator;
        isUser_ = anIsUser;
        transientID_ = [aTransientID copy];
    }
    
    return self;
}

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// Overrides
#pragma mark -
#pragma mark Overrides

- (NSString *)description
{
    return [NSString stringWithFormat:@"\t{\n\t\tparticipantID:%@\n\t\tfirstName:%@\n\t\tlastName:%@\n\t\timageURL:%@\n\t\taddress:%@\n\t\tisContact:%@\n\t\ttimestamp:%@\n\t\tisConversationCreator:%@\n\t\tisUser:%@\n\t\ttransientID:%@\n\t}\n",
            participantID_,
            firstName_,
            lastName_,
            imageURL_,
            [addressInfo_ handle],
            ((isContact_) ? @"YES":@"NO"),
            timestamp_,
            ((isConversationCreator_) ? @"YES":@"NO"),
            ((isUser_) ? @"YES":@"NO"),
            transientID_];
}

// Delegate methods
#pragma mark -
#pragma mark <Delegate> delegate methods

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
#pragma mark YAParticipantInfo ()

@end
