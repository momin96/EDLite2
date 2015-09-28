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
        _connectionState = EDLConnectionStart;
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

-(void)setCblStatus:(CBLReplicationStatus)cblStatus{
    if (_cblStatus != cblStatus) {
        _cblStatus = cblStatus;
    }
}

-(void)updateSyncStatus:(CBLReplicationStatus)cblStatus{
    switch (cblStatus) {
        case kCBLReplicationStopped:
            break;
            
        case kCBLReplicationOffline:
            self.connectionState = EDLConnectionOffline;
            break;
            
        
         case kCBLReplicationIdle:
            self.connectionState = EDLConnectionCompleted;
            break;
            
        case kCBLReplicationActive:
            if (_connectionState == EDLConnectionCompletedOffline) {
                _connectionState = EDLConnectionCompleted;
            }else{
                self.connectionState = (_connectionState == EDLConnectionCompleted) ?
                EDLConnectionPause : EDLConnectionRunning;
            }
            break;
        default:
            break;
    }
    self.cblStatus = cblStatus;
}

#pragma mark -- Start/Stop/Pause/Resume Connection

-(void)startSyncConnection{
    [self.syncManager startSync];
    self.cblStatus = kCBLReplicationStopped;
    _connectionState = EDLConnectionRunning;
}

-(void)stopSyncConnection{
    [self.syncManager stopSync];
    _connectionState = EDLConnectionPause;
}

-(void)pauseSyncConnection{
    _connectionState = EDLConnectionPause;
    [self.syncManager stopSync];
}

-(void)resumeSyncConnection{
    [self startSyncConnection];
}

@end
