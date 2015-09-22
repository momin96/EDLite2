//
//  User.m
//  EDLite
//
//  Created by Nasirahmed on 11/09/15.
//  Copyright (c) 2015 Nasir. All rights reserved.
//

#import "User.h"

@implementation User
@dynamic _id,_rev,contracts,name,userInfo;


-(instancetype)initUserWithDocument:(CBLDocument*)document{
    self = [[self class] modelForDocument:document];
    if(!self)
        return nil;
    return self;
}



- (void) didLoadFromDocument{
    if(self.contracts && [self.contracts isKindOfClass:[NSDictionary class]]){
        [[NSNotificationCenter defaultCenter] postNotificationName:EDLContractsUpdateNotification
                                                            object:nil
                                                          userInfo:self.contracts];
    }
}

@end
