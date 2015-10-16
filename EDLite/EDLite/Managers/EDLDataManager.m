//
//  EDLDataManager.m
//  EDLite
//
//  Created by Nasirahmed on 28/09/15.
//  Copyright (c) 2015 Nasir. All rights reserved.
//

#import "EDLDataManager.h"
#import "Ticket.h"
#import "EDLMapGroup.h"
#import "EDLMap.h"
@implementation EDLDataManager

+(EDLDataManager*)sharedDataManager{
    static EDLDataManager* sharedDataManager = nil;
    if(sharedDataManager == nil){
        sharedDataManager = [[EDLDataManager alloc]init];
    }
    return sharedDataManager;
}

-(NSInteger)countOfTickets{
    CBLView* countOfTicketsView = [self.database existingViewNamed:@"_countOfTicketsView"];
    NSError* error;
    CBLQuery* query = [countOfTicketsView createQuery];
    CBLQueryEnumerator* queryResult =  [query run:&error];
    return  [[queryResult rowAtIndex:0].value integerValue];

}
-(NSInteger)countOfMaps{
    
    CBLView* countOfMapsView = [self.database existingViewNamed:@"_countOfMapsView"];
    
    NSError* error;
    CBLQuery* query = [countOfMapsView createQuery];
    CBLQueryEnumerator* queryResult =  [query run:&error];
    return [[queryResult rowAtIndex:0].value integerValue];
}


-(NSString*)projectDocumentID:(CBLDatabase*)database{
    CBLView* typeProjectView = [database existingViewNamed:@"_typeProjectView"];
    NSError* error;
    CBLQuery* query = [typeProjectView createQuery];
    CBLQueryEnumerator* result = [query run:&error];
    CBLQueryRow* row = [result rowAtIndex:0];
    NSLog(@"Project ID : [%@]",row.documentID);
    return row.documentID;
}

-(NSArray*)completedArchivedTicketListView:(BOOL)archivedCompleted inDatabase:(CBLDatabase*)database {
    
    NSMutableArray* documentList = [[NSMutableArray alloc] init];

    CBLView* completedArchivedTicketListView = [database existingViewNamed:@"_completedArchivedTicketView"];
    NSError* error;
    CBLQuery* query = [completedArchivedTicketListView createQuery];
    
    query.startKey = (archivedCompleted) ?  kCompletedStatus :  kNonCompletedStatus ;
    query.endKey = (archivedCompleted) ?   kCompletedStatus :  kNonCompletedStatus ;
    
    query.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"value" ascending:NO]];//Sorting based on title of Ticket wich is emited in value for emit function. it is slow as compared to by-key sort.
    
    query.limit = 15;
    
    CBLQueryEnumerator* queryResult = [query run:&error];
    
    for (CBLQueryRow* row in queryResult) {
        Ticket* ticket = [Ticket modelForDocument:row.document];
        [documentList addObject:ticket];
    }
    return documentList;
}

-(CBLLiveQuery*)startLiveQuery:(CBLDatabase*)database{
    CBLView* liveQueryView = [database existingViewNamed:@"_liveQueyView"];
    
    CBLLiveQuery* liveQuery = [[liveQueryView createQuery] asLiveQuery];
    return  liveQuery;
}

-(void)mapGroupViewInDatabase:(CBLDatabase*)database
            completionHandler:(void(^)(NSDictionary* mapGroupDict))completionHandler{
    CBLView* mapGroupView = [database existingViewNamed:@"_mapGroupView"];
    CBLQuery* query = [mapGroupView createQuery];
    NSError *error;
    NSString* projectID = [self projectDocumentID:database];
    query.startKey = @[projectID];
    query.endKey = @[projectID,@{}];
    query.groupLevel = 3;
    
    CBLQueryEnumerator *results =[query run:&error];
    
    NSMutableArray* allMapGroup = [[NSMutableArray alloc]init];
    
    for (CBLQueryRow* row in results) {
        EDLMapGroup* mapGroup = [EDLMapGroup new];
        mapGroup.name = row.key1;
        [allMapGroup addObject:mapGroup];
    }
   NSArray* groupList = [self mapGroupWithMapArray:allMapGroup];
    NSDictionary* mapDict = [self addMapGroupList:groupList inDatabase:database];
    if(mapDict)
        completionHandler(mapDict);
}

//This code is piece of junk, Soon it ll be improved using CBLQuery properties
-(NSArray*)mapGroupWithMapArray:(NSArray*)mapList{
    
    NSMutableArray* groupList = [[NSMutableArray alloc] init];
    for (EDLMapGroup *group in mapList) {
        if (![groupList containsObject:group.name])
            [groupList addObject:group.name];
    }
    return groupList;
}


-(NSDictionary*)addMapGroupList:(NSArray*)groupList inDatabase:(CBLDatabase*)database{
   CBLQuery* query = [[database existingViewNamed:@"_mapGroupView"] createQuery];
    NSError *error;
    NSString* projectID = [self projectDocumentID:database];
    NSMutableDictionary* mapDict = [[NSMutableDictionary alloc] init];
    for (NSString* group in groupList) {
        query.startKey = @[projectID, group];
        query.endKey =  @[projectID, group,@{}];
        query.mapOnly = YES;
        NSMutableArray* mapList = [[NSMutableArray alloc] init];
        CBLQueryEnumerator* result = [query run:&error];
        for (CBLQueryRow* row in result) {
            EDLMap* map = [EDLMap modelForDocument:row.document];
            [mapList addObject:map];
            NSLog(@"Row keys : [%@]",row.key);
        }
        [mapDict setObject:mapList forKey:group];
    }
    NSLog(@"Map Dict [%@]",mapDict);
    return mapDict;
}

@end
