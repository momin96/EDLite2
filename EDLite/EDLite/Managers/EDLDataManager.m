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

-(NSArray*)ticketListView:(CBLDatabase*)database{
    CBLView* ticketListView = [database viewNamed:@"_ticketListView"];
    ticketListView.documentType = kTicketType;
    if(!ticketListView.mapBlock){
        [ticketListView setMapBlock:MAPBLOCK({
            emit(doc[@"_id"],doc[@"_id"]);
        }) version:@"1.0"];
    }
    NSMutableArray* documentList = [[NSMutableArray alloc]init];
    CBLQuery* query = [ticketListView createQuery];
    NSError * error;
    CBLQueryEnumerator * queryResult = [query run:&error];
    for (CBLQueryRow* row in queryResult) {
        Ticket* ticket = [Ticket modelForDocument:row.document];
        [documentList addObject:ticket];
    }
    
    return documentList;
}

@end
