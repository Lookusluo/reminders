//
//  DetailViewController.h
//  MVCreminders
//
//  Created by Yazhong Luo on 12/7/16.
//  Copyright © 2016 Yazhong Luo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MOCProtocol.h"
#import "HandleToDoEntity.h"
#import "ToDoEntity+CoreDataClass.h"
@import UserNotifications;

@interface DetailViewController : UIViewController<MOCProtocol,HandleToDoEntity,UIGestureRecognizerDelegate,UNUserNotificationCenterDelegate>

- (void)receiveMOC:(NSManagedObjectContext *)incomingMOC;

- (void) receiveToDoEntity :(ToDoEntity *)incomingToDoEntity;

@end
