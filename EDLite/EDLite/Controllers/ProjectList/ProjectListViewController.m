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
#import "LoginViewController.h"
@interface ProjectListViewController () <LoginViewControllerDelegate>

@property (nonatomic) SyncManager* syncManager;

@property (weak, nonatomic) IBOutlet UITableView* projectTableView;

@end

@implementation ProjectListViewController

-(void)dealloc{
    NSLog(@"Dealloc ProjectViewController");
}


- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem* leftBarButton =[[UIBarButtonItem alloc]initWithTitle:@"logout"
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:@selector(tappedLogoutButton)];
    
    [self.navigationItem setLeftBarButtonItem:leftBarButton];
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"activeUser"]){
//        [self reloadProjects];
    }
    else{
        //Present Login View Controller
        LoginViewController* loginViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"LoginViewController"];
        loginViewController.delegate = self;
        [self presentViewController:loginViewController
                           animated:YES
                         completion:nil];
    }
    
}


-(void)tappedLogoutButton{
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"ProjectListViewController didReceiveMemoryWarning");
}

-(void)reloadProjects:(NSArray *)projectList{
    self.projectList =projectList;
    [self.projectTableView reloadData];
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
