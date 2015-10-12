//
//  MapGroupDetailViewController.m
//  EDLite
//
//  Created by Nasirahmed on 12/10/15.
//  Copyright © 2015 Nasir. All rights reserved.
//

#import "MapGroupDetailViewController.h"
#import "EDLSingleMapsCell.h"
@interface MapGroupDetailViewController ()
@property (weak, nonatomic) IBOutlet UITableView* tableView;
@property (nonatomic) NSArray* mapList;
@end

@implementation MapGroupDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:self.groupName];
    self.mapList = [self.mapGroupDict objectForKey:self.groupName];
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.mapList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellID = @"mapCell";
    EDLSingleMapsCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.mapNameLabel.text = self.mapList[indexPath.row];
    return cell;
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
