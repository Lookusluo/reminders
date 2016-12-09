//
//  DatePickerAlertController.h
//  secTimer
//
//  Created by Yazhong Luo on 12/5/16.
//  Copyright © 2016 Yazhong Luo. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DateSelected<NSObject>
-(void)setTimerbyPicker:(NSTimeInterval)date;
@end
@interface DatePickerAlertController : UIAlertController
@property (nonatomic,weak) id<DateSelected> dateSenddelegate;
@end
