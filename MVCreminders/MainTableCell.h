//
//  MainTableCell.h
//  MVCreminders
//
//  Created by Yazhong Luo on 12/7/16.
//  Copyright © 2016 Yazhong Luo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDoEntity+CoreDataClass.h"

@interface MainTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *toDoTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *toDoDateLabel;
@property (nonatomic,strong) ToDoEntity *localToDoEntity;


- (void)setInternalFields: (ToDoEntity *)incomingToDoEntity;

@end
