//
//  MainTableController.h
//  MVCreminders
//
//  Created by Yazhong Luo on 12/7/16.
//  Copyright © 2016 Yazhong Luo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MOCProtocol.h"
#import "HandleToDoEntity.h"
@interface MainTableController : UITableViewController<MOCProtocol>

- (void)receiveMOC:(NSManagedObjectContext *)incomingMOC;

@end
