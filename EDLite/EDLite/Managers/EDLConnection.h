//
//  EDLConnection.h
//  EDLite
//
//  Created by Nasirahmed on 16/09/15.
//  Copyright (c) 2015 Nasir. All rights reserved.
//

#import "Project.h"

@class SyncManager;
@interface EDLConnection : NSObject

@property (nonatomic) Project* projectInfo;
@property (nonatomic) SyncManager* syncManager;

@property (nonatomic) NSURL* source;
@property (nonatomic) NSString* target;
@property (nonatomic) CBLDatabase* database;
@property (nonatomic, assign) EDLConnectionState connectionState;

@property (nonatomic) CBLReplicationStatus cblStatus;

-(instancetype)initWithProjectInfo:(Project*)projectInfo;
-(instancetype)initUserDocWithDatabaseName:(NSString*)databaseName syncURL:(NSURL*)syncURL;

-(void)updateSyncStatus:(CBLReplicationStatus)status;

-(void)startSyncConnection;
-(void)stopSyncConnection;
-(void)pauseSyncConnection;
-(void)resumeSyncConnection;

@end
