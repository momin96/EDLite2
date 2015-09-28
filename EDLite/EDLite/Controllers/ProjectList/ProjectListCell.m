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
#import "EDLDataManager.h"
@interface ProjectListCell()
@end

@implementation ProjectListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}


-(void)updateUIForConnection:(EDLConnection *)connection atIndexPath:(NSIndexPath *)indexPath{
    self.indexPath = indexPath;
    
    Project* projectInfo = connection.projectInfo;
    self.projectNameLabel.text = projectInfo.projectName;
    UIImage* thumbImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:projectInfo.thumbImage]]];
    self.thumbImageView.image = thumbImage;
}


-(void)updateProgressForConnection:(EDLConnection *)connection{
    switch (connection.connectionState) {
        case EDLConnectionRunning:
            _progressView.hidden = NO;
            _progressView.progress = connection.syncManager.progress;
            self.activityIndicator.hidden = NO;
            [self.activityIndicator startAnimating];
            self.noOfMaps.hidden = YES;
            self.noOfTickets.hidden = YES;
            break;
        case EDLConnectionOffline:
            [self.activityIndicator stopAnimating];
            self.activityIndicator.hidden = YES;
            break;
        case EDLConnectionCompleted:{
            [self.activityIndicator stopAnimating];
            self.activityIndicator.hidden = YES;
            // Calculate the number of Tickets and Maps
            [self countOfTicketAndMapsWithConnection:connection];
        }
            break;
        default:
            break;
    }
}

-(void)countOfTicketAndMapsWithConnection:(EDLConnection*)connection{
    EDLDataManager* dataManager = [EDLDataManager sharedDataManager];
    dataManager.database = connection.database;
    self.noOfMaps.hidden = NO;
    self.noOfTickets.hidden = NO;
    self.noOfTickets.text = [NSString stringWithFormat:@"%ld Tickets",[dataManager countOfTickets]];
    self.noOfMaps.text = [NSString stringWithFormat:@"%ld Maps",[dataManager countOfMaps]];

}



#pragma mark -- Target Action

-(IBAction)tappedControlStateButton:(UIButton*)sender{      // need lots of improvement, Have to strictly follow MVC pattern, 
    
    EDLConnection* connection = nil;
    if([_projectCellDelegate respondsToSelector:@selector(connectionAtIndexPath:)])
       connection = [_projectCellDelegate connectionAtIndexPath:self.indexPath];
        
    switch (connection.connectionState) {
        case EDLConnectionPause:
        case EDLConnectionStart:
        case EDLConnectionCompletedOffline:
        case EDLConnectionOffline:{  //Connection is OFF (Paused) Resume/Start code goes here.
            [self.controlStateButton setTitle:@"Pause" forState:UIControlStateNormal];
           if([_projectCellDelegate respondsToSelector:@selector(startSyncConnection:)])
               [_projectCellDelegate startSyncConnection:connection];
        }
            break;
        case EDLConnectionRunning:{    //Connection is ON, Pause Code goes here
            [self.controlStateButton setTitle:@"Resume" forState:UIControlStateNormal];
            if([_projectCellDelegate respondsToSelector:@selector(pauseSyncConnection:)])
                [_projectCellDelegate pauseSyncConnection:connection];
        }
            break;
        default:
            break;
    }
}

@end
