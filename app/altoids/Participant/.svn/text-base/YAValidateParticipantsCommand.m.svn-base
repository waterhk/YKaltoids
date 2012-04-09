//
//  YAValidateParticipantsCommand.m
//  altoids
//
//  Created by Robby Cahyadi Hendro Saputro on 8/25/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAValidateParticipantsCommand.h"
#import "TransportFactory.h"
#import "Transport.h"
#import "ParticipantHandler.h"
#import "ParticipantRequestBuilder.h"
#import "ParticipantResponseParser.h"
#import "YAValidateParticipantResponse.h"

@interface YAValidateParticipantsCommand ()

@property (nonatomic, strong) NSArray *participants;
@property (nonatomic, strong) id<Transport> transport;
@property (nonatomic, strong) id<ParticipantHandler> participantHandler;
@property (nonatomic, strong) id<ParticipantRequestBuilder> requestBuilderFactory;
@property (nonatomic, strong) id<ParticipantResponseParser> responseParserFactory;

+ (NSDictionary *)findParticipantInfoWithParticipantId:(NSString *)pid fromParticipants:(NSArray *)participantInfos;

@end

@implementation YAValidateParticipantsCommand

@synthesize participants = participants_;
@synthesize transport = transport_;
@synthesize participantHandler = participantHandler_;
@synthesize requestBuilderFactory = requestBuilderFactory_;
@synthesize responseParserFactory = responseParserFactory_;

+ (NSDictionary *)findParticipantInfoWithParticipantId:(NSString *)aParticipantid fromParticipants:(NSArray *)participantsResponse
{
    for (NSDictionary *participant in participantsResponse) 
    {
        NSString *participantId = [participant valueForKeyPath:@"id"];
        if ([participantId caseInsensitiveCompare:aParticipantid] == NSOrderedSame) {
            return participant;
        }
    }
    
    return nil;
}

- (id)initWithParticipants:(NSArray *)participants
                 transport:(id<Transport>)transport
        participantHandler:(id<ParticipantHandler>)participantHandler
     requestBuilderFactory:(id<ParticipantRequestBuilder>)requestBuilderFactory
     responseParserFactory:(id<ParticipantResponseParser>)responseParserFactory
{
    self = [super init];
    if (self) {
        participants_ = participants;
        transport_ = transport;
        participantHandler_ = participantHandler;
        requestBuilderFactory_ = requestBuilderFactory;
        responseParserFactory_ = responseParserFactory;
    }
    
    return self;
}

- (NSError*)execute {
    NSURLRequest *request = [[self requestBuilderFactory] buildValidateParticipantsRequestWithParticipants:participants_];
    
    NSError *error = nil;
    NSData *data = nil;
    id<HTTPURLResponse> urlResponse;
    
    [[self transport] sendSynchronousRequest:request returningResponse:&urlResponse data:&data error:&error];
    
    YAValidateParticipantResponse *parsedResponse = [[self responseParserFactory] parseValidateParticipantResponse:data error:error];
    
    if ([parsedResponse error]) {
        return error;
    }
    
    NSMutableArray *participantInfos = [[parsedResponse body] mutableArrayValueForKeyPath:@"participants"];
    
    for (YAParticipant *participant in participants_) 
    {
        NSString *participantId = [[participant address] handle];
        
        NSDictionary *participantInfo = [YAValidateParticipantsCommand findParticipantInfoWithParticipantId:participantId fromParticipants:participantInfos];
        if (participantInfo == nil) {
            continue;
        }
        
        //NSNumber *value = [participantInfo valueForKeyPath:@"valid"];
        //BOOL valid = [value boolValue];
        
        // TODO: define enum; add validation status property to participant class
        //YAParticipantValidationStatus status = valid ? YAParticipantValid : YAParticipantInvalid;
        //[participantHandler_ setValidationStatus:status forParticipant:participant];
    }
    
    return error;
}

@end
