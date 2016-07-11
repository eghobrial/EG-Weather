//
//  weatherInfo.m
//  Lab1
//
//  Created by Eman Ghobrial on 1/21/16.
//  Copyright © 2016 Eman Ghobrial. All rights reserved.
//

#import "weatherInfo.h"

@implementation weatherInfo

-(id) initWithImageURL:(NSString*) imageURL andDate:(NSString*) date andDay:(NSString*) day andFctext:(NSString*)fctext andStatus:(NSString*)status andHighTemp:(float) hightemp andLowTemp:(float) lowtemp andHumidity:(float) humidity andPrecipit:(float) precipit andSnow:(float) snow andWindspeed:(float) windspeed
{
    self = [super init];
    self.imageURL = imageURL;
    self.date = date;
    self.day = day;
    self.fctext = fctext;
    self.status = status;
    self.hightemp = hightemp;
    self.lowtemp = lowtemp;
    self.humidity = humidity;
    self.precipit = precipit;
    self.snow = snow;
    self.windspeed = windspeed;
    return self;
}

@end
