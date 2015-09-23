//
//  LoginViewController.h
//  EDLite
//
//  Created by Nasirahmed on 12/09/15.
//  Copyright (c) 2015 Nasir. All rights reserved.
//

#import "ConnectionManager.h"

@protocol LoginViewControllerDelegate <NSObject>

@optional
-(void)reloadProjects:(NSArray*)projectList;

@end

@interface LoginViewController : UIViewController

@property (weak,nonatomic) id <LoginViewControllerDelegate> delegate;

@end
