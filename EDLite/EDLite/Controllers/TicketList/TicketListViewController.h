//
//  TicketListViewController.h
//  EDLite
//
//  Created by Nasirahmed on 29/09/15.
//  Copyright (c) 2015 Nasir. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TicketListViewControllerDelegate <NSObject>
@optional
-(void)showMasterView;

@end

@interface TicketListViewController : UIViewController
@property (nonatomic) EDLConnection* connection;
@property (weak, nonatomic) id <TicketListViewControllerDelegate> delegate;
@end
