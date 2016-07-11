//
//  weatherInfo.h
//  Lab1
//
//  Created by Eman Ghobrial on 1/21/16.
//  Copyright © 2016 Eman Ghobrial. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface weatherInfo : NSObject

@property NSString *imageURL;
@property NSString *date;
@property NSString *day;
@property NSString *fctext;
@property NSString *status;
@property float hightemp;
@property float lowtemp;
@property float humidity;
@property float precipit;
@property float snow;
@property float windspeed;
-(id) initWithImageURL:(NSString*) imageURL andDate:(NSString*) date andDay:(NSString*) day andFctext:(NSString*)fctext andStatus:(NSString*)status andHighTemp:(float) hightemp andLowTemp:(float) lowtemp andHumidity:(float) humidity andPrecipit:(float) precipit andSnow:(float) snow andWindspeed:(float) windspeed;


@end
