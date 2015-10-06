//
//  EDLViews.m
//  EDLite
//
//  Created by Nasirahmed on 29/09/15.
//  Copyright (c) 2015 Nasir. All rights reserved.
//

#import "EDLViews.h"

@implementation EDLViews


+(CBLView*)countOfMapsView:(CBLDatabase*)database{
    CBLView* countOfMapsView = [database viewNamed:@"_countOfMapsView"];
    countOfMapsView.documentType = kMapType;
    if(!countOfMapsView.mapBlock){
        [countOfMapsView setMapBlock:MAPBLOCK({
            emit(doc[@"_id"],@1);
        }) reduceBlock:REDUCEBLOCK({
            return [CBLView totalValues:values];
        }) version:@"1.0"];
    }
    return countOfMapsView;
}

+(CBLView*)countOfTicketsView:(CBLDatabase*)database{
    
    CBLView* countOfTicketsView = [database viewNamed:@"_countOfTicketsView"];
    countOfTicketsView.documentType = kTicketType;
    if(!countOfTicketsView.mapBlock){
        [countOfTicketsView setMapBlock:MAPBLOCK({
            emit(doc[@"_id"],@1);
        }) reduceBlock:REDUCEBLOCK({
            return  [CBLView totalValues:values];
        }) version:@"1.1"];
    }
    return countOfTicketsView;
}

+(CBLView*)typeProjectView:(CBLDatabase*)database{
    CBLView* typeProjectView = [database viewNamed:@"_typeProjectView"];
    typeProjectView.documentType = kProjectDocumentType;
    [typeProjectView setMapBlock:MAPBLOCK({
        emit(doc[@"_id"],doc[@"_id"]);
    }) version:@"1.0"];
    return typeProjectView;
}

+(CBLView*)completedArchivedTicketListView:(CBLDatabase*)database{
    CBLView* completedArchivedTicketView = [database viewNamed:@"_completedArchivedTicketView"];
    completedArchivedTicketView.documentType = kTicketType;
    if (!completedArchivedTicketView.mapBlock) {
        [completedArchivedTicketView setMapBlock:MAPBLOCK({
            
//            NSString* archived = (doc[@"archived"] == [NSNull null]) ? kUnarchivedKey :  kArchivedKey ;
            NSString* status = [doc[@"state"][@"state"] isEqualToString:kCompletedStatus] ? kCompletedStatus : kNonCompletedStatus;
//            emit(@[archived,status],doc[@"_id"]]);
            emit(status,doc[@"content"][@"title"]);
            
        }) version:@"1.7"];
    }
    return completedArchivedTicketView;
}

+(CBLView*)liveQueryView:(CBLDatabase*)database{
    CBLView* liveQueryView = [database viewNamed:@"_liveQueyView"];
    liveQueryView.documentType = kTicketType;
    if (!liveQueryView.mapBlock) {
        [liveQueryView setMapBlock:MAPBLOCK({
            emit(@[doc[@"state"][@"state"],doc[@"archived"]],@"LiveQuery"); // LiveQuery string in Value is just junk, will replace it with proper attribute
        }) version:@"1.4"];
    }
    return liveQueryView;
}

@end
