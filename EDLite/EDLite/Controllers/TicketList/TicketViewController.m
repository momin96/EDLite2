//
//  TicketViewController.m
//  EDLite
//
//  Created by Nasirahmed on 07/10/15.
//  Copyright (c) 2015 Nasir. All rights reserved.
//

#import "TicketViewController.h"
#import "TicketListViewController.h"
#import "MapGroupViewController.h"

@interface TicketViewController () <TicketListViewControllerDelegate,MapGroupViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView* masterView;

@property (nonatomic) TicketListViewController* ticketListViewController;
@property (nonatomic) MapGroupViewController* mapGroupViewController;

@end

@implementation TicketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTicketListViewController];
}


-(void)addTicketListViewController{
     self.ticketListViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"TicketListViewController"];
    self.ticketListViewController.connection = self.connection;
    self.ticketListViewController.delegate = self;
    [self addChildViewController:self.ticketListViewController];
    [self.childContainerView addSubview:self.ticketListViewController.view];
}


-(void)addMapGroupController{
    self.mapGroupViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"MapGroupViewController"];
    [self addChildViewController:self.mapGroupViewController];
    self.mapGroupViewController.delegate = self;
    [self.childContainerView addSubview:self.mapGroupViewController.view];
}


-(void)removeTicketListViewController{
    [self.ticketListViewController willMoveToParentViewController:self];
    [self.ticketListViewController.view removeFromSuperview];
    [self.ticketListViewController removeFromParentViewController];
    self.ticketListViewController = nil;
}
-(void)removeMapGroupController{
    [self.mapGroupViewController willMoveToParentViewController:self];
    [self.mapGroupViewController.view removeFromSuperview];
    [self.mapGroupViewController removeFromParentViewController];
    self.mapGroupViewController = nil;
}

-(void)showMasterView{
    [self.masterView bringSubviewToFront:self.childContainerView];
    [self.childContainerView addSubview:self.masterView];
    self.masterView.hidden = NO;
}

-(IBAction)tappedTicketButton:(UIButton*)sender{
    [self.masterView sendSubviewToBack:self.childContainerView];
    self.masterView.hidden = YES;
    [self removeMapGroupController];
    [self addTicketListViewController];
}

-(IBAction)tappedMapGroupButton:(UIButton*)sender{
    [self.masterView sendSubviewToBack:self.childContainerView];
    self.masterView.hidden = YES;
    [self removeTicketListViewController];
    [self addMapGroupController];
}


@end
