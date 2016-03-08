//
//  SavedFlightViewController.m
//  SkurtChallenge
//
//  Created by Chang Choi on 3/7/16.
//  Copyright © 2016 solechang. All rights reserved.
//

#import "SavedFlightViewController.h"
#import "Flight+CoreDataProperties.h"
#import <MagicalRecord/MagicalRecord.h>
#import <SVProgressHUD/SVProgressHUD.h>

@interface SavedFlightViewController () {
    Flight *flight;
}

@end

@implementation SavedFlightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    flight = [Flight MR_findFirst];
    self.carrierFsCodeLabel.text = flight.carrierFsCode;
    self.airlineNameLabel.text = flight.airlineName;
    self.departureAirportFsCodeLabel.text = flight.departureAirportFsCode;
    self.arrivalAirportFsCodeLabel.text = flight.arrivalAirportFsCode;
    self.status.text = flight.status;
    self.arrivalDateLabel.text = flight.arrivalDate;
    self.departureDate.text = flight.departureDate;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backButtonPressed:(id)sender {

    [self.navigationController dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)deleteButtonPressed:(id)sender {
    [self popAlertViewForDeletingSavedFlight];
    //alert
}
- (void)popAlertViewForDeletingSavedFlight{
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Flight Status"
                                  message:@"Are you sure you want to delete this saved flight status?"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* noAlert = [UIAlertAction
                              actionWithTitle:@"No"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  
                                  [alert dismissViewControllerAnimated:YES completion:nil];
                                  
                              }];
    
    UIAlertAction* yesAlert = [UIAlertAction
                               actionWithTitle:@"Yes"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                   [self deleteFlightStatus];
                                   
                                   [alert dismissViewControllerAnimated:YES completion:nil];
                                   
                               }];
    
    [alert addAction:noAlert];
    [alert addAction:yesAlert];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void) deleteFlightStatus {
    
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext * _Nonnull localContext) {
        flight = [Flight MR_findFirstInContext:localContext];
        [flight MR_deleteEntity];
    } completion:^(BOOL contextDidSave, NSError * _Nullable error) {
        
        if (!error) {
            [self backButtonPressed:self];
        }
    }];


    
}



@end
