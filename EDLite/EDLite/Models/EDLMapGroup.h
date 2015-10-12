//
//  EDLMapGroup.h
//  EDLite
//
//  Created by Nasirahmed on 08/10/15.
//  Copyright (c) 2015 Nasir. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDLMapGroup : NSObject

@property(nonatomic, strong) NSString *name;
@property(nonatomic, assign) NSUInteger numberOfMaps;
@property(nonatomic, assign) NSUInteger numberOfTickets;
@property(nonatomic, strong) NSArray *maps;

@end
