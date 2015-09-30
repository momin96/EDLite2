//
//  EDLViews.h
//  EDLite
//
//  Created by Nasirahmed on 29/09/15.
//  Copyright (c) 2015 Nasir. All rights reserved.
//


@interface EDLViews : NSObject

+(CBLView*)activeTicketListView:(CBLDatabase*)database;

+(CBLView*)completedTicketListView:(CBLDatabase*)database;

+(CBLView*)countOfMapsView:(CBLDatabase*)database;

+(CBLView*)countOfTicketsView:(CBLDatabase*)database;

+(CBLView*)typeProjectView:(CBLDatabase*)database;

+(CBLView*)completedArchivedTicketListView:(CBLDatabase*)database;

+(CBLView*)liveQueryView:(CBLDatabase*)database;
@end
