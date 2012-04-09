//
//  YAInMemoryTransport.m
//  altoids
//
//  Created by Robby Cahyadi Hendro Saputro on 8/18/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAInMemoryTransport.h"

@interface YAInMemoryTransportHTTPURLResponse : NSObject <HTTPURLResponse>
- (id)initWithURL:(NSURL *)url statusCode:(NSInteger)statusCode HTTPVersion:(NSString *)HTTPVersion headerFields:(NSDictionary *)headerFields;
@end

@interface YAInMemoryTransportHTTPURLResponse()
@property (nonatomic, copy) NSURL *url;
@property (nonatomic, assign) NSInteger statusCode;
@property (nonatomic, retain) NSDictionary *allHeaderFields;
@end

@implementation YAInMemoryTransportHTTPURLResponse
@synthesize url = url_;
@synthesize statusCode = statusCode_;
@synthesize allHeaderFields = allHeaderFields_;

- (id)initWithURL:(NSURL *)url statusCode:(NSInteger)statusCode HTTPVersion:(NSString *)HTTPVersion headerFields:(NSDictionary *)headerFields
{
    self = [super init];
    if (self) {
        url_ = [url copy];
        statusCode_ = statusCode;
        allHeaderFields_ = headerFields;
    }
    
    return self;
}

- (NSString *)MIMEType
{
    return [[self allHeaderFields] valueForKey:@"Content-Type"];
}

- (long long)expectedContentLength 
{
    return [[[self allHeaderFields] valueForKey:@"Content-Length"] longLongValue];
}

- (NSString *)textEncodingName
{
    return @"utf-8";
}

- (NSString *)suggestedFilename
{
    return @"dummy";
}

- (NSURL *)URL
{
    return url_;
}
@end

@interface YAInMemoryTransport ()
+ (BOOL)string:(NSString *)aString contains:(NSString *)aSubstring;
- (void)generateWithRequest:(NSURLRequest *)request urlResponse:(id<HTTPURLResponse> __autoreleasing*)urlResponse data:(NSData *__autoreleasing*)data;
@end

@implementation YAInMemoryTransport
+ (BOOL)string:(NSString *)aString contains:(NSString *)aSubstring
{
    NSRange range = [aString rangeOfString:aSubstring options:NSCaseInsensitiveSearch];
    return range.length > 0;
}

- (void)sendSynchronousRequest:(NSURLRequest *)request returningResponse:(id<HTTPURLResponse> __autoreleasing *)urlResponse data:(NSData *__autoreleasing*)data
                         error:(NSError *__autoreleasing *)error
{
    [self generateWithRequest:request urlResponse:urlResponse data:data];
    *error = nil;
}

- (void)startRequest:(NSURLRequest *)request withDelegate:(id<NSURLConnectionDataDelegate>)delegate
{
    id<HTTPURLResponse> urlResponse = nil;
    NSData *data = nil;
    [self generateWithRequest:request urlResponse:&urlResponse data:&data];

    [delegate connection:nil didReceiveData:data];
    [delegate connectionDidFinishLoading:nil];
}

- (void)generateWithRequest:(NSURLRequest *)request urlResponse:(id<HTTPURLResponse> __autoreleasing*)urlResponse data:(NSData *__autoreleasing*)data
{
    NSString *url = [[request URL] absoluteString];
    
    NSString *responseString = nil;
    
    if ([YAInMemoryTransport string:url contains:@"conversations"]) {
        responseString = @"{"
        "  \"moreConvPresent\" : true,"
        "  \"conversations\" :"
        "  ["
        "    {"
        "      \"conversation\" : "
        "      {"
        "        \"cid\" : \"123\","
        "        \"summary\" :"
        "        {"
        "          \"totalMsgs\" : 25,"
        "          \"unreadMsgs\" : 12"
        "        },"
        "        \"mgrData\" :"
        "        {"
        "          \"participants\" : "
        "          ["
        "            {"
        "              \"pid\" : \"1\","
        "              \"firstname\" : \"Vivek\","
        "              \"lastname\" : \"Aggarwal\","
        "              \"created\" : 2131353245,"
        "              \"address\" : \"14081112222\","
        "              \"addressType\" : \"sms\","
        "              \"creator\": 0"
        "            },"
        "            {"
        "              \"pid\" : \"2\","
        "              \"firstname\" : \"Naveen\","
        "              \"lastname\" : \"Sanjeeva\","
        "              \"created\" : 213254325,"
        "              \"address\" : \"14081112223\","
        "              \"addressType\" : \"mmc\","
        "              \"creator\": 1,"
        "              \"isYou\": true"
        "            },"
        "            {"
        "              \"pid\" : \"3\","
        "              \"firstname\" : \"Amit\","
        "              \"lastname\" : \"Rao\","
        "              \"created\": 413545643,"
        "              \"address\" : \"14081112224\","
        "              \"addressType\" : \"sms\","
        "              \"creator\": 0"
        "            }"
        "          ],"
        "          \"topic\" : \"\","
        "          \"sTopic\" : \"server generated topic\""
        "        } , "
        "        \"recentMsg\" : "
        "        {"
        "          \"mid\" : \"1\","
        "          \"info\" : "
        "          {"
        "            \"subj\" : \"email subject\","
        "            \"date\" : 1224314,"
        "            \"rcpts\" : \"Vivek Aggarwa, Naveen Sanjeeva and You\","
        "            \"from\" : "
        "            {"
        "              \"name\" : \"Vivek Aggarwal\""
        "            },"
        "            \"snippet\" : \"Vivek deserves a break..\""
        "          }"
        "        }"
        "      }"
        "    },"
        "    {"
        "      \"conversation\" : "
        "      {"
        "        \"cid\" : \"124\","
        "        \"summary\" :"
        "        {"
        "          \"totalMsgs\" : 25,"
        "          \"unreadMsgs\" : 12"
        "        },"
        "        \"mgrData\" :"
        "        {"
        "          \"isParticipant\" : false "
        "        } ,"
        "        \"recentMsg\" : "
        "        {"
        "          \"mid\" : \"1\","
        "          \"info\" : "
        "          {"
        "            \"subj\" : \"email's subject\","
        "            \"date\" : 1224312344,"
        "            \"rcpts\" : \"Gitanjali Sheth, Ram Iyer and You\","
        "            \"from\" : "
        "            {"
        "              \"name\" : \"Ram Iyer\""
        "            },"
        "            \"snippet\" : \"Too much work!!\""
        "          }"
        "        }"
        "      }"
        "    },"
        "    {"
        "      \"conversation\" :"
        "      {"
        "        \"cid\" : \"125\","
        "        \"errors\" : "
        "        ["
        "          {"
        "            \"error\" :"
        "            {"
        "              \"code\" : 1234,"
        "              \"ns\" : \"mgr\","
        "              \"message\" : \"failed to query sherpa\""
        "            }"
        "          }"
        "        ]"
        "      }"
        "    },"
        "    {"
        "      \"conversation\" :"
        "      {"
        "        \"cid\" : \"126\""
        "      }"
        "    },"
        "    {"
        "      \"conversation\" :"
        "      {"
        "        \"cid\" : \"127\""
        "      }"
        "    }"
        "  ]  "
        "}";
    } else if ([YAInMemoryTransport string:url contains:@"conversation"]) {
        if ([YAInMemoryTransport string:url contains:@"replyConv"]) {
            responseString = @"{\
            \"mid\" : \"2\", \
            \"msgTimestamp\" : 32134325245 \
            }";
        } else {
            responseString = @"{\"conversation\":{\"cid\":\"vaggarwa_test1#fv\\/1689678225@yahoo.com\",\"summary\":{\"totalMsgs\":1,\"unreadMsgs\":0},\"mgrData\":{\"created\":1309922409,\"sTopic\":\"server generated topic\",\"participants\":[{\"pid\":\"009af08a852710f8812647d6bd3483c0\",\"firstname\":\"Vivek\",\"lastname\":\"Aggarwal\",\"created\":1309839437,\"address\":\"14081112222\",\"addressType\":\"sms\",\"creator\":0},{\"pid\":\"c33d8bd725bfb743d73082e1942d259a\",\"firstname\":\"Jon\",\"lastname\":\"Doe\",\"created\":1309839437,\"address\":\"vaggarwa_test1\",\"addressType\":\"mmc\",\"creator\":1}]},\"recentMsg\":{\"mid\":765244449,\"info\":{\"subj\":\"tbd\",\"date\":1309839440,\"rcpts\":\"recipients\",\"snippet\":\"Hello\",\"from\":{\"name\":\"firstname lastname\"}}}},\"participants\":[{\"id\":\"sms:14081112222\",\"pid\":\"009af08a852710f8812647d6bd3483c0\"}],\"messageId\":765244449,\"msgTimestamp\":1309839440}";
        }
    } else if ([YAInMemoryTransport string:url contains:@"validateParticipants"]) {
        responseString = @"{\"participants\":[{\"id\":\"sms:14081113333\",\"firstname\":\"Nirmal\",\"lastname\":\"Thangaraj\",\"valid\":true},{\"id\":\"sms:14081113333\",\"firstname\":\"Vivek\",\"lastname\":\"Aggarwal\",\"valid\":false}]}";
    } else if ([YAInMemoryTransport string:url contains:@"getToken"]) {
        responseString = @"{\"bindToken\":\"the-bind-token\",\"shortCode\":\"92500\",\"status\":\"OK\",\"statusCode\":0}";
    } else if ([YAInMemoryTransport string:url contains:@"verifyToken"]) {
        static int count = 1;
        [NSThread sleepForTimeInterval:1];
        if ((count % 3) == 0) {
            responseString = @"{\"remainingTime\":1234567,\"number\":\"14081112222\"}";
        } else {
            responseString = @"{\"errors\":[{\"error\":{\"ns\":\"mmcreg\", \"code\":5}}]}";
            *data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
            *urlResponse = [[YAInMemoryTransportHTTPURLResponse alloc] initWithURL:[request URL] statusCode:YAHTTPStatusBadRequest HTTPVersion:@"1.1"
                                                     headerFields:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%u",[*data length]], @"Content-Length",
                                                                   @"application/json;charset=utf-8", @"Content-Type",nil]];
        }
        count++;
    } else if ([YAInMemoryTransport string:url contains:@"numberServices"]) {
        responseString = @"{\"numbers\":[{\"number\":\"14086774567\",\"services\":[{\"type\":\"mmc\",},{\"type\":\"sms\"}]},{\"number\":\"919867523456\",\"services\":[{\"type\":\"sms\"}]},{\"number\":\"16505551111\",\"services\":[{\"type\":\"mmc\",}]}{\"number\":\"16505552222\",\"services\":[]}]}";
    } else if ([YAInMemoryTransport string:url contains:@"delete"] && [YAInMemoryTransport string:url contains:@"/registrationInfo"]) {
        responseString = @"";
    } else if ([YAInMemoryTransport string:url contains:@"deactivate"]) {
        responseString = @"";
    } else if ([YAInMemoryTransport string:url contains:@"revalidate"]) {
        responseString = @"{\"remainingTime\":3600}";
    } else if ([YAInMemoryTransport string:url contains:@"bind"]) {
        responseString = @"{\"number\":\"14081112222\",\"remainingTime\":3600}";
    }
    
    if (!*data)
        *data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
    
    if (!*urlResponse)
        *urlResponse = [[YAInMemoryTransportHTTPURLResponse alloc] initWithURL:[request URL] statusCode:200 HTTPVersion:@"HTTP/1.1"
                                                 headerFields:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%u",[*data length]], @"Content-Length",
                                                               @"application/json;charset=utf-8", @"Content-Type",nil]];
}
@end
