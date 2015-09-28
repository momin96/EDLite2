//
//  ProjectListCell.h
//  EDLite
//
//  Created by Nasirahmed on 12/09/15.
//  Copyright (c) 2015 Nasir. All rights reserved.
//


@protocol ProjectListCellDelegate <NSObject>

@optional
-(EDLConnection*)connectionAtIndexPath:(NSIndexPath*)indexPath;
-(void)startSyncConnection:(EDLConnection*)connection;
-(void)pauseSyncConnection:(EDLConnection*)connection;

@end


@interface ProjectListCell : UITableViewCell

@property (weak, nonatomic) id <ProjectListCellDelegate> projectCellDelegate;

@property (weak, nonatomic) IBOutlet UIImageView* thumbImageView;
@property (weak, nonatomic) IBOutlet UILabel* projectNameLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView* activityIndicator;
@property (weak, nonatomic) IBOutlet UIProgressView* progressView;
@property (weak, nonatomic) IBOutlet UILabel* noOfTickets;
@property (weak, nonatomic) IBOutlet UILabel* noOfMaps;
@property (weak, nonatomic) IBOutlet UIButton* controlStateButton;

@property (nonatomic) NSIndexPath* indexPath;

-(void)updateUIForConnection:(EDLConnection*)connection atIndexPath:(NSIndexPath*)indexPath;
-(void)updateProgressForConnection:(EDLConnection*)connection;

@end
