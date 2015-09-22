//
//  ConnectionManager.m
//  EDLite
//
//  Created by Nasirahmed on 10/09/15.
//  Copyright (c) 2015 Nasir. All rights reserved.
//

#import "ConnectionManager.h"
#import "User.h"
@implementation ConnectionManager

-(void)dealloc{
    NSLog(@"Connection Manager Deallocated");
}

-(instancetype)init{
    self = [super init];
    if (self) {
        self.manager = [CBLManager sharedInstance];
        if(!self.manager){
            NSLog(@"Manager Creation fails");
            return nil;
        }
        else{
            NSLog(@"Manager Created : [%@]",self.manager); // Debuging
        }
    }
    return self;
}

+(ConnectionManager*)sharedConnectionManager{
    static ConnectionManager* sharedConnectionManager = nil;
    if(sharedConnectionManager == nil){
        
        sharedConnectionManager = [[ConnectionManager alloc]init];
    }
    return sharedConnectionManager;
}

-(CBLDatabase*)createDatabaseWithName:(NSString *)databaseName{
    NSError* error = nil;
    CBLDatabase* database = [self.manager databaseNamed:databaseName error:&error];
    if(!database){
        NSLog(@"Database creating Failed");
        return nil;
    }
    else{
        NSLog(@"Database created : [%@]",database);
    }
    return database;
}


//-(void)createConnectionForProject:(Project *)project{
//    EDLConnection* connection = [self connectinForProjectInfo:project];
////    [self addObserverForConnection:connection];
//    [self.connectionList addObject:connection];
//}

-(void)prepareConnectionWithContracts:(NSDictionary *)contractDictionary completionHandler:(void (^)(BOOL finished, NSArray* projectList))completionHandler{
    
    NSMutableArray* projectList = [[NSMutableArray alloc] initWithCapacity:0];
    NSArray* allContracts =  [contractDictionary allKeys];
    for (NSString* contractName in allContracts) {
        NSArray* projectKeys = [[[contractDictionary objectForKey:contractName] objectForKey:@"databases"] allKeys];
        
        for (NSString* projectInfo in projectKeys) {
            
            NSDictionary* projectInfoDict = [[[contractDictionary objectForKey:contractName] objectForKey:@"databases"] objectForKey:projectInfo];
            
            Project* project = [[Project alloc]initProjectWithDictionary:projectInfoDict databaseName:projectInfo];
            [projectList addObject:project];
            
        }   //end inner for-in loop
    }   //end outer for-in loop
    
    if([projectList count])
        completionHandler(YES,projectList);
    else
        completionHandler(NO,nil);
    
    [self _connectionForProjectList:projectList];
}

-(void)_connectionForProjectList:(NSArray*)projectList{
    
    self.connectionList = [[NSMutableArray alloc] init];
    for (Project* projectInfo in projectList) {
        EDLConnection* connection = [self connectinForProjectInfo:projectInfo];
        [self addObserverForConnection:connection];
        [self.connectionList addObject:connection];
    }
}


-(EDLConnection*)connectinForProjectInfo:(Project*)projectInfo{
    EDLConnection* connection = [[EDLConnection alloc] initWithProjectInfo:projectInfo];
    SyncManager* syncManager = [[SyncManager alloc] initSyncForConnection:connection];
    [syncManager defineSync];
    connection.syncManager = syncManager;
    return connection;
}


-(void)addObserverForConnection:(EDLConnection*)connection{
    [connection addObserver:self
                 forKeyPath:kEDLConnectionState
                    options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                    context:NULL];
}


-(User*)userProfile{
    
    NSError* error;
    NSString* userDoc = [USERDOC_PREFIX stringByAppendingString:self.loginEmail];
    CBLDatabase* db = [self.manager databaseNamed:USERS_DATABASE error:&error];
     CBLDocument* userDocument = [db documentWithID:userDoc];
    self.activeUser = [[User alloc]initUserWithDocument:userDocument];
    return self.activeUser;
}

@end
