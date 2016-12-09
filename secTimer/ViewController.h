//
//  ViewController.h
//  secTimer
//
//  Created by Yazhong Luo on 12/3/16.
//  Copyright © 2016 Yazhong Luo. All rights reserved.
//

#import <UIKit/UIKit.h>
@import UserNotifications;
@interface ViewController : UIViewController<UNUserNotificationCenterDelegate>
@property (nonatomic, readwrite)int secondCount;//set Time
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,strong) UNUserNotificationCenter *center;

- (void) timerRun;
@end

