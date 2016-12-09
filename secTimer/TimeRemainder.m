//
//  TimeRemainder.m
//  secTimer
//
//  Created by Yazhong Luo on 12/3/16.
//  Copyright © 2016 Yazhong Luo. All rights reserved.
//

#import "TimeRemainder.h"

@implementation TimeRemainder

- (void) timerRun{
    if (self.secondCount != 0) {
        self.secondCount = self.secondCount - 1;
        int minus = self.secondCount/60;
        int second = self.secondCount - (minus * 60);
        
        self.timeOutput = [NSString stringWithFormat:@"%2d:%2d",minus,second];
        
        if (self.secondCount == 0) {
            [self.timer invalidate];
            self.timer = nil; //remove old timer status
        }
        else;
    }
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



//- (void)makeTimeWithInterval:(NSTimeInterval)timeInterval{
//    if(self.timer){
//        [self.timer invalidate];
//        self.timer = nil; //remove old timer status
//    }
//    
//    timeInterval = 1.0; //refresh per sec
//    
//    //creat new timer
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(setUpEndTimeShow) userInfo:nil repeats:YES];
//    self.timer = timer;
//    [timer fire];
//}
//
//- (void)setUpEndTimeShow{
//    [self makeTimeWithInterval:5];
//    
//}
@end
