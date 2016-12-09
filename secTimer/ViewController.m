//
//  ViewController.m
//  secTimer
//
//  Created by Yazhong Luo on 12/3/16.
//  Copyright © 2016 Yazhong Luo. All rights reserved.
//

#import "ViewController.h"
#import "DatePickerAlertController.h"
@import UserNotifications;

//#import "TimeRemainder.h"
@interface ViewController ()<DateSelected>

//@property(nonatomic,strong)TimeRemainder* remainder;
@property (weak, nonatomic) IBOutlet UILabel *displayLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self.displayLabel sizeToFit];
    self.center = [UNUserNotificationCenter currentNotificationCenter];
    UIApplication.sharedApplication.applicationIconBadgeNumber = 0;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

- (IBAction)countDown:(UIButton *)sender {

    DatePickerAlertController *sheetAlert = [DatePickerAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    sheetAlert.dateSenddelegate = self;
    //AutoLay Out addConstraint
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:sheetAlert.view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:self.view.frame.size.height* 0.38];
    
    [sheetAlert.view addConstraint:height];
    [self presentViewController:sheetAlert animated:YES completion:nil];
    

    
//    [self setTimer];
}





- (void)localnotification{
    //Creat Snooze Action category
    UNNotificationAction* snoozeAction = [UNNotificationAction
                                          actionWithIdentifier:@"SNOOZE_ACTION"
                                          title:@"Snooze"
                                          options:UNNotificationActionOptionNone];
    NSArray *notificationActions = @[snoozeAction];
    UNNotificationCategory * sonnzeCategory = [UNNotificationCategory categoryWithIdentifier:@"TIMER_EXPIRED" actions:@[snoozeAction] intentIdentifiers:notificationActions options:UNNotificationCategoryOptionCustomDismissAction];

    // registration
    [_center setNotificationCategories:[NSSet setWithObject:sonnzeCategory]];
    
        //Set Notification content
    UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
    content.title = [NSString localizedUserNotificationStringForKey:@"Time up!" arguments:nil];
    content.body = [NSString localizedUserNotificationStringForKey:@"Your Time is expired"
                                                         arguments:nil];
    
    content.sound = [UNNotificationSound defaultSound];
    content.categoryIdentifier = @"TIMER_EXPIRED";
    content.badge = @([[UIApplication sharedApplication] applicationIconBadgeNumber] + 1);

    
//    UNNotificationSetting *settings =
    
    // create actions


    // Create a trigger
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:self.secondCount+1 repeats:NO];
    
    // Create the request object.
    UNNotificationRequest* request = [UNNotificationRequest
                                      requestWithIdentifier:@"Count Down Alarm" content:content trigger:trigger];
    [_center addNotificationRequest:request withCompletionHandler:nil];
}

- (void) timerRun{
    if (self.secondCount != 0) {
        self.secondCount = self.secondCount - 10;
        int minus = self.secondCount/60;
        int second = self.secondCount - (minus * 60);
        
        self.displayLabel.text = [NSString stringWithFormat:@"%2d:%2d",minus,second];
        
        if (self.secondCount == 0) {
            [self.timer invalidate];
            self.timer = nil; //remove old timer status
        }
        else;
    }
    [self localnotification];
    self.center = [UNUserNotificationCenter currentNotificationCenter];
}

- (void)setTimerbyPicker:(NSTimeInterval)date{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    NSString *settime = [NSString stringWithFormat:@"%f",date];
    self.secondCount = [settime intValue];
    NSLog(@"%d",_secondCount);
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
    [self.timer fire];
}

@end
