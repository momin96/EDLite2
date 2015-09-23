//
//  LoginViewController.m
//  EDLite
//
//  Created by Nasirahmed on 12/09/15.
//  Copyright (c) 2015 Nasir. All rights reserved.
//

#import "LoginViewController.h"
#import "SyncManager.h"
#import "User.h"
#import "Project.h"
#import "ProjectListViewController.h"
@interface LoginViewController ()

@property (nonatomic) NSString* loginEmail;
@property (nonatomic) User* currentUser;
@property (nonatomic) NSMutableArray* projectList;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self registerNotification];

    UIBarButtonItem* leftBarButton =[[UIBarButtonItem alloc]initWithTitle:@"Login"
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:@selector(tappedLeftNavigationItem)];
    
    [self.navigationItem setLeftBarButtonItem:leftBarButton];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"activeUser"]) {
        [self.navigationItem.leftBarButtonItem setTitle:@"Logout"];
        self.loginEmail = [[NSUserDefaults standardUserDefaults] objectForKey:@"activeUser"];
        [self prepareConnection];
    }
    else{
        [self.navigationItem.leftBarButtonItem setTitle:@"Login"];
        [self presentAlertController];
    }
    
}

-(void)registerNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(downloadContractsNotification:)
                                                 name:EDLContractsUpdateNotification
                                               object:nil ];
}

-(void)tappedLeftNavigationItem{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"activeUser"]) {
        [self presentAlertController];
    }
    else{
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"activeUser"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self.navigationItem.leftBarButtonItem setTitle:@"Login"];
        [CRLoadingView removeView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"LoginViewController didReceiveMemoryWarning");
}

-(void)prepareConnection{
    
    NSURL* syncURL = [NSURL URLWithString:[SERVER_URL stringByAppendingString:USERS_DATABASE]];
    NSString* docID = [USERDOC_PREFIX stringByAppendingString:self.loginEmail];
    
    ConnectionManager* connectionManager = [ConnectionManager sharedConnectionManager];
    CBLDatabase* database = [connectionManager createDatabaseWithName:USERS_DATABASE];
    SyncManager* syncManager = [[SyncManager alloc] initReplicationWithURL:syncURL database:database];
    [syncManager startUserDocReplicationWithDocIDs:@[docID]];
   
    self.currentUser = [[User alloc] initUserWithDocument:[database documentWithID:docID]];
    if(self.currentUser.contracts)
        [self loadProjectViewController];

}

-(void)loadProjectViewController{
    NSMutableArray* projectList = [[NSMutableArray alloc] init];
    NSArray* allContracts =  [self.currentUser.contracts allKeys];
    for (NSString* contractName in allContracts) {
        NSArray* projectKeys = [[[self.currentUser.contracts  objectForKey:contractName] objectForKey:@"databases"] allKeys];
        
        for (NSString* projectInfo in projectKeys) {
            
            NSDictionary* projectInfoDict = [[[self.currentUser.contracts  objectForKey:contractName] objectForKey:@"databases"] objectForKey:projectInfo];
            Project* project = [[Project alloc]initProjectWithDictionary:projectInfoDict databaseName:projectInfo];
            [projectList addObject:project];
        }   //end inner for-in loop
    }   //end outer for-in loop

    if([projectList count]){
        [CRLoadingView removeView];
        ProjectListViewController* projectListViewController = [[self storyboard]instantiateViewControllerWithIdentifier:@"ProjectListViewController"];
        projectListViewController.projectList = projectList;
        [self.navigationController pushViewController:projectListViewController animated:YES];

    }
}

-(void)downloadContractsNotification:(NSNotification*)notification{
    self.currentUser.contracts = notification.userInfo;
    [self loadProjectViewController];
}

-(void)presentAlertController{
    
    __weak typeof(self) weakSelf = self;
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"EDLite"
                                                                             message:@"Enter Email ID"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.text = @"nasir.ahmed@mobinius.com";
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:NULL];
    UIAlertAction *loginAction =[UIAlertAction actionWithTitle:@"Login" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [CRLoadingView loadingViewInView:self.view Title:@"Loggin..."];
        UITextField* textField = alertController.textFields[0];
        self.loginEmail = textField.text;
        [[NSUserDefaults standardUserDefaults] setValue:self.loginEmail forKey:@"activeUser"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self.navigationItem.leftBarButtonItem setTitle:@"Logout"];
        [weakSelf prepareConnection];
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:loginAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}



@end
