//
//  ConnectionManager.h
//  EDLite
//
//  Created by Nasirahmed on 10/09/15.
//  Copyright (c) 2015 Nasir. All rights reserved.
//

#import "EDLConnection.h"

@interface ConnectionManager : NSObject

@property (nonatomic) CBLManager* manager;
@property (nonatomic) CBLDatabase* database;
@property (nonatomic) NSMutableDictionary* connectionDict;

//@property (nonatomic) NSMutableArray* connectionList;



+(ConnectionManager*)sharedConnectionManager;

-(CBLDatabase*)createDatabaseWithName:(NSString*)databaseName;

-(void)createConnectionForProject:(Project*)project withIndexPath:(NSIndexPath*)indexPath;



@end
