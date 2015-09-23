//
//  ProjectListCell.m
//  EDLite
//
//  Created by Nasirahmed on 12/09/15.
//  Copyright (c) 2015 Nasir. All rights reserved.
//

#import "ProjectListCell.h"
#import "ConnectionManager.h"
#import "SyncManager.h"

@interface ProjectListCell()
@end

@implementation ProjectListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}


//-(void)showSyncStatus:(float)status{
//    self.progressView.progress = status;
//    self.activityIndicator.hidden = NO;
//    [self.activityIndicator startAnimating];
//    self.noOfMaps.hidden = YES;
//    self.noOfTickets.hidden = YES;
//    self.controlStateButton.hidden = NO;   //If pull Replication is strated of in running, don't hide.
//    
//}
//
//-(void)hideCompletedSync{
//    [self.activityIndicator stopAnimating];
//    self.activityIndicator.hidden = YES;
//    
//    self.noOfMaps.hidden = NO;
//    self.noOfTickets.hidden = NO;
//    
//    self.controlStateButton.hidden = YES; //If Pull replication Completed then no need to show pause/resume button, just hide it.
//    self.noOfMaps.text = [NSString stringWithFormat:@"%lu Maps",(unsigned long)[self countOfMaps]];
//    self.noOfTickets.text = [NSString stringWithFormat:@"%lu Tickets",(unsigned long)[self countOfTickets]];
//    [self.progressView setProgressViewStyle:UIProgressViewStyleDefault];
//}
//
//-(void)stopSync{
//    [self.activityIndicator stopAnimating];
//    self.activityIndicator.hidden = YES;
//    self.noOfMaps.hidden = YES;
//    self.noOfTickets.hidden = YES;
//    self.controlStateButton.hidden = NO;
//}
//
//#pragma mark -- Count of Tickets and maps
//
//-(NSInteger)countOfTickets{
//    CBLView* countOfTicketsView = [self.connection.database viewNamed:@"_countOfTicketsView"];
//    countOfTicketsView.documentType = @"IB.EdBundle.Document.Ticket";
//    if(!countOfTicketsView.mapBlock){
//        [countOfTicketsView setMapBlock:MAPBLOCK({
//            emit(doc[@"_id"],@1);
//        }) reduceBlock:REDUCEBLOCK({
//            return  [CBLView totalValues:values];
//        }) version:@"1.1"];
//    }
//    NSError* error;
//    CBLQuery* query = [countOfTicketsView createQuery];
//    CBLQueryEnumerator* queryResult =  [query run:&error];
//    //Debugging
//    NSLog(@"Ticket pull [%@]: valeu [%@]",self.connection.syncManager.pull,[queryResult rowAtIndex:0].value);
//    return  [[queryResult rowAtIndex:0].value integerValue];
//}
//
//-(NSInteger)countOfMaps{
//    CBLView* countOfMapsView = [self.connection.database viewNamed:@"_countOfMapsView"];
//    countOfMapsView.documentType = @"IB.EdBundle.Document.Map";
//    if(!countOfMapsView.mapBlock){
//        [countOfMapsView setMapBlock:MAPBLOCK({
//            emit(doc[@"_id"],@1);
//        }) reduceBlock:REDUCEBLOCK({
//            return [CBLView totalValues:values];
//        }) version:@"1.0"];
//    }
//    NSError* error;
//    CBLQuery* query = [countOfMapsView createQuery];
//   CBLQueryEnumerator* queryResult =  [query run:&error];
//    //Debugging
//    NSLog(@"Map pull [%@]: value [%@]",self.connection.syncManager.pull,[queryResult rowAtIndex:0].value);
//    return [[queryResult rowAtIndex:0].value integerValue];
//}
//
//
//#pragma mark -- Target Action
//
//-(IBAction)tappedControlStateButton:(UIButton*)sender{
//    if([sender.titleLabel.text isEqualToString:@"Download"]){
//        ConnectionManager* connectionManager = [ConnectionManager sharedConnectionManager];
//        [connectionManager createConnectionForProject:self.project withIndexPath:self.indexPath];
//        EDLConnection* connection = [connectionManager.connectionDict objectForKey:self.indexPath];
//        self.connection = connection;
//        self.connection.syncManager.cell = self;
//        [self.controlStateButton setTitle:@"Pause" forState:UIControlStateNormal];
//    }
//    else{
//        if (self.connection.syncManager.pull.running) {    // If Pull replication is running and pause button pressed, Update title to Resume
//            [self.connection.syncManager stopSync];
//            [self.controlStateButton setTitle:@"Resume" forState:UIControlStateNormal];
//        }
//        else{
//            [self.connection.syncManager startSync];
//            [self.controlStateButton setTitle:@"Pause" forState:UIControlStateNormal];
//        }
//    }
//}

@end
