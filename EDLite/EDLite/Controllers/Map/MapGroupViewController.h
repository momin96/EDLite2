//
//  MapGroupViewController.h
//  EDLite
//
//  Created by Nasirahmed on 07/10/15.
//  Copyright (c) 2015 Nasir. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MapGroupViewControllerDelegate <NSObject>
@optional
-(void)showMasterView;

@end

@interface MapGroupViewController : UIViewController
@property (weak, nonatomic) id <MapGroupViewControllerDelegate> delegate;
@end
