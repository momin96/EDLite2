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
    CBLView* countOfTicketsView = [self.database viewNamed:@"_countOfTicketsView"];
    countOfTicketsView.documentType = kTicketType;
    if(!countOfTicketsView.mapBlock){
        [countOfTicketsView setMapBlock:MAPBLOCK({
            emit(doc[@"_id"],@1);
        }) reduceBlock:REDUCEBLOCK({
            return  [CBLView totalValues:values];
        }) version:@"1.1"];
    }
    NSError* error;
    CBLQuery* query = [countOfTicketsView createQuery];
    CBLQueryEnumerator* queryResult =  [query run:&error];
    return  [[queryResult rowAtIndex:0].value integerValue];

}
-(NSInteger)countOfMaps{
    CBLView* countOfMapsView = [self.database viewNamed:@"_countOfMapsView"];
    countOfMapsView.documentType = kMapType;
    if(!countOfMapsView.mapBlock){
        [countOfMapsView setMapBlock:MAPBLOCK({
            emit(doc[@"_id"],@1);
        }) reduceBlock:REDUCEBLOCK({
            return [CBLView totalValues:values];
        }) version:@"1.0"];
    }
    NSError* error;
    CBLQuery* query = [countOfMapsView createQuery];
    CBLQueryEnumerator* queryResult =  [query run:&error];
    return [[queryResult rowAtIndex:0].value integerValue];
}

-(NSArray*)activeTicketListView:(CBLDatabase*)database{
    CBLView* activeTicketListView = [database viewNamed:@"_activeTicketListView"];
    activeTicketListView.documentType = kTicketType;
    if(!activeTicketListView.mapBlock){
        [activeTicketListView setMapBlock:MAPBLOCK({
            
            BOOL isArchived = doc[@"archived"] != [NSNull null];
            BOOL nonCompleted = ![[doc[@"state"][@"state"] lowercaseString] isEqualToString:@"completed"];
            
            if(isArchived && nonCompleted)
                emit(doc[@"_id"],doc[@"_id"]);
            
        }) version:@"1.3"];
    }
    NSMutableArray* documentList = [[NSMutableArray alloc]init];
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
    CBLView* completedTicketListView = [database viewNamed:@"_completedTicketListView"];
    completedTicketListView.documentType = kTicketType;
    if(!completedTicketListView.mapBlock){
        [completedTicketListView setMapBlock:MAPBLOCK({
            
            BOOL isCompleted = [[doc[@"state"][@"state"] lowercaseString] isEqualToString:@"completed"];
            
            if(isCompleted)
                emit(doc[@"_id"],doc[@"_id"]);
            
        }) version:@"1.2"];
    }
    NSMutableArray* documentList = [[NSMutableArray alloc]init];
    CBLQuery* query = [completedTicketListView createQuery];
    NSError * error;
    CBLQueryEnumerator * queryResult = [query run:&error];
    for (CBLQueryRow* row in queryResult) {
        Ticket* ticket = [Ticket modelForDocument:row.document];
        [documentList addObject:ticket];
    }
    return documentList;
}
@end
