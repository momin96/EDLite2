//
//  Ticket.h
//  EDLite
//
//  Created by Nasirahmed on 10/09/15.
//  Copyright (c) 2015 Nasir. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ticket : CBLModel
//Presistant Properties
@property(nonatomic, strong) NSString *_id;
@property(nonatomic, strong) NSString *_rev;
@property(nonatomic, strong) NSDictionary *doctrine_metadata;
@property(nonatomic, strong) NSString *archived;
@property(nonatomic, strong) NSDictionary *content;
@property(nonatomic, strong) NSDictionary *dates;
@property(nonatomic, strong) NSDictionary *location;
@property(nonatomic, strong) NSString *map;
@property(nonatomic, strong) NSDictionary *participants;
@property(nonatomic, strong) NSDictionary *plan;
@property(nonatomic, strong) NSString *project;
@property(nonatomic, strong) NSDictionary *state;
@property(nonatomic, strong) NSArray *timeline;

+(instancetype)ticketInDatabase:(CBLDatabase*)db;


-(NSString *)humanId;
- (NSString *)title;
- (NSString *)body;
- (NSString *)status;
-(UIImage*)getArchivedImage;
-(BOOL)isAttachmentAvailable;

- (void)archive;
- (void)unarchive;
@end
