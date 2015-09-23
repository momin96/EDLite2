//
//  SyncManager.h
//  EDLite
//
//  Created by Nasirahmed on 10/09/15.
//  Copyright (c) 2015 Nasir. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProjectListCell.h"
@interface SyncManager : NSObject

@property (nonatomic) ProjectListCell* cell;

@property (nonatomic) CBLDatabase* database;
@property (nonatomic) NSURL* replicationURL;

@property (nonatomic) CBLReplication* pull;
//@property (nonatomic) CBLReplication* push;

@property(nonatomic, readonly) float progress;

@property (nonatomic) EDLConnection* connection;

-(instancetype)initReplicationWithURL:(NSURL*)url database:(CBLDatabase*)database;
-(void)startUserDocReplicationWithDocIDs:(NSArray*)docIDs;


-(instancetype)initSyncForConnection:(EDLConnection*)connection;
-(void)defineSync;

-(void)startSync;
-(void)stopSync;

@end
