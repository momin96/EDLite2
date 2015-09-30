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

-(NSArray*)activeTicketListView:(CBLDatabase*)database{
    NSMutableArray* documentList = [[NSMutableArray alloc]init];

    CBLView* activeTicketListView = [EDLViews activeTicketListView:database];
    
    CBLQuery* query = [activeTicketListView createQuery];
    NSError * error;
    CBLQueryEnumerator * queryResult = [query run:&error];
    for (CBLQueryRow* row in queryResult) {
        Ticket* ticket = [Ticket modelForDocument:row.document];
        [documentList addObject:ticket];
    }
    return documentList;
}


-(NSArray*)completedTicketListView:(CBLDatabase*)database{
    NSMutableArray* documentList = [[NSMutableArray alloc]init];
    
    CBLView* completedTicketListView = [EDLViews completedTicketListView:database];
    
    CBLQuery* query = [completedTicketListView createQuery];
    NSError * error;
    CBLQueryEnumerator * queryResult = [query run:&error];
    for (CBLQueryRow* row in queryResult) {
        Ticket* ticket = [Ticket modelForDocument:row.document];
        [documentList addObject:ticket];
    }
    return documentList;
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
    NSMutableArray* unarchiveTickets = [[NSMutableArray alloc] init];
    NSMutableArray* archiveTickets = [[NSMutableArray alloc] init];

    CBLView* completedArchivedTicketListView = [EDLViews completedArchivedTicketListView:database];
    NSError* error;
    CBLQuery* query = [completedArchivedTicketListView createQuery];
    CBLQueryEnumerator* queryResult = [query run:&error];
    
    for (CBLQueryRow* row in queryResult) {
        Ticket* ticket = [Ticket modelForDocument:row.document];
        
        if ([row.key0 isEqualToString:kUnarchivedKey] && ![row.value isEqualToString:@"completed"])
            [unarchiveTickets addObject:ticket];
        else
            [archiveTickets addObject:ticket];
    }
    return  archivedCompleted ? archiveTickets : unarchiveTickets;
}

-(CBLLiveQuery*)startLiveQuery:(CBLDatabase*)database{
    CBLView* liveQueryView = [EDLViews liveQueryView:database];
    
    CBLLiveQuery* liveQuery = [[liveQueryView createQuery] asLiveQuery];
    return  liveQuery;
}
@end
