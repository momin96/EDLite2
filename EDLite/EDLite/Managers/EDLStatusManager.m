//
//  EDLStatusManager.m
//  EDLite
//
//  Created by Nasirahmed on 21/09/15.
//  Copyright (c) 2015 Nasir. All rights reserved.
//

#import "EDLStatusManager.h"

@implementation EDLStatusManager

+(EDLStatusManager*)sharedStatusInstance{
    static EDLStatusManager* sharedStatusInstance = nil;
    if(sharedStatusInstance == nil){
        sharedStatusInstance = [[EDLStatusManager alloc]init];
    }
    return sharedStatusInstance;
}

@end
