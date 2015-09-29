//
//  EDLDataManager.h
//  EDLite
//
//  Created by Nasirahmed on 28/09/15.
//  Copyright (c) 2015 Nasir. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDLDataManager : NSObject

@property (nonatomic) CBLDatabase* database;

+(EDLDataManager*)sharedDataManager;

-(NSInteger)countOfTickets;
-(NSInteger)countOfMaps;

-(NSArray*)ticketListView:(CBLDatabase*)database;

@end
