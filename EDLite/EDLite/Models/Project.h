//
//  Project.h
//  EDLite
//
//  Created by Nasirahmed on 11/09/15.
//  Copyright (c) 2015 Nasir. All rights reserved.
//

#import <CouchbaseLite/CouchbaseLite.h>

@interface Project : NSObject

@property (nonatomic) NSURL* source;
@property (nonatomic) NSString* target;
@property (nonatomic) NSString* archived;
@property (nonatomic) NSString* favorite;
@property (nonatomic) NSDictionary* location;
@property (nonatomic) NSString* projectName;
@property (nonatomic) NSString* remoteLink;
@property (nonatomic) NSDictionary* roles;
@property (nonatomic) NSString* thumbImage;
@property (nonatomic) NSString* databaseName;

-(instancetype)initProjectWithDictionary:(NSDictionary*)projectInfoDict databaseName:(NSString*)dbName;


@end
