//
//  TicketListViewController.m
//  EDLite
//
//  Created by Nasirahmed on 29/09/15.
//  Copyright (c) 2015 Nasir. All rights reserved.
//

#import "TicketListViewController.h"
#import "TicketListCell.h"
@interface TicketListViewController ()
@property (weak, nonatomic) IBOutlet UITableView* ticketTableView;
@end

@implementation TicketListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellIdentifier =  @"TicketListCell";
    TicketListCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    return cell;
}
@end
