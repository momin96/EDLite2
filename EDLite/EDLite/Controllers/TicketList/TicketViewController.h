//
//  TicketViewController.h
//  EDLite
//
//  Created by Nasirahmed on 07/10/15.
//  Copyright (c) 2015 Nasir. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TicketViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView* childContainerView;

@property (nonatomic) EDLConnection* connection;
@end
