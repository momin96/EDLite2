//
//  MapGroupViewController.m
//  EDLite
//
//  Created by Nasirahmed on 07/10/15.
//  Copyright (c) 2015 Nasir. All rights reserved.
//

#import "MapGroupViewController.h"
#import "EDLMapGroup.h"
#import "EDLMapCell.h"
@interface MapGroupViewController ()
@property (weak, nonatomic) IBOutlet UITableView* tableView;
@property (nonatomic) NSDictionary* mapGroupDict;
@end

@implementation MapGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.hidden = YES;
    [CRLoadingView loadingViewInView:self.view Title:@"Loading Map Groups"];
    [self showMapGroups];
}

-(void)showMapGroups{
    EDLDataManager* dataManager = [EDLDataManager sharedDataManager];
    [dataManager mapGroupViewInDatabase:self.connection.database completionHandler:^(NSDictionary* mapGroupDict) {
        self.tableView.hidden = NO;
        [CRLoadingView removeView];
        self.mapGroupDict = mapGroupDict;
    }];
}

-(void)dealloc{
    NSLog(@"Dealloc of MapGroupViewController");
}

-(IBAction)tappedShowMasterView:(UIButton*)sender{
    if([_delegate respondsToSelector:@selector(showMasterView)])
        [_delegate showMasterView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.mapGroupDict allKeys] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellID = @"GroupMapCell";
    EDLMapCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    NSArray* mapsList = [self.mapGroupDict allKeys];
    cell.mapGroup.text = mapsList[indexPath.row];
    cell.countOfMaps.text = [NSString stringWithFormat:@"%u maps",(unsigned)[[self.mapGroupDict objectForKey:mapsList[indexPath.row]] count]];
    return cell;
}

@end
