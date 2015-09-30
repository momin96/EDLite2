//
//  EDLViews.m
//  EDLite
//
//  Created by Nasirahmed on 29/09/15.
//  Copyright (c) 2015 Nasir. All rights reserved.
//

#import "EDLViews.h"

@implementation EDLViews

+(CBLView*)activeTicketListView:(CBLDatabase*)database{
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
    return activeTicketListView;
}

+(CBLView*)completedTicketListView:(CBLDatabase*)database{
    CBLView* completedTicketListView = [database viewNamed:@"_completedTicketListView"];
    completedTicketListView.documentType = kTicketType;
    if(!completedTicketListView.mapBlock){
        [completedTicketListView setMapBlock:MAPBLOCK({
            
            BOOL isCompleted = [[doc[@"state"][@"state"] lowercaseString] isEqualToString:@"completed"];
            
            if(isCompleted)
                emit(doc[@"_id"],doc[@"_id"]);
            
        }) version:@"1.2"];
    }
    return completedTicketListView;
}

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

+(CBLView*)liveQueryView:(CBLDatabase*)database{
    CBLView* liveQueryView = [database viewNamed:@"_liveQueyView"];
    liveQueryView.documentType = kTicketType;
    if (!liveQueryView.mapBlock) {
        [liveQueryView setMapBlock:MAPBLOCK({
            if(doc[@"_id"] && !(doc[@"archived"] == [NSNull null]))
                emit(@[doc[@"_id"],doc[@"archived"]],doc[@"state"][@"state"]);
        }) version:@"1.2"];
    }
    return liveQueryView;
}

+(CBLView*)completedArchivedTicketListView:(CBLDatabase*)database{
    CBLView* compeletedArchivedTicketListView = [database viewNamed:@"_compeletedArchivedTicketListView"];
    compeletedArchivedTicketListView.documentType = kTicketType;
    
    return compeletedArchivedTicketListView;
}

@end
