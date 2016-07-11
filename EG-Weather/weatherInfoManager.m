//
//  weatherInfoManager.m
//  Lab1
//
//  Created by Eman Ghobrial on 1/21/16.
//  Copyright © 2016 Eman Ghobrial. All rights reserved.
//

#import "weatherInfoManager.h"

@interface weatherInfoManager ()
@property  NSMutableArray *dataArray;
@end

@implementation weatherInfoManager

-(void) setArray:(NSMutableArray*) weatherArr {
    self.dataArray = weatherArr;
    
}

-(NSArray *)getArray {
    return self.dataArray;
}

//create a singleton - an object that is reused if it exists. only initialize it once
+(id)sharedManager {
    
    //look for a pointer for the singleton and create if it does not exists
    static weatherInfoManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    
    //the system calls this code only once while your app is active
    dispatch_once(&onceToken, ^{
        
        //initial val
         sharedMyManager = [[self alloc] init];
       sharedMyManager.dataArray = [NSMutableArray new];
        
    });
        return sharedMyManager;
}

@end
