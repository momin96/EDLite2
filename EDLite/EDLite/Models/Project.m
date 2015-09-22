//
//  Project.m
//  EDLite
//
//  Created by Nasirahmed on 11/09/15.
//  Copyright (c) 2015 Nasir. All rights reserved.
//

#import "Project.h"

@implementation Project

//@synthesize archived,favorite,location,projectName,remoteLink,roles,thumbImage,databaseName;

-(instancetype)initProjectWithDictionary:(NSDictionary *)projectInfoDict databaseName:(NSString *)dbName{
 
    _archived = projectInfoDict[@"archived"];
    _favorite = projectInfoDict[@"favorite"];
    _location = projectInfoDict[@"location"];
    _projectName = projectInfoDict[@"projectName"];
    _remoteLink = projectInfoDict[@"remoteLink"];
    _roles = projectInfoDict[@"roles"];
    _thumbImage = projectInfoDict[@"thumbImage"];
    _databaseName = dbName;
    _source = [NSURL URLWithString:projectInfoDict[@"remoteLink"]];
    _target = dbName;
    return self;
}

@end
