//
//  MapGroupViewController.m
//  EDLite
//
//  Created by Nasirahmed on 07/10/15.
//  Copyright (c) 2015 Nasir. All rights reserved.
//

#import "MapGroupViewController.h"
#import "EDLMapGroup.h"

@interface MapGroupViewController ()
@property (weak, nonatomic) IBOutlet UITableView* tableView;
@property (assign, readonly) NSInteger countOfMapGroup;
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
    [dataManager mapGroupViewInDatabase:self.connection.database completionHandler:^(NSArray *mapGroupList) {
        self.tableView.hidden = NO;
        [CRLoadingView removeView];
        for (EDLMapGroup* mapGroup in mapGroupList) {
            NSLog(@"Map Group :%@",mapGroup.name);
        }
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
    return _countOfMapGroup=2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellID = @"GroupMapCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    return cell;
}

@end
