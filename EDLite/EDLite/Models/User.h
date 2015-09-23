//
//  User.h
//  EDLite
//
//  Created by Nasirahmed on 11/09/15.
//  Copyright (c) 2015 Nasir. All rights reserved.
//


@interface User : CBLModel

// Persistance Properties
@property (nonatomic) NSString* _id;
@property (nonatomic) NSString* _rev;
@property (nonatomic) NSDictionary* contracts;
@property (nonatomic) NSString* name;
@property (nonatomic) NSDictionary* userInfo;

-(instancetype)initUserWithDocument:(CBLDocument*)document;


@end
