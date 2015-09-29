//
//  Constants.h
//  EDLite
//
//  Created by Nasirahmed on 10/09/15.
//  Copyright (c) 2015 Nasir. All rights reserved.
//


#define SERVER_URL @"http://192.168.2.4:5984/"
#define USERS_DATABASE @"ed_users"
#define USERDOC_PREFIX @"org.couchdb.user:"

#define castIf(CLASSNAME, OBJ)                                                 \
((CLASSNAME *)([NSObject cast:[CLASSNAME class] forObject:OBJ]))

typedef NS_ENUM(NSInteger, EDLConnectionState) {
    EDLConnectionStart,
    EDLConnectionRunning,
    EDLConnectionPause,
    EDLConnectionCompleted,
    EDLConnectionOffline,
    EDLConnectionCompletedOffline
};



extern NSString * const EDLContractsUpdateNotification;
extern NSString * const kEDLConnectionState;
extern NSString * const EDLSyncStateChangedNotification;
