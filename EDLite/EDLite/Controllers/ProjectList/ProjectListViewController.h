//
//  ProjectListViewController.h
//  EDLite
//
//  Created by Nasirahmed on 10/09/15.
//  Copyright (c) 2015 Nasir. All rights reserved.
//

#import "ConnectionManager.h"

@interface ProjectListViewController : UIViewController

@property (nonatomic) NSArray* projectList;


-(void)reloadProjects;
@end
