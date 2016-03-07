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

#import "FlightStatusTableViewController.h"

@interface FlightTableViewController ()

@property (nonatomic) NSMutableArray *flightsArray;
@property (nonatomic) BOOL datePickerIsShowing;
@property (nonatomic) NSInteger rows;
@property (nonatomic) NSString *departingOrArriving;

@end

@implementation FlightTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    
    [self intializeFlightsArray];
    [self setupDelegates];
    
    self.rows = 4;
}

-(void) setupDelegates {
    self.carrierCodeTextField.delegate = self;
    self.flightNumberTextField.delegate = self;
}
- (void) setupTableView {
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    
;
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

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.rows;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        [self.flightNumberTextField becomeFirstResponder];
        [self hideDatePicker];
        
    } else if (indexPath.row == 1) {
        [self.carrierCodeTextField becomeFirstResponder];
        [self hideDatePicker];
    } else if (indexPath.row == 2 ) {
        // Pop up picker
        
        [self.flightNumberTextField resignFirstResponder];
        [self.carrierCodeTextField resignFirstResponder];
        [self hideDatePicker];
        [self showPicker];
    } else if (indexPath.row == 3) {
        // Pop up date picker
        
        [self.flightNumberTextField resignFirstResponder];
        [self.carrierCodeTextField resignFirstResponder];
        [self showDatePicker];
    }
}

- (void) hideDatePicker {
    self.rows = 4;
    [self.tableView reloadData];
}

- (void) showPicker {
    UIAlertController * view=   [UIAlertController
                                 alertControllerWithTitle:@"Choose Flight Option"
                                 message:@"Is your flight departing or arriving?"
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
    [view addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }]];

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:3 inSection:0];
    
    UIAlertAction* departing = [UIAlertAction
                         actionWithTitle:@"Departing"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             //Do some thing here
                             self.departingOrArrivingLabel.text = @"Flight: Departing";
                             self.departingOrArrivingLabel.textColor = [UIColor blackColor];
                             self.departingOrArriving = @"dep";
                             [self.tableView selectRowAtIndexPath:indexPath
                                                         animated:YES
                                                   scrollPosition:UITableViewScrollPositionNone];
                             [self tableView:self.tableView didSelectRowAtIndexPath:indexPath];
                             [view dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    UIAlertAction* arriving = [UIAlertAction
                             actionWithTitle:@"Arriving"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 self.departingOrArrivingLabel.text = @"Flight: Arriving";
                                 self.departingOrArrivingLabel.textColor = [UIColor blackColor];
                                 self.departingOrArriving = @"arr";
                                 [self.tableView selectRowAtIndexPath:indexPath
                                                             animated:YES
                                                       scrollPosition:UITableViewScrollPositionNone];
                                 [self tableView:self.tableView didSelectRowAtIndexPath:indexPath];
                                 [view dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    
    [view addAction:departing];
    [view addAction:arriving];
    [self presentViewController:view animated:YES completion:nil];
}

- (void) showDatePicker {
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"MM-dd-yyyy";
    
//    NSLog(@"%@", [format stringFromDate:[NSDate new]]);
    
    self.dateLabel.textColor = [UIColor blackColor];
    self.dateLabel.text = [NSString stringWithFormat:@"Date: %@", [format stringFromDate:self.datePicker.date]];
    if (self.rows == 4) {
            self.rows = 5;
    } 

    [self.tableView reloadData];
}

- (IBAction)datePickerChanged:(id)sender {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"MM-dd-yyyy";
    
    self.dateLabel.text = [NSString stringWithFormat:@"Date: %@", [format stringFromDate:[sender date]]];
//     NSLog(@"1.) value: %@",[sender date]);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 4) {
        return 140.0f;
    }
    return 70.0f;
}

#pragma mark - TextField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if (textField == self.flightNumberTextField) {
        [self.carrierCodeTextField becomeFirstResponder];
    } else if (textField == self.carrierCodeTextField) {
        [textField resignFirstResponder];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
        [self.tableView selectRowAtIndexPath:indexPath
                                    animated:YES
                              scrollPosition:UITableViewScrollPositionNone];
        [self tableView:self.tableView didSelectRowAtIndexPath:indexPath];

    }
    
    return YES;
}

#pragma mark - Buttons
- (IBAction)doneButtonPressed:(id)sender {
    
        NSDictionary *info = @{@"appId" : @"91b929e6",
                                            @"appKey" : @"2eebba75c50ce13c31b9ef0b331fb93a",
                                            };
//   "https://api.flightstats.com/flex/flightstatus/rest/v2/json/flight/status/AA/100/arr/2016/3/6?appId=91b929e6&appKey=2eebba75c50ce13c31b9ef0b331fb93a&utc=false"
    //    NSString *resourceURL = @"flex/schedules/v1/json/flight";
    
    //    LH2014 flightID
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy";
    NSString *year =  [[NSString alloc] initWithFormat:@"%@",[format stringFromDate:self.datePicker.date]];
    format.dateFormat = @"MM";
    NSString *month = [[NSString alloc] initWithFormat:@"%@",[format stringFromDate:self.datePicker.date]];
    format.dateFormat = @"dd";
    NSString *day =  [[NSString alloc] initWithFormat:@"%@",[format stringFromDate:self.datePicker.date]];
    
    NSString *resourceURL= [NSString stringWithFormat:
                            @"flex/flightstatus/rest/v2/json/flight/status/%@/%@/%@/%@/%@/%@",
                            self.carrierCodeTextField.text,
                            self.flightNumberTextField.text,
                            self.departingOrArriving,
                            year,month,day ];
    
    NSLog(@"1.) %@", resourceURL);
    [[APIClient sharedClient] GET:resourceURL parameters:info progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@" 1. )%@", responseObject);
        [self performSegueWithIdentifier:@"flightDetailSegue" sender:self];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@" 1. )%@", error);
    }];
    
}

#pragma mark - Navigation Segue

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"flightStatusSegue"]){
        
        // Get destination view
        
        FlightStatusTableViewController *controller = (FlightStatusTableViewController*)segue.destinationViewController;
//        controller.flightStatusDictionary = 

        
    }
    
}

@end
