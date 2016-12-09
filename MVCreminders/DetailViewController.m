//
//  DetailViewController.m
//  MVCreminders
//
//  Created by Yazhong Luo on 12/7/16.
//  Copyright © 2016 Yazhong Luo. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (strong,nonatomic) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextView *detailTextView;
@property (weak, nonatomic) IBOutlet UIDatePicker *dueDatePicker;
@property (strong,nonatomic) ToDoEntity *localEntity;

//State Change
@property(nonatomic, assign)BOOL wasDeleted;

//Notification
@property (nonatomic,strong) UNUserNotificationCenter *center;

@end

@implementation DetailViewController
-(void)viewWillAppear:(BOOL)animated{
    self.wasDeleted = NO;
    
    self.titleField.text = self.localEntity.toDoTitle;
    self.detailTextView.text = self.localEntity.toDoDetails;
    
    NSDate *dueDate = self.localEntity.toDoDueDate;
    if (dueDate != nil) {
        [self.dueDatePicker setDate:dueDate];
    }
 //Detect edit end by using a notifiy Observer
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textViewDidEndEditing:) name:UITextViewTextDidEndEditingNotification object:self];
}

-(void)viewWillDisappear:(BOOL)animated{
    if (self.wasDeleted == NO) {
        //Save Entity for everything
        self.localEntity.toDoTitle = self.titleField.text;
        self.localEntity.toDoDetails = self.detailTextView.text;
        self.localEntity.toDoDueDate = self.dueDatePicker.date;
        [self saveMyToDoEntity];
    }
    [self localNotification];
    self.center = [UNUserNotificationCenter currentNotificationCenter];
    //Remove Observer detect
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextViewTextDidEndEditingNotification object:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard:)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
    
    self.center = [UNUserNotificationCenter currentNotificationCenter];
    UIApplication.sharedApplication.applicationIconBadgeNumber = 0;

}

-(void)hideKeyboard:(UITapGestureRecognizer *)recognizer{
    [self.titleField resignFirstResponder];
    [self.detailTextView resignFirstResponder];
 
}

-(void) receiveMOC:(NSManagedObjectContext *)incomingMOC{
    self.managedObjectContext = incomingMOC;
    
}

-(void) receiveToDoEntity:(ToDoEntity *)incomingToDoEntity{
    self.localEntity = incomingToDoEntity;
}

- (IBAction)titleEndEdit:(id)sender {
    self.localEntity.toDoTitle = self.titleField.text;
    [self saveMyToDoEntity];
}

-(void)textViewDidEndEditing:(NSNotification *)notification{
    if ([notification object] == self){
        self.localEntity.toDoDetails = self.detailTextView.text;
        [self saveMyToDoEntity];
    }
}

- (IBAction)dateEndEdit:(id)sender {
    self.localEntity.toDoDueDate = self.dueDatePicker.date;
    [self saveMyToDoEntity];
}

-(void)saveMyToDoEntity{
    NSError *err;
    BOOL saveSuccess = [self.managedObjectContext save:&err];
    if(!saveSuccess){
        @throw [NSException exceptionWithName:NSGenericException reason:@"Cannot Save" userInfo:@{NSUnderlyingErrorKey:err}];
    }
}

- (IBAction)trashClicked:(id)sender {
    self.wasDeleted = YES;
    [self.managedObjectContext deleteObject:self.localEntity];
    [self saveMyToDoEntity];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)localNotification{
    
    
    //Set Notification content
    UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
    content.title = [NSString localizedUserNotificationStringForKey:@"Times up!" arguments:nil];
    content.body = [NSString localizedUserNotificationStringForKey:[NSString stringWithFormat:@"Your Setted reminder %@ is expired", self.localEntity.toDoTitle]
                                                         arguments:nil];
    
    content.sound = [UNNotificationSound defaultSound];
    content.categoryIdentifier = @"TIMER_EXPIRED";
    content.badge = @([[UIApplication sharedApplication] applicationIconBadgeNumber] + 1);
    
    // create trigger
    
    //    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [calendar setTimeZone:[NSTimeZone localTimeZone]];
    NSDate *setReminderTime = self.localEntity.toDoDueDate;
    
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear |  NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitTimeZone) fromDate: setReminderTime];
    //    NSDateComponentsFormatter *formatter = [NSDateComponentsFormatter localizedStringFromDateComponents:components unitsStyle:NSDateComponentsFormatterUnitsStyleShort];
    //    components.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    components.second = 0;
    
    NSLog(@"components: %@",components);//it indicates that the notif will be triggered today at 8PM and no
    UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:NO];
    
    
    // Create the request object.
    UNNotificationRequest* request = [UNNotificationRequest
                                      requestWithIdentifier:@"Calendar Alarm" content:content trigger:trigger];
    [_center addNotificationRequest:request withCompletionHandler:nil];

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
