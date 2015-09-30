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


@property (nonatomic) CBLReplication* pull;
@property (nonatomic) CBLReplication* push;

@property(nonatomic, readonly) float progress;

@property (nonatomic, weak) EDLConnection* connection;

-(instancetype)initSyncForConnection:(EDLConnection*)connection;
-(void)startUserDocReplicationWithDocIDs:(NSArray*)docIDs;


-(void)defineSync;
-(void)startSync;
-(void)stopSync;

@end
