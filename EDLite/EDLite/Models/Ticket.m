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



#pragma mark - Properties Helper

- (NSString *)title {
    return self.content[@"title"];
}

- (NSString *)body {
    return self.content[@"body"];
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
