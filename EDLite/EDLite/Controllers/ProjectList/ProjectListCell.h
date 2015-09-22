//
//  ProjectListCell.h
//  EDLite
//
//  Created by Nasirahmed on 12/09/15.
//  Copyright (c) 2015 Nasir. All rights reserved.
//


@interface ProjectListCell : UITableViewCell

@property (nonatomic) CBLDatabase* database;
//@property (nonatomic) CBLReplication* pull;
@property (nonatomic) Project* project;
@property (nonatomic) NSIndexPath* indexPath;
@property (nonatomic) EDLConnection* connection;

@property (weak, nonatomic) IBOutlet UIImageView* thumbImageView;
@property (weak, nonatomic) IBOutlet UILabel* projectNameLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView* activityIndicator;
@property (weak, nonatomic) IBOutlet UIProgressView* progressView;
@property (weak, nonatomic) IBOutlet UILabel* noOfTickets;
@property (weak, nonatomic) IBOutlet UILabel* noOfMaps;
@property (weak, nonatomic) IBOutlet UIButton* controlStateButton;


-(void)showSyncStatus:(float)status;
-(void)hideCompletedSync;

-(void)stopSync;
@end
