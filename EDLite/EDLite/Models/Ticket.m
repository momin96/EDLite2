//
//  Ticket.m
//  EDLite
//
//  Created by Nasirahmed on 10/09/15.
//  Copyright (c) 2015 Nasir. All rights reserved.
//

#import "Ticket.h"

@implementation Ticket
//Persistant CBL model
@dynamic _id,_rev,doctrine_metadata,archived,content,dates,location,map,participants,plan,project,state,timeline;

@synthesize database;

- (void)configureNewTicket {
    self.content = [self dictionaryWithType:@"Note"];
    self.dates = @{};
//    self.archived = @"2014-06-19T08:13:52.479Z";
    
    // enable Doctrine, this is a fixed value needed for the PHP backend
    // implementation
    // no need to ever change this
    self.doctrine_metadata = @{
                               @"indexed" : @(1),
                               @"associations" : @[ @"project", @"map" ]
                               };
    self.location = [self dictionaryWithType:@"Location"];
    
    self.participants = [self ticketParticipants];
    
    self.plan = [self dictionaryWithType:@"Plan"];
    
    self.project = [[EDLDataManager sharedDataManager] projectDocumentID:self.database];
    
    NSMutableDictionary *stateDict =
    [[self dictionaryWithType:@"State"] mutableCopy];
    [stateDict setValue:@"created" forKey:@"state"];
    self.state = [NSDictionary dictionaryWithDictionary:stateDict];
    self.timeline = @[];
    self.type = kTicketType;

}

-(NSDictionary*)ticketParticipants{
    NSDictionary* parti =@{
                           @"accountable": @{
                                   @"email": @"nasir.acc@test.com",
                                   @"type": @"IB.EdBundle.Document.Person"
                                   },
                           @"responsible": @{
                                   @"email": @"nasir.resp@test.com",
                                   @"type": @"IB.EdBundle.Document.Person"
                                   },
                           @"support": @[
                                   @{
                                       @"email": @"nasir.sup@test.com",
                                       @"type": @"IB.EdBundle.Document.Person"
                                       }
                                   ],
                           @"type": @"IB.EdBundle.Document.Participants"
                           };
    return parti;
}

#pragma mark - Helper

/**
 * dictionary for class is a helpin method to create an empty dictionary with the correct
 * Doctrine type reference
 */
- (NSDictionary *)dictionaryWithType:(NSString *)type {
    return @{
             @"type" : [NSString stringWithFormat:@"IB.EdBundle.Document.%@", type]
             };
}
#pragma mark - Properties Helper

- (NSString *)title {
    return [self.content[@"title"] isEqualToString:@""] ? @"N/A": self.content[@"title"];
}

- (NSString *)body {
    return [self.content[@"body"] isEqualToString:@""] ? @"N/A" : self.content[@"body"];
}

#pragma mark - Status

- (NSString *)status {
    return  [self.state[@"state"] lowercaseString];
}

#pragma mark - ID

/**
 *  allows for easy searching of tickets and hides the long UUIDs CouchDB uses
 * internally. Please note that this Id can be duplicate in VERY rare cases.
 *
 *  @return the human ID of this ticket
 */
- (NSString *)humanId {
    NSString *anID = [self getValueOfProperty:@"_id"];
    NSUInteger length = anID.length;
    NSMutableString *hid = [NSMutableString stringWithCapacity:6];
    
    // get last 6 characters of the _id, and set them in uppercase
    NSString *lastSixID =
    [[anID substringFromIndex:length - 6] uppercaseString];
    
    // now reverse the string
    // copied from http://rosettacode.org/wiki/Reverse_a_string#Objective-C
    length = 6;
    while (length > (NSUInteger)0) {
        unichar uch = [lastSixID characterAtIndex:--length];
        [hid appendString:[NSString stringWithCharacters:&uch length:1]];
    }
    return [NSString stringWithString:hid];
}


@end
