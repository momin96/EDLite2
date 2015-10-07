//
//  MapGroupViewController.m
//  EDLite
//
//  Created by Nasirahmed on 07/10/15.
//  Copyright (c) 2015 Nasir. All rights reserved.
//

#import "MapGroupViewController.h"

@interface MapGroupViewController ()

@end

@implementation MapGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}



-(IBAction)tappedShowMasterView:(UIButton*)sender{
    if([_delegate respondsToSelector:@selector(showMasterView)])
        [_delegate showMasterView];
}

@end
