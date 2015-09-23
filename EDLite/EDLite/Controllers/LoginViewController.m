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
@property (nonatomic) User* activeUser;

@end

@implementation LoginViewController

-(void)dealloc{
    NSLog(@"Dealloc LoginViewViewController");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self registerNotification];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self presentAlertController];
}

-(void)registerNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(downloadContractsNotification:)
                                                 name:EDLContractsUpdateNotification
                                               object:nil ];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"LoginViewController didReceiveMemoryWarning");
}

-(void)prepareUserDocConnection{
    
    NSString* docID = [USERDOC_PREFIX stringByAppendingString:self.loginEmail];
    ConnectionManager* connectionManager = [ConnectionManager sharedConnectionManager];
    CBLDocument* userDocID = [connectionManager replicateUserDocWithDocID:docID];
    self.activeUser = [[User alloc] initUserWithDocument:userDocID];
    if(self.activeUser){
        [[NSUserDefaults standardUserDefaults] setObject:self.activeUser.name forKey:@"activeUser"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self loadProjectViewController];
    }
//    else{
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"activeUser"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//    }
    


}

-(void)loadProjectViewController{
    if([_delegate respondsToSelector:@selector(prepareConnectionWithUser:)])
        [_delegate prepareConnectionWithUser:self.activeUser];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)downloadContractsNotification:(NSNotificationCenter*)notification{
//    self.currentUser.contracts = notification.userInfo;
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
        [weakSelf prepareUserDocConnection];
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:loginAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}



@end
