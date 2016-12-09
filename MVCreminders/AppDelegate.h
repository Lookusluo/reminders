//
//  AppDelegate.h
//  MVCreminders
//
//  Created by Yazhong Luo on 12/7/16.
//  Copyright © 2016 Yazhong Luo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,UNUserNotificationCenterDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong,nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (readonly, strong,nonatomic) NSManagedObjectContext *managedObjectContext;

@property(readonly, strong,nonatomic) NSManagedObjectModel *managedObjectModel;

- (void)saveContext;
-(NSURL *)applicationDocumentsDirectory;

@end

