//
//  TicketListViewController.m
//  EDLite
//
//  Created by Nasirahmed on 29/09/15.
//  Copyright (c) 2015 Nasir. All rights reserved.
//

#import "TicketListViewController.h"
#import "TicketListCell.h"
#import "Ticket.h"
@interface TicketListViewController ()
@property (weak, nonatomic) IBOutlet UITableView* ticketTableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl* segmentedControlButton;


@property (nonatomic) NSArray* documentList;
@end

@implementation TicketListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [CRLoadingView loadingViewInView:self.view Title:@"Loading Tickets"];
    
    [self downloadActiveTicketsWithCompletionHandler:^(NSArray* documentList) {
        if(documentList){
            self.documentList = documentList;
            [CRLoadingView removeView];
            [self.ticketTableView reloadData];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)downloadActiveTicketsWithCompletionHandler:(void(^)(NSArray* documentList))CompletionHandler{
    
    EDLDataManager* dataManager = [EDLDataManager sharedDataManager];
    NSArray* documentList = [dataManager activeTicketListView:self.connection.database];
    if (documentList) {
        CompletionHandler(documentList);
    }
}

-(void)downloadCompletedTicketsWithCompletionHandler:(void(^)(NSArray* documentList))CompletionHandler{
    EDLDataManager* dataManager = [EDLDataManager sharedDataManager];
    NSArray* documentList = [dataManager completedTicketListView:self.connection.database];
    if (documentList) {
        CompletionHandler(documentList);
    }
}

#pragma mark -- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.documentList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellIdentifier =  @"TicketListCell";
    TicketListCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    Ticket* ticket = self.documentList[indexPath.row];
    cell.ticketIDLabel.text = [ticket humanId];
    cell.ticketTitleLabel.text = [ticket title];
    cell.ticketDescriptionLabel.text = [ticket body];
    cell.ticketStatuslabel.text = [ticket status];
    return cell;
}

-(IBAction)tappedSegmentedControl:(UISegmentedControl *)sender {
    
    if(sender.selectedSegmentIndex == 0){//Active
        [CRLoadingView loadingViewInView:self.view Title:@"Loading Active Ticket"];
        [self downloadActiveTicketsWithCompletionHandler:^(NSArray *documentList) {
            self.documentList = nil;
            self.documentList = documentList;
            [CRLoadingView removeView];
            [self.ticketTableView reloadData];
        }];
    }
    
    else if (sender.selectedSegmentIndex == 1){//Completed
        [CRLoadingView loadingViewInView:self.view Title:@"Loading Completed Ticket"];

        [self downloadCompletedTicketsWithCompletionHandler:^(NSArray *documentList) {
            self.documentList = nil;
            self.documentList = documentList;
            [CRLoadingView removeView];
            [self.ticketTableView reloadData];
        }];
    }
}



@end
