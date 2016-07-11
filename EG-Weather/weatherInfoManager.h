//
//  weatherInfoManager.h
//  Lab1
//
//  Created by Eman Ghobrial on 1/21/16.
//  Copyright © 2016 Eman Ghobrial. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"

@interface weatherInfoManager : NSObject

+(id)sharedManager;

-(NSArray *)getArray;
-(void) setArray:(NSMutableArray*) weatherArr;
@property NSString* zipCode;
@end
