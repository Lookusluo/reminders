//
//  MOCProtocol.h
//  MVCreminders
//
//  Created by Yazhong Luo on 12/7/16.
//  Copyright © 2016 Yazhong Luo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MOCProtocol <NSObject>

-(void) receiveMOC:(NSManagedObjectContext *)incomingMOC;

@end
