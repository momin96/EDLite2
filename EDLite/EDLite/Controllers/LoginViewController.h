//
//  LoginViewController.h
//  EDLite
//
//  Created by Nasirahmed on 12/09/15.
//  Copyright (c) 2015 Nasir. All rights reserved.
//

#import "ConnectionManager.h"
@class User;
@protocol LoginViewControllerDelegate <NSObject>

@optional
-(void)prepareConnectionWithUser:(User*)activeUser;

@end

@interface LoginViewController : UIViewController

@property (weak,nonatomic) id <LoginViewControllerDelegate> delegate;

@end
