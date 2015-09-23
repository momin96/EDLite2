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


-(instancetype)initUserDocWithDatabaseName:(NSString*)databaseName syncURL:(NSURL*)syncURL{
    self = [super init];
    if(self){
        _source = syncURL;
        _target = databaseName;
        _database = [self databaseNameWithTarget:databaseName];
    }
    return self;
}

@end
