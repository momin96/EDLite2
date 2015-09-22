//
//  EDLConnection.h
//  EDLite
//
//  Created by Nasirahmed on 16/09/15.
//  Copyright (c) 2015 Nasir. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Project.h"

@class SyncManager;
@interface EDLConnection : NSObject

@property (nonatomic) CBLDatabase* database;
@property (nonatomic) Project* projectInfo;
@property (nonatomic) SyncManager* syncManager;

@property (nonatomic) NSURL* source;
@property (nonatomic) NSString* target;

@property (assign) EDLConnectionState connectionState;


-(instancetype)initProjectWithSource:(NSURL*)source target:(NSString*)target;


-(instancetype)initWithProjectInfo:(Project*)projectInfo;
@end
