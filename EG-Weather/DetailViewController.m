//
//  DetailViewController.m
//  Lab1
//
//  Created by Eman Ghobrial on 1/26/16.
//  Copyright © 2016 Eman Ghobrial. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.cityDict != nil) {
        
        self.weatherLabel.text = [NSString stringWithFormat: @"Weather Conditions for %@",self.zipCode];
        self.lowtempLabel.text = [NSString stringWithFormat:@"Low: %@F",[self.cityDict objectForKey:@"lowtemp"]];
        self.hightempLabel.text = [NSString stringWithFormat:@"%@F",[self.cityDict objectForKey:@"hightemp"]];
       
        self.fctexttv.textContainer.lineBreakMode = NSLineBreakByWordWrapping;
        self.fctexttv.text = [self.cityDict objectForKey:@"fctext"];
       self.statusLabel.text = [self.cityDict objectForKey:@"status"];
    //    NSLog(@"humidity = %@ ",[self.cityDict objectForKey:@"humidity"]);
      NSString*  precents = @"\%";
        
      self.humidityLabel.text = [NSString stringWithFormat:@"Avg Humidity: %@%@",[self.cityDict objectForKey:@"humidity"],precents];
       self.precipitLabel.text = [NSString stringWithFormat:@"Precipitation: %@ in",[self.cityDict objectForKey:@"precipit"]];
        self.snowLabel.text = [NSString stringWithFormat:@"Snow: %@ in",[self.cityDict objectForKey:@"snow"]];
        self.windspeedLabel.text = [NSString stringWithFormat:@"Avg Wind Speed: %@mph",[self.cityDict objectForKey:@"windspeed"]];
        
        NSString *myUrlStr = [self.cityDict objectForKey:@"imageURL"];
       // NSLog(@"Image URL string %@ ", myUrlStr);
        NSURL *myUrl = [NSURL URLWithString:myUrlStr];
        NSData *data = [NSData dataWithContentsOfURL:myUrl];
        
        UIImage *myImage = [UIImage imageWithData:data];
        
       
       self.myImageView.image = myImage;
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
