//
//  ToDoEntity+CoreDataProperties.h
//  MVCreminders
//
//  Created by Yazhong Luo on 12/8/16.
//  Copyright © 2016 Yazhong Luo. All rights reserved.
//

#import "ToDoEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ToDoEntity (CoreDataProperties)

+ (NSFetchRequest<ToDoEntity *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *toDoDetails;
@property (nullable, nonatomic, copy) NSDate *toDoDueDate;
@property (nullable, nonatomic, copy) NSString *toDoTitle;

@end

NS_ASSUME_NONNULL_END
