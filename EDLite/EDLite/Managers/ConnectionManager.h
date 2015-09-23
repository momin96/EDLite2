//
//  ConnectionManager.h
//  EDLite
//
//  Created by Nasirahmed on 10/09/15.
//  Copyright (c) 2015 Nasir. All rights reserved.
//

#import "EDLConnection.h"

@class User;
@interface ConnectionManager : NSObject

@property (nonatomic) CBLManager* manager;
@property (nonatomic) CBLDatabase* database;
@property (nonatomic) NSMutableArray* connectionList;
@property (nonatomic) NSMutableDictionary* connectionDict;


@property (nonatomic) User* activeUser;
@property (nonatomic) NSString* loginEmail;


+(ConnectionManager*)sharedConnectionManager;

-(CBLDatabase*)createDatabaseWithName:(NSString*)databaseName;

-(void)prepareConnectionWithContracts:(NSDictionary*)contractDictionary completionHandler:(void(^)(BOOL finished, NSArray* projectList))completionHandler;


-(void)createConnectionForProject:(Project*)project withIndexPath:(NSIndexPath*)indexPath;



@end
