//
//  ToDoEntity+CoreDataProperties.m
//  MVCreminders
//
//  Created by Yazhong Luo on 12/8/16.
//  Copyright © 2016 Yazhong Luo. All rights reserved.
//

#import "ToDoEntity+CoreDataProperties.h"

@implementation ToDoEntity (CoreDataProperties)

+ (NSFetchRequest<ToDoEntity *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ToDoEntity"];
}

@dynamic toDoDetails;
@dynamic toDoDueDate;
@dynamic toDoTitle;

@end
