//
//  DetailViewController.h
//  Lab1
//
//  Created by Eman Ghobrial on 1/26/16.
//  Copyright © 2016 Eman Ghobrial. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property NSDictionary *cityDict;
@property NSString *zipCode;

//@property IBOutlet CustomView *myView;

@property IBOutlet UILabel *weatherLabel;
@property IBOutlet UIImageView *myImageView;
@property IBOutlet UILabel *hightempLabel;
@property IBOutlet UILabel *lowtempLabel;
@property IBOutlet UITextView *fctexttv;
@property IBOutlet UILabel *statusLabel;
@property IBOutlet UILabel *humidityLabel;
@property IBOutlet UILabel *precipitLabel;
@property IBOutlet UILabel *snowLabel;
@property IBOutlet UILabel *windspeedLabel;
@end
