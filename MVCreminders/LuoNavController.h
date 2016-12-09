//
//  LuoNavController.h
//  MVCreminders
//
//  Created by Yazhong Luo on 12/7/16.
//  Copyright © 2016 Yazhong Luo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MOCProtocol.h"

@interface LuoNavController : UINavigationController<MOCProtocol>

-(void) receiveMOC:(NSManagedObjectContext *)incomingMOC;
@end
