//
//  ProjectListViewController.m
//  EDLite
//
//  Created by Nasirahmed on 10/09/15.
//  Copyright (c) 2015 Nasir. All rights reserved.
//

#import "ProjectListViewController.h"
#import "SyncManager.h"
#import "User.h"
#import "Project.h"
#import "ProjectListCell.h"
@interface ProjectListViewController ()

@property (nonatomic) SyncManager* syncManager;

@property (weak, nonatomic) IBOutlet UITableView* projectTableView;

@end

@implementation ProjectListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    ConnectionManager* connectionManager = [ConnectionManager sharedConnectionManager];
//    [connectionManager prepareConnectionWithContracts:self.contracts completionHandler:^(BOOL finished,NSArray* projectList) {
//        if (finished) {
//            self.projectList = projectList;
//            [self.projectTableView reloadData];
//        }
//    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"ProjectListViewController didReceiveMemoryWarning");
}

#pragma mark -- UITableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  [self.projectList count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* cellIdentifier = @"ProjectListCell";
    ProjectListCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.indexPath = indexPath;
    Project* project = self.projectList[indexPath.row];
    cell.project = project;
    
//    cell.projectNameLabel.text = project.projectName;
//    UIImage* thumbImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:project.thumbImage]]];
//    cell.thumbImageView.image = thumbImage;
//    ConnectionManager* connectionManager = [ConnectionManager sharedConnectionManager];
//    EDLConnection* connection = connectionManager.connectionList[indexPath.row];
//    cell.connection = connection;

    return cell;
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
