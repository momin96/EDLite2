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
    UIBarButtonItem* leftBarButton =[[UIBarButtonItem alloc]initWithTitle:@"Logout"
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:@selector(tappedLogoutButton)];
    
    [self.navigationItem setLeftBarButtonItem:leftBarButton];
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"activeUser"]){
        
    }
    else{
        //Present Login View Controller
        [self presentLoginViewController];
    }
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self registerObserver];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"ProjectListViewController didReceiveMemoryWarning");
}

-(void)registerObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateProgress:)
                                                 name:EDLSyncStateChangedNotification
                                               object:nil];
}

-(void)prepareConnectionWithUser:(User *)activeUser{
    NSDictionary* contracts = activeUser.contracts;
    
    ConnectionManager* connectionManager = [ConnectionManager sharedConnectionManager];
    [connectionManager prepareConnectionWithContracts:contracts completionHandler:^(BOOL finished, NSArray *projectList) {
        self.projectList = projectList;
        [self.projectTableView reloadData];
        [self initiateSyncConnection];
    }];
}

-(void)initiateSyncConnection{
    NSArray* connections = [ConnectionManager sharedConnectionManager].connectionList;
    for (EDLConnection* conn in connections) {
        [conn startSyncConnection];
    }

}

-(void)updateProgress:(NSNotification*)notification{
    EDLConnection* connection = notification.object;
    NSInteger index = [[ConnectionManager sharedConnectionManager].connectionList indexOfObject:connection];
    NSIndexPath* indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    ProjectListCell* cell = (ProjectListCell*)[self.projectTableView cellForRowAtIndexPath:indexPath];
    [cell updateProgressForConnection:connection];
}

#pragma mark -- UITableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  [self.projectList count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* cellIdentifier = @"ProjectListCell";
    ProjectListCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    EDLConnection* connection = [[ConnectionManager sharedConnectionManager].connectionList objectAtIndex:indexPath.row];
    [cell updateUIForConnection:connection atIndexPath:indexPath];
    
    return cell;
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


-(void)tappedLogoutButton{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"activeUser"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self presentLoginViewController];
}

-(void)presentLoginViewController{
    LoginViewController* loginViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"LoginViewController"];
    loginViewController.delegate = self;
    [self presentViewController:loginViewController
                       animated:YES
                     completion:nil];
}



@end
