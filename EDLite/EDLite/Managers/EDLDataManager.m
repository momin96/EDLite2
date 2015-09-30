//
//  EDLDataManager.m
//  EDLite
//
//  Created by Nasirahmed on 28/09/15.
//  Copyright (c) 2015 Nasir. All rights reserved.
//

#import "EDLDataManager.h"
#import "Ticket.h"
@implementation EDLDataManager

+(EDLDataManager*)sharedDataManager{
    static EDLDataManager* sharedDataManager = nil;
    if(sharedDataManager == nil){
        sharedDataManager = [[EDLDataManager alloc]init];
    }
    return sharedDataManager;
}

-(NSInteger)countOfTickets{
    CBLView* countOfTicketsView = [ EDLViews countOfTicketsView:self.database];
    NSError* error;
    CBLQuery* query = [countOfTicketsView createQuery];
    CBLQueryEnumerator* queryResult =  [query run:&error];
    return  [[queryResult rowAtIndex:0].value integerValue];

}
-(NSInteger)countOfMaps{
    
    CBLView* countOfMapsView = [EDLViews countOfMapsView:self.database];
    
    NSError* error;
    CBLQuery* query = [countOfMapsView createQuery];
    CBLQueryEnumerator* queryResult =  [query run:&error];
    return [[queryResult rowAtIndex:0].value integerValue];
}



-(NSString*)projectDocumentID:(CBLDatabase*)database{
    CBLView* typeProjectView = [EDLViews typeProjectView:database];
    NSError* error;
    CBLQuery* query = [typeProjectView createQuery];
    CBLQueryEnumerator* result = [query run:&error];
    CBLQueryRow* row = [result rowAtIndex:0];
    NSLog(@"Project ID : [%@]",row.documentID);
    return row.documentID;
}

-(NSArray*)completedArchivedTicketListView:(BOOL)archivedCompleted inDatabase:(CBLDatabase*)database {
    
    NSMutableArray* documentList = [[NSMutableArray alloc] init];


    CBLView* completedArchivedTicketListView = [EDLViews completedArchivedTicketListView:database];
    NSError* error;
    CBLQuery* query = [completedArchivedTicketListView createQuery];

    query.startKey = (archivedCompleted) ?  kArchivedKey :  kUnarchivedKey ;
    query.endKey = (archivedCompleted) ?  kArchivedKey  :  kUnarchivedKey ;
//    query.startKey = (archivedCompleted) ? @[kArchivedKey,kCompletedStatus] : @[kUnarchivedKey, [NSNull null]];
//    query.endKey = (archivedCompleted) ? @[kArchivedKey,kCompletedStatus] : @[kUnarchivedKey, [NSNull null]];
    
    CBLQueryEnumerator* queryResult = [query run:&error];
    
    for (CBLQueryRow* row in queryResult) {
        Ticket* ticket = [Ticket modelForDocument:row.document];
        [documentList addObject:ticket];
    }
    return documentList;
}

-(CBLLiveQuery*)startLiveQuery:(CBLDatabase*)database{
    CBLView* liveQueryView = [EDLViews liveQueryView:database];
    
    CBLLiveQuery* liveQuery = [[liveQueryView createQuery] asLiveQuery];
    return  liveQuery;
}
@end
