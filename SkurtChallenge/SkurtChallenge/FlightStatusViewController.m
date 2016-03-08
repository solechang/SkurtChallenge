//
//  FlightStatusViewController.m
//  SkurtChallenge
//
//  Created by Chang Choi on 3/7/16.
//  Copyright © 2016 solechang. All rights reserved.
//

#import "FlightStatusViewController.h"
#import <PureLayout/PureLayout.h>
#import "Flight+CoreDataProperties.h"
#import <MagicalRecord/MagicalRecord.h>
#import <SVProgressHUD/SVProgressHUD.h>

@interface FlightStatusViewController ()

@property (nonatomic, assign) BOOL didSetupConstraints;

@end

@implementation FlightStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSArray *flightArray = [[NSArray alloc] initWithArray:self.flightStatusDictionary[@"flightStatuses"]];
    NSDictionary *flightStatus = [flightArray objectAtIndex:0];
    self.carrierFsCodeLabel.text = [NSString stringWithFormat:@"(%@)",  flightStatus[@"carrierFsCode"]];
    
    NSArray * airlines =self.flightStatusDictionary[@"appendix"][@"airlines"]  ;
    for (NSDictionary *airline in airlines) {
        if ([airline[@"fs"] isEqualToString:flightStatus[@"carrierFsCode"]]) {

            self.airlineNameLabel.text = airline[@"name"];
            [self.airlineNameLabel sizeToFit];
            break;
        }
        
    }
    self.departureAirportFsCodeLabel.text = flightStatus[@"departureAirportFsCode"];

    self.arrivalAirportFsCodeLabel.text = flightStatus[@"arrivalAirportFsCode"];
   
    [self.arrivalAirportFsCodeLabel sizeToFit];

    self.statusLabel.text = [self getStatus:flightStatus[@"status"]];
    
    NSDictionary *arrivalDate = flightStatus[@"arrivalDate"];
    
    NSDictionary *departureDate = flightStatus[@"departureDate"];
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];

    [format setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS"];

    NSDate *dDate =[format dateFromString:departureDate[@"dateLocal"]];
    NSDate *aDate = [format dateFromString:arrivalDate[@"dateLocal"]];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MM-dd-yyyy, hh:mm a";

    self.departureDate.text = [NSString stringWithFormat:@"Departing at: %@", [formatter stringFromDate:dDate]];
    self.arrivalDateLabel.text = [NSString stringWithFormat:@"Arriving at: %@", [formatter stringFromDate:aDate]];

}

-(void) viewWillDisappear:(BOOL)animated {
    [SVProgressHUD dismiss];
    
    [super viewWillDisappear:animated];
}

-(NSString*)getStatus :(NSString*) status {
    NSString *newStatus = @"";
    
    if ([status isEqualToString:@"S"]) {
        newStatus = @"Scheduled" ;
    }  else if ([status isEqualToString:@"A"]) {
        newStatus = @"Active" ;
    }  else if ([status isEqualToString:@"U"]) {
        newStatus = @"Unknown" ;
    }  else if ([status isEqualToString:@"R"]) {
        newStatus = @"Redirected" ;
    }  else if ([status isEqualToString:@"L"]) {
        newStatus = @"Landed" ;
    }  else if ([status isEqualToString:@"D"]) {
        newStatus = @"Diverted" ;
    }  else if ([status isEqualToString:@"C"]) {
        newStatus = @"Cancelled" ;
    }   else if ([status isEqualToString:@"NO"]) {
        newStatus = @"Not Operational" ;
    }
   
    return newStatus;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)saveButtonPressed:(id)sender {

    [MagicalRecord saveWithBlock:^(NSManagedObjectContext * _Nonnull localContext) {
        
        
        Flight *flight = [Flight MR_findFirstInContext:localContext];
        if (!flight ) {
            Flight *flight = [Flight MR_createEntityInContext:localContext];
            
            flight.carrierFsCode = self.carrierFsCodeLabel.text;
            flight.airlineName = self.airlineNameLabel.text;
            flight.departureAirportFsCode = self.departureAirportFsCodeLabel.text;
            flight.arrivalAirportFsCode = self.arrivalAirportFsCodeLabel.text;
            flight.status = self.statusLabel.text;
            flight.departureDate = self.departureDate.text;
            flight.arrivalDate = self.arrivalDateLabel.text;
        } else {
            flight.carrierFsCode = self.carrierFsCodeLabel.text;
            flight.airlineName = self.airlineNameLabel.text;
            flight.departureAirportFsCode = self.departureAirportFsCodeLabel.text;
            flight.arrivalAirportFsCode = self.arrivalAirportFsCodeLabel.text;
            flight.status = self.statusLabel.text;
            flight.departureDate = self.departureDate.text;
            flight.arrivalDate = self.arrivalDateLabel.text;

        }

        
        
    } completion:^(BOOL contextDidSave, NSError * _Nullable error) {
        
        if (!error) {

            [SVProgressHUD showSuccessWithStatus:@"Flight Saved!"];
        }
    }];
}

@end
