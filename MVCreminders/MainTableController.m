//
//  MainTableController.m
//  MVCreminders
//
//  Created by Yazhong Luo on 12/7/16.
//  Copyright © 2016 Yazhong Luo. All rights reserved.
//

#import "MainTableController.h"
#import <CoreData/CoreData.h>
#import "ToDoEntity+CoreDataClass.h"
#import "MainTableCell.h"

@interface MainTableController ()<UITableViewDelegate,UITableViewDataSource,NSFetchedResultsControllerDelegate>
@property (strong,nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong,nonatomic) NSFetchedResultsController *resultsController;

@end

@implementation MainTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializedNSFetchedResultsControllerDelegate];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.resultsController.sections[section].numberOfObjects;
    }
    else
        return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

     MainTableCell*tableCell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (indexPath.section == 0) {
    ToDoEntity *entity = self.resultsController.sections[indexPath.section].objects[indexPath.row];
    [tableCell setInternalFields:entity];
    }
    else if (indexPath.section == 1) {
        tableCell.textLabel.text = @"TEST";
    }
    return tableCell;
}

#pragma mark - NSFetchedResultsControllerDelegate
-(void)initializedNSFetchedResultsControllerDelegate{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"ToDoEntity" inManagedObjectContext:self.managedObjectContext];//get ObjectContext back From CoreData
    
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"TRUEPREDICATE"];//filter, get everything for now, this means not grouping
    
    fetchRequest.sortDescriptors = @[[[NSSortDescriptor alloc]initWithKey:@"toDoDueDate" ascending:YES]];
    
    self.resultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    self.resultsController.delegate = self;
    
    NSError *err;
    BOOL fetchSucceeded = [self.resultsController performFetch:&err];
    if (!fetchSucceeded) {
        @throw  [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Couldn't fetch" userInfo:nil];
    }

}

-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView beginUpdates];//start update
}

-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath{//play animation by type
        switch (type) {
            case NSFetchedResultsChangeInsert:
                [[self tableView]insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
                break;
            case NSFetchedResultsChangeDelete:
                [[self tableView]deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
                break;
            case NSFetchedResultsChangeUpdate:{
                MainTableCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
                ToDoEntity *entity = [controller objectAtIndexPath:indexPath];
                [cell setInternalFields:entity];
                break;
            }
            case NSFetchedResultsChangeMove:
                [[self tableView] deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                [[self tableView] insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
                break;
        }
}

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView endUpdates];//end update
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    NSObject<MOCProtocol,HandleToDoEntity> *child = (id<MOCProtocol,HandleToDoEntity>)[segue destinationViewController];
    [child receiveMOC:self.managedObjectContext];
    
    ToDoEntity *entity;
      if ([segue.identifier isEqualToString:@"toCreate"]){
              entity = [NSEntityDescription insertNewObjectForEntityForName:@"ToDoEntity" inManagedObjectContext:self.managedObjectContext];
      }
      else if ([segue.identifier isEqualToString:@"toEdit"]){
          MainTableCell *source = (MainTableCell *)sender;
          entity = source.localToDoEntity;
      }
    [child receiveToDoEntity:entity];
}


-(void) receiveMOC:(NSManagedObjectContext *)incomingMOC{
    self.managedObjectContext = incomingMOC;
    
}

@end
