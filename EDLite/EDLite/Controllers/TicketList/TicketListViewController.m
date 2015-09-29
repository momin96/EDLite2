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
@interface TicketListViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView* ticketTableView;
@property (nonatomic) NSArray* documentList;
@end

@implementation TicketListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [CRLoadingView loadingViewInView:self.view Title:@"Loading Tickets"];
    
    [self downloadTicketsWithCompletionHandler:^(NSArray* documentList) {
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

-(void)downloadTicketsWithCompletionHandler:(void(^)(NSArray* documentList))CompletionHandler{
    CBLDatabase* database = self.connection.database;
    
    CBLView* ticketListView = [database viewNamed:@"_ticketListView"];
    ticketListView.documentType = kTicketType;
    if(!ticketListView.mapBlock){
        [ticketListView setMapBlock:MAPBLOCK({
            emit(doc[@"_id"],doc[@"_id"]);
        }) version:@"1.0"];
    }
    NSMutableArray* documentList = [[NSMutableArray alloc]init];
    CBLQuery* query = [ticketListView createQuery];
    [query runAsync:^(CBLQueryEnumerator * queryResult, NSError * error) {
        if(!error){
            for (CBLQueryRow* row in queryResult) {
                Ticket* ticket = [Ticket modelForDocument:row.document];
                [documentList addObject:ticket];
            }
        }
    }];
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
@end
