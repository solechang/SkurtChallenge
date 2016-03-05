//
//  FlightTableViewController.m
//  SkurtChallenge
//
//  Created by Chang Choi on 3/2/16.
//  Copyright © 2016 solechang. All rights reserved.
//

#import "FlightTableViewController.h"
#import "APIClient.h"
#import "FlightDateTableViewCell.h"
#import "FlightInfoTableViewCell.h"

@interface FlightTableViewController ()

@property (nonatomic) NSMutableArray *flightsArray;

@end

@implementation FlightTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    
    [self intializeFlightsArray];
}

- (void) setupTableView {
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    
//    NSDictionary *info = @{@"appId" : @"91b929e6",
//                                        @"appKey" : @"2eebba75c50ce13c31b9ef0b331fb93a",
//
//                                        };
//    
////    NSString *resourceURL = @"flex/schedules/v1/json/flight";
//    
////    LH2014 flightID
//    
//    [[APIClient sharedClient] GET:@"v2/json/flight/status/" parameters:info progress:^(NSProgress * _Nonnull downloadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@" 1. )%@", responseObject);
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@" 1. )%@", error);
//        
//    }];
//}

- (void) intializeFlightsArray {
    self.flightsArray = [[NSMutableArray alloc] init];
    [self.flightsArray addObject:@"HI"];
    [self.flightsArray addObject:@"HI"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.flightsArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"0.) %lu", indexPath.row)    ;
    
    
    
    if ( indexPath.section == 0) {
            FlightInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FlightCell" forIndexPath:indexPath];
        NSLog(@"1.)");
            return cell;
    } else if (indexPath.section == 1) {
           NSLog(@"2.)");
        FlightDateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DateCell" forIndexPath:indexPath];
            return cell;
    }
    return  nil;
    

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.0f;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
