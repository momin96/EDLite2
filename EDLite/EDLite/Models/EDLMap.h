//
//  EDLMap.h
//  EDLite
//
//  Created by Nasirahmed on 07/10/15.
//  Copyright (c) 2015 Nasir. All rights reserved.
//

#import <CouchbaseLite/CouchbaseLite.h>

@interface EDLMap : CBLModel

///---------------------
/// @note document properties.
///---------------------
@property(nonatomic,strong) NSString *_id;
@property(nonatomic,strong) NSString *_rev;
@property(nonatomic,strong) NSString *group;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *project;
@property(nonatomic,strong) NSDictionary *renderInfo;
@property(nonatomic,strong) NSArray *timeline;
@property(nonatomic,strong) NSString *archived;



@end
