//
//  YAConversationEntityDescriptionCreator.m
//  altoids
//
//  Created by Jon Herron on 9/27/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAConversationEntityDescriptionCreator.h"

@implementation YAConversationEntityDescriptionCreator

- (id)init
{
  self = [super init];
  if (self) {
      
  }
  
  return self;
}

- (NSEntityDescription *)conversationEntityDescriptionInManagedObjectContext:(NSManagedObjectContext *)theManagedObjectContext
{
    return [NSEntityDescription entityForName:kConversationEntityName inManagedObjectContext:theManagedObjectContext];
}

@end
