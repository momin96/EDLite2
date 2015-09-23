//
//  SyncManager.m
//  EDLite
//
//  Created by Nasirahmed on 10/09/15.
//  Copyright (c) 2015 Nasir. All rights reserved.
//

#import "SyncManager.h"
#import "ProjectListCell.h"
@interface SyncManager()



@end


@implementation SyncManager

-(void)startUserDocReplicationWithDocIDs:(NSArray *)docIDs{
    
    self.pull = [self.database createPullReplication:self.replicationURL];
    //    self.push = [self.database createPushReplication:self.replicationURL];
    
    NSLog(@"Replication URL [%@]",self.replicationURL);
    
    self.pull.documentIDs = docIDs;
    
    self.pull.continuous = YES;
    //    self.push.continuous = YES;
    NSLog(@"pull status [%u]",self.pull.status);
    
    [self startSync];
}

-(instancetype)initSyncForConnection:(EDLConnection*)connection{
    self = [super init];
    if(self){
        _connection = connection;
    }
    return  self;
}

-(void)defineSync{
    CBLReplication* pull = [self.connection.database createPullReplication:self.connection.source];
    
    pull.continuous = YES;
    self.pull = pull;
    [self observeReplication:@[self.pull]];
    NSLog(@"pull [%@] and status [%u]",self.pull,self.pull.status);
    [self startSync];
}

-(void)observeReplication:(NSArray*)replications{
    for (CBLReplication* repl in replications) {
        [self listenToTeplication:repl];
    }
}

-(void)listenToTeplication:(CBLReplication*)repl{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(replicationProgress:)
                                                 name:kCBLReplicationChangeNotification
                                               object:repl];
}

-(void)replicationProgress:(NSNotificationCenter*)n{
    NSLog(@"pull [%@] and status [%u]",self.pull,self.pull.status);
    // First check whether replication is currently active:
    BOOL active = (self.pull.status == kCBLReplicationActive);
    double total;
    double completed;
    if (active) {
        double progress = 0.0;
        total =  self.pull.changesCount;
        completed = self.pull.completedChangesCount ;
        if (total > 0.0) {
            progress = completed / total;
        }
        _progress = progress;
    }
    
    if(self.pull.status ==  kCBLReplicationActive)
        [self.cell showSyncStatus:_progress];
    else if(self.pull.status == kCBLReplicationStopped)
        [self.cell stopSync];
    else if(self.pull.status == kCBLReplicationIdle)
        [self.cell hideCompletedSync];
    
    NSLog(@"SYNC: [%f /%f] pull status : [%u]",completed,total,self.pull.status);
}


-(void)startSync{
    [self.pull start];
//    [self.push start]
}

-(void)stopSync{
    [self.pull stop];
//    [self.push start]
}


// Need to cross verify its use.
-(instancetype)initReplicationWithURL:(NSURL*)url
                             database:(CBLDatabase*)database{
    if (self = [super init]) {
        _replicationURL = url;
        _database = database;
    }
    return self;
}

-(void)dealloc{
    NSLog(@"SyncManager class Deallocated");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kCBLReplicationChangeNotification object:nil];
}
@end
