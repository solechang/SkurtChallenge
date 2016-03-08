//
//  FlightTableViewController.m
//  SkurtChallenge
//
//  Created by Chang Choi on 3/2/16.
//  Copyright © 2016 solechang. All rights reserved.
//

#import "FlightTableViewController.h"
#import "APIClient.h"

#import "FlightStatusViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>

#import <MagicalRecord/MagicalRecord.h>
#import "Flight+CoreDataProperties.h"

@interface FlightTableViewController ()
@property (nonatomic) NSDictionary *flightStatusDictionary;
@property (nonatomic) BOOL datePickerIsShowing;
@property (nonatomic) NSInteger rows;
@property (nonatomic) NSString *departingOrArriving;

@end

@implementation FlightTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self setupDelegates];
    
    [self.refreshActivityIndicator setHidden:YES];
    self.rows = 4;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    Flight *flight = [Flight MR_findFirst];
    if (flight) {
        self.savedFlightsButton.enabled = YES;
    } else {
        self.savedFlightsButton.enabled = NO;
    }
}

-(void) setupDelegates {
    self.carrierCodeTextField.delegate = self;
    self.flightNumberTextField.delegate = self;
}
- (void) setupTableView {
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
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
    
    [SVProgressHUD dismiss];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {

        [self.flightNumberTextField performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0];
        [self hideDatePicker];
        
    } else if (indexPath.row == 1) {
        [self.carrierCodeTextField performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0];
        [self hideDatePicker];
    } else if (indexPath.row == 2 ) {
        // Pop up arriving/departing picker
        
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
                                 alertControllerWithTitle:@"Flight Status"
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
- (void)textFieldDidBeginEditing:(UITextField *)textField {

    [SVProgressHUD dismiss];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{


    [SVProgressHUD dismiss];
    return YES;
}

#pragma mark - Buttons
- (IBAction)doneButtonPressed:(id)sender {
    
    [self.doneButton setEnabled:NO];
    [self.refreshActivityIndicator setHidden:NO];
    [self.refreshActivityIndicator startAnimating];
    [self.carrierCodeTextField resignFirstResponder];
    [self.flightNumberTextField resignFirstResponder];
    [SVProgressHUD dismiss];
    
    NSDictionary *info = @{@"appId" : @"91b929e6",
                                            @"appKey" : @"2eebba75c50ce13c31b9ef0b331fb93a",
                                            };
    
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
                            year,month,day];

    [[APIClient sharedClient] GET:resourceURL parameters:info progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSDictionary *responseDictionary = responseObject;
        NSArray *flightStatus = responseDictionary[@"flightStatuses"];
        
        if (!responseDictionary[@"error"] && flightStatus.count != 0 ) {

            self.flightStatusDictionary = [[NSDictionary alloc] initWithDictionary:responseDictionary];
            
            [self performSegueWithIdentifier:@"flightStatusSegue" sender:self];
            
        } else {
            [SVProgressHUD showErrorWithStatus:@"Please make sure you have entered the correct flight information."];
        }

        [self.refreshActivityIndicator setHidden:YES];
        [self.refreshActivityIndicator stopAnimating];
        [self.doneButton setEnabled:YES];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        [self.doneButton setEnabled:YES];
        [self.refreshActivityIndicator setHidden:YES];
        [self.refreshActivityIndicator stopAnimating];
        [SVProgressHUD showErrorWithStatus:@"Please make sure you have entered the correct flight information."];
    }];
    
}

#pragma mark - Navigation Segue

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"flightStatusSegue"]){
        
        // Get destination view
        FlightStatusViewController *controller = (FlightStatusViewController*)segue.destinationViewController;

        controller.flightStatusDictionary = self.flightStatusDictionary;

    }
    
}

@end
