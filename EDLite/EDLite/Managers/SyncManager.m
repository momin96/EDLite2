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
    
    CBLReplication* pull = [self.connection.database createPullReplication:self.connection.source];
    
    pull.documentIDs = docIDs;
    pull.continuous = YES;
    
    self.pull = pull;
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
    CBLReplication* push = [self.connection.database createPushReplication:self.connection.source];
    pull.continuous = YES;
    push.continuous = YES;
    self.pull = pull;
    self.push = push;
    [self observeReplication:@[self.pull,self.push]];
    NSLog(@"pull [%@] and status [%u]",self.pull,self.pull.status);
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

-(void)replicationProgress:(NSNotification*)n{
    CBLReplication* repl = n.object;

    NSLog(@"replication [%@] and status [%u]",repl,repl.status);
    // First check whether replication is currently active:
    CBLReplicationStatus status = self.pull.status;
    BOOL active = (self.pull.status == kCBLReplicationActive);
    double total;
    double completed;
    if (active) {
//        status = MAX(status, self.pull.status);
        double progress = 0.0;
        total =  self.pull.changesCount;
        completed = self.pull.completedChangesCount ;
        if (total > 0.0) {
            progress = completed / total;
        }
        _progress = progress;
    }
    [self.connection updateSyncStatus:status];
    NSLog(@"SYNC: [%f /%f] pull status : [%u]",completed,total,repl.status);
}


-(void)startSync{
    [self.pull start];
    [self.push start];
}

-(void)stopSync{
    [self.pull stop];
    [self.push stop];
}


-(void)dealloc{
    NSLog(@"SyncManager class Deallocated");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kCBLReplicationChangeNotification object:nil];
}
@end
