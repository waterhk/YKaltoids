//
//  YAAddress.h
//  altoids
//
//  Created by Jon Herron on 8/26/11.
//  Copyright (c) 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class YAParticipant;

@interface YAAddress : NSManagedObject

@property (nonatomic, retain) NSString * handle;
@property (nonatomic, retain) NSSet *participants;
@end

@interface YAAddress (CoreDataGeneratedAccessors)

- (void)addParticipantsObject:(YAParticipant *)value;
- (void)removeParticipantsObject:(YAParticipant *)value;
- (void)addParticipants:(NSSet *)values;
- (void)removeParticipants:(NSSet *)values;
@end
