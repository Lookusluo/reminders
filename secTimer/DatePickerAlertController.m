//
//  DatePickerAlertController.m
//  secTimer
//
//  Created by Yazhong Luo on 12/5/16.
//  Copyright © 2016 Yazhong Luo. All rights reserved.
//

#import "DatePickerAlertController.h"

@interface DatePickerAlertController ()

@property(nonatomic,retain)UIDatePicker* datePicker;

@end

@implementation DatePickerAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.message = @"\n\n\n\n\n\n\n\n\n";
    UIDatePicker* picker = [[UIDatePicker alloc]init];
    picker.datePickerMode = UIDatePickerModeCountDownTimer;
    [self.view addSubview:picker];
    //For get a place to put datePicker, I can creat several UIAlertAction with empty Title, but it is expensive
    [self addAction:[UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action){
        //@property (nonatomic) NSTimeInterval countDownDuration; // for UIDatePickerModeCountDownTimer, ignored otherwise. default is 0.0. limit is 23:59 (86,399 seconds). value being set is div 60 (drops remaining seconds).

        [self.dateSenddelegate setTimerbyPicker:self.datePicker.countDownDuration];
    }]];
    
    self.datePicker = picker;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
