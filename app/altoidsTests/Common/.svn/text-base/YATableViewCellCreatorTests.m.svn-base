//
//  YATableViewCellCreatorTests.m
//  altoids
//
//  Created by Jon Herron on 2/3/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import <SenTestingKit/SenTestingKit.h>
#import "YATableViewCellCreator.h"

@interface YATableViewCellCreatorTests : SenTestCase

@property (strong, nonatomic) id tableViewMock;
@property (strong, nonatomic) NSString *reuseIdentifier;
@property (assign, nonatomic) UITableViewCellStyle cellStyle;
@property (strong, nonatomic) YATableViewCellCreator *instanceFactory;

@end

@implementation YATableViewCellCreatorTests

@synthesize tableViewMock = tableViewMock_;
@synthesize reuseIdentifier = reuseIndetifier_;
@synthesize cellStyle = cellStyle_;
@synthesize instanceFactory = instanceFactory_;

- (void)setUp
{
    [self setTableViewMock:[OCMockObject mockForClass:[UITableView class]]];
    [self setReuseIdentifier:@"id"];
    [self setCellStyle:UITableViewCellStyleSubtitle];
    [self setInstanceFactory:[[YATableViewCellCreator alloc] init]];
}

- (void)testIfTableViewDequeuesReusableCellWithIdentifierCellWillBeUsed
{   
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:[self cellStyle] reuseIdentifier:[self reuseIdentifier]];
    
    [[[[self tableViewMock] expect] andReturn:cell] dequeueReusableCellWithIdentifier:[self reuseIdentifier]];
    
    STAssertEqualObjects(cell, [[self instanceFactory] createForTableView:[self tableViewMock] withStyle:[self cellStyle] reuseIdentifier:[self reuseIdentifier]], @"Expected cell dequeued from tableView");
}

- (void)testIfTableViewDoesNotDequeueCellForReuseNewCellIsReturned
{
    [[[self tableViewMock] stub] dequeueReusableCellWithIdentifier:[self reuseIdentifier]];
    
    UITableViewCell *cell = [[self instanceFactory] createForTableView:[self tableViewMock] withStyle:[self cellStyle] reuseIdentifier:[self reuseIdentifier]];
    
    STAssertTrue([[cell reuseIdentifier] isEqualToString:[self reuseIdentifier]], @"Returned cell did not have reuse identifier set properly");
}

@end
