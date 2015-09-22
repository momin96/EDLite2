//
//  EDLConnection.m
//  EDLite
//
//  Created by Nasirahmed on 16/09/15.
//  Copyright (c) 2015 Nasir. All rights reserved.
//

#import "EDLConnection.h"
#import "User.h"

@implementation EDLConnection

-(instancetype)initProjectWithSource:(NSURL*)source target:(NSString*)target{
    self = [super init];
    if(self){
        _source = source;
        _target = target;
        _database = [self databaseNameWithTarget:target];
    }
    return self;
}

-(CBLDatabase*)databaseNameWithTarget:(NSString*)databaseName{
    CBLManager *manager = [ConnectionManager sharedConnectionManager].manager;
    
    NSError* error;
    CBLDatabase* database = [manager databaseNamed:databaseName error:&error];
    if(!database){
        NSLog(@"Database creation failed [%@]",database);
        return nil;
    }
    return database;
}


-(instancetype)initWithProjectInfo:(Project *)projectInfo{
    self = [super init];
    if(self){
        _source = projectInfo.source;
        _target = projectInfo.target;
        _database = [self databaseNameWithTarget:projectInfo.target];
    }
    return  self;
}

//-(void)initReplicationWithDocIDs:(NSArray *)docIDs{
//    self.syncManager = [[SyncManager alloc]initReplicationWithURL:_source database:_database];
//    [self.syncManager startUserDocReplicationWithDocIDs:docIDs];
//}


@end
