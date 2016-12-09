//
//  TimeRemainder.h
//  secTimer
//
//  Created by Yazhong Luo on 12/3/16.
//  Copyright © 2016 Yazhong Luo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatePickerAlertController.h"

@interface TimeRemainder : NSObject<DateSelected>

@property (nonatomic, readwrite)int secondCount;//set Time
@property (nonatomic,strong)NSTimer *timer;
@property(nonatomic, strong)NSString *timeOutput;

- (void) timerRun;
- (void)setTimerbyPicker:(NSTimeInterval)date;
@end
