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
@interface TicketListViewController () <TicketListCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView* ticketTableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl* segmentationControl;

@property (nonatomic) NSArray* documentList;

@property (nonatomic) CBLLiveQuery* liveQuery;

@end

@implementation TicketListViewController

-(void)navigationView{
    UIBarButtonItem* rightBarButton =[[UIBarButtonItem alloc]initWithTitle:@"+"
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:@selector(tappedNewTicketButton)];
    
    [self.navigationItem setRightBarButtonItem:rightBarButton];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationView];
    [CRLoadingView loadingViewInView:self.view Title:@"Loading Tickets"];
    
    [self showActiveTickets];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.liveQuery stop];
    [self startLiveQuery];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -- Helper Method

-(void)showCompeletedTickets{
    [self showCompeletedArchivedTicketWithCompletionHandler:^(NSArray *documentList) {
        self.documentList = nil;
        self.documentList = documentList;
        [CRLoadingView removeView];
        [self.ticketTableView reloadData];
    }];
}

-(void)showActiveTickets{
    [self showActiveTicketsWithCompletionHandler:^(NSArray *documentList) {
        self.documentList = nil;
        self.documentList = documentList;
        [CRLoadingView removeView];
        [self.ticketTableView reloadData];
    }];
}

-(void)startLiveQuery{
    EDLDataManager* dataManager = [EDLDataManager sharedDataManager];
    self.liveQuery = [dataManager startLiveQuery:self.connection.database];
    
    [self.liveQuery addObserver:self forKeyPath:@"rows" options:0 context:NULL];
    [self.liveQuery start];
}

-(void)showCompeletedArchivedTicketWithCompletionHandler:(void(^)(NSArray* documentList))CompletionHandler{
    EDLDataManager* dataManager = [EDLDataManager sharedDataManager];
    NSArray* documentList = [dataManager completedArchivedTicketListView:YES inDatabase:self.connection.database];
    if(documentList)
        CompletionHandler(documentList);
}

-(void)showActiveTicketsWithCompletionHandler:(void(^)(NSArray* documentList))CompletionHandler{
    EDLDataManager* dataManager = [EDLDataManager sharedDataManager];
    NSArray* documentList = [dataManager completedArchivedTicketListView:NO inDatabase:self.connection.database];
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
    cell.delegate = self;
    cell.indexPath = indexPath;
    cell.ticketIDLabel.text = [ticket humanId];
    cell.ticketTitleLabel.text = [ticket title];
    cell.ticketDescriptionLabel.text = [ticket body];
    cell.ticketStatuslabel.text = [ticket status];
    [cell.ticketArchivedButton setBackgroundImage:[ticket getArchivedImage] forState:UIControlStateNormal];
    cell.ticketAttachmentImageView.hidden = ![ticket isAttachmentAvailable];
    return cell;
}

#pragma mark -- Target/Action

-(IBAction)tappedSegmentedControl:(UISegmentedControl *)sender {
    
    if(sender.selectedSegmentIndex == 0){//Active : Unarchived and nonCompleted Tickets
        [CRLoadingView loadingViewInView:self.view Title:@"Loading Active Ticket"];
        [self showActiveTickets];
    }
    else if (sender.selectedSegmentIndex == 1){//Completed : Archived and Completed
        [CRLoadingView loadingViewInView:self.view Title:@"Loading Completed Ticket"];
        [self showCompeletedTickets];
    }
}

-(void)tappedNewTicketButton{
    Ticket* ticket = [Ticket ticketInDatabase:self.connection.database];
    NSError* error;
    [ticket save:&error];
    if(!error)
        NSLog(@"New TicketCreated");
    else
        NSLog(@"Cannot create new Ticket");
}

-(IBAction)tappedShowMasterView:(UIButton*)sender{
    if([_delegate respondsToSelector:@selector(showMasterView)])
        [_delegate showMasterView];
}

#pragma mark -- KVO
-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context{
    if (object == self.liveQuery) {
        if(self.segmentationControl.selectedSegmentIndex == 1)
           [self showCompeletedTickets];
        else
            [self showActiveTickets];

        NSLog(@"Count Enumerator ; [%lu]",[self.liveQuery.rows count]);

        [self.ticketTableView reloadData];
    }
}

#pragma mark -- TicketCellDelegate Method
-(void)ticket:(TicketListCell *)ticketCell didTapTicketCellAtIndexPath:(NSIndexPath *)indexPath{
    NSError* error;
   Ticket* ticket = self.documentList[indexPath.row];
    if(ticket.archived)
       [ticket unarchive];
    else
        [ticket archive];
    [ticket save:&error];
    if(error)
        NSLog(@"cannot save ticket");
    else
        NSLog(@"Ticket archived");
    NSLog(@"Ticket cell [%@] at indexPath : [%ld]",ticketCell,(long)indexPath.row);
}

@end
