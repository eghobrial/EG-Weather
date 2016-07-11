//
//  ZipCodeViewController.m
//  Lab1
//
//  Created by Eman Ghobrial on 1/25/16.
//  Copyright © 2016 Eman Ghobrial. All rights reserved.
//

#import "ZipCodeViewController.h"

@interface ZipCodeViewController ()
@property NSString *zipCode;
@end

@implementation ZipCodeViewController
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //    NSLog(@"number of row %lu", (unsigned long)self.dataArray.count);
    // return [self.dataArray count];
    NSArray *dataArray = [[weatherInfoManager sharedManager] getArray];
    NSLog(@"Array count %lu ",(unsigned long)[dataArray count]);
    return [dataArray count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"weatherCell" forIndexPath:indexPath];
    
    // Configure the cell...
    NSArray *dataArray = [[weatherInfoManager sharedManager] getArray];
    NSDictionary *winfo = [dataArray objectAtIndex:indexPath.row];
    
    [cell.textLabel setText:[NSString stringWithFormat:@"%@, %@", [winfo objectForKey:@"day"],[winfo objectForKey:@"date"]]];
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@ High:%@, Low: %@",[winfo objectForKey:@"status"],[winfo objectForKey:@"hightemp"],[winfo objectForKey:@"lowtemp"]]];
    
    NSString *myUrlStr = [winfo objectForKey:@"imageURL"];
    NSLog(@"Image URL string %@ ", myUrlStr);
    NSURL *myUrl = [NSURL URLWithString:myUrlStr];
    NSData *data = [NSData dataWithContentsOfURL:myUrl];
    UIImage *myImage = [UIImage imageWithData:data];
    cell.imageView.image = myImage;
    return cell;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    // NSArray *dataArr = self.dataArray;
    
    NSArray *dataArray = [[weatherInfoManager sharedManager] getArray];
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    NSDictionary *myCityDict = [dataArray objectAtIndex:indexPath.row];
    
    DetailViewController *detailVC = (DetailViewController *)segue.destinationViewController;
    
    //UIViewController *detailVC = segue.destinationViewController;
    detailVC.cityDict = myCityDict;
    detailVC.zipCode = self.zipCode;
    //   NSLog(@"Zipcode off Table View %@", self.zipCode);
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self displayAlert];
    
//    NSLog(@"Loading Table view %lu ",(unsigned long)self.dataArray.count);
 }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) displayAlert {
    UIAlertController *zipAlert = [ UIAlertController alertControllerWithTitle:@"Welcome" message:@"Please enter your zip code" preferredStyle:UIAlertControllerStyleAlert];
    [zipAlert addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"Input zip code";
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler: ^(UIAlertAction *action){
        NSLog(@"OK button pressed");
        UITextField *zipCode = zipAlert.textFields.firstObject;
        NSLog(@"Zipcode %@", zipCode);
        self.zipCode = zipCode.text;
        [self fetchData];
    }];
    [zipAlert addAction:okAction];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [zipAlert addAction:cancelAction];
    
    [self presentViewController:zipAlert animated:YES completion:nil];
}

-(IBAction)refreshButton:(id)sender
{
    [self displayAlert];
    
}

-(void) fetchData
{
    NSMutableArray* dataArr = [NSMutableArray new];
    NSString* myURL;
    if (self.zipCode) {
        myURL = [NSString stringWithFormat:@"http://api.wunderground.com/api/5fe9d60523eb6f71/forecast10day/q/%@.json",self.zipCode];
    } else {
        //make initial value 92130
        myURL = [NSString stringWithFormat:@"http://api.wunderground.com/api/5fe9d60523eb6f71/forecast10day/q/%@.json",self.zipCode];
    }
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager GET:myURL parameters:nil success:^(AFHTTPRequestOperation *operation, id forecastObject) {
        if ([forecastObject isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *forecastDict = (NSDictionary *)forecastObject;
            
            if (forecastDict[@"forecast"] != nil) {
                //   NSLog(@"JSON : %@", forecastDict[@"forecast"]);
                NSDictionary *forecastdict1 = forecastDict[@"forecast"];
                NSDictionary *detailedforecastDict = forecastdict1[@"txt_forecast"];
                NSArray* detailedforecastInfo = detailedforecastDict [@"forecastday"];
                //   NSLog(@"Dict Count : %lu" ,(unsigned long)detailedforecastInfo.count);
                
                NSDictionary *simpleforecastDict = forecastDict[@"forecast"];
                // NSLog(@"JSON : %@", simpleforecastDict[@"simpleforecast"]);
                NSDictionary *forecastDays = simpleforecastDict[@"simpleforecast"];
                NSArray* forecastInfo = forecastDays [@"forecastday"];
                // NSLog(@"simple detail Count : %lu" ,(unsigned long)forecastInfo.count);
                
                
                for (int i=0; i<10;i++)
                {
                    NSString* imageURL = detailedforecastInfo[i*2][@"icon_url"];
                    NSLog(@"Image URL at %d: %@",i*2,imageURL);
                    NSString* date = [NSString stringWithFormat:@"%@/%@",forecastInfo[i][@"date"][@"month"],forecastInfo[i][@"date"][@"day"]];
                    //    NSLog(@"Date: %@  ",date);
                    NSString* day = detailedforecastInfo[i*2][@"title"];
                    NSString* fctext = detailedforecastInfo[i*2][@"fcttext"];
                    NSString* status = detailedforecastInfo[i*2][@"icon"];
                    NSString* hightemp = forecastInfo[i][@"high"][@"fahrenheit"] ;
                    NSString* lowtemp = forecastInfo[i][@"low"][@"fahrenheit"] ;
                    NSString* humidity = forecastInfo[i][@"avehumidity"] ;
                    NSString* precipit = forecastInfo[i][@"qpf_allday"][@"in"] ;
                    NSString* snow = forecastInfo[i][@"snow_allday"][@"in"] ;
                    NSString* windspeed = forecastInfo[i][@"avewind"][@"mph"] ;
                    // weatherInfo* winfo = [[weatherInfo alloc]initWithImageURL:imageURL andDate:date andDay:day andFctext:fctext andStatus:status andHighTemp:hightemp andLowTemp:lowtemp andHumidity:humidity andPrecipit:precipit andSnow:snow andWindspeed:windspeed];
                    //    [mydataArray addObject:winfo];
                    [dataArr addObject:@{@"date":date,@"imageURL":imageURL,@"day":day,@"fctext":fctext,@"status":status,@"hightemp":hightemp,@"lowtemp":lowtemp,@"humidity":humidity,@"precipit":precipit,@"snow":snow,@"windspeed":windspeed}];
                }
                
                [[weatherInfoManager sharedManager] setArray:dataArr];
                
                [self.tableView reloadData];
               // self.dataArray = dataArr;
            } else {
                //nil json invalid zipcode
                NSLog(@"No forcast provided, please make sure you input a valid zipcode");
                //add an alert controller to display the error message ................
            UIAlertController *errorAlert = [ UIAlertController alertControllerWithTitle:@"Error" message:@"Please enter a valid zip code" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
                [errorAlert addAction:cancelAction];

                 [self presentViewController:errorAlert animated:YES completion:nil];
                
            }
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error != nil) {
            NSString *description = [error.userInfo objectForKey:@"NSLocalizedDescription"];
            if (description != nil) {
                NSString *errorString = description;
                NSLog(@"Error: %@", errorString);
            }
        }
        
    }];
    
    
    
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
