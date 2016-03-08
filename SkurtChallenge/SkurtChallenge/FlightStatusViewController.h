//
//  FlightStatusViewController.h
//  SkurtChallenge
//
//  Created by Chang Choi on 3/7/16.
//  Copyright © 2016 solechang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlightStatusViewController : UIViewController

@property(nonatomic) NSDictionary* flightStatusDictionary;
@property (weak, nonatomic) IBOutlet UILabel *carrierFsCodeLabel;

@property (weak, nonatomic) IBOutlet UILabel *airlineNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *departureAirportFsCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *toLabel;

@property (weak, nonatomic) IBOutlet UILabel *arrivalAirportFsCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *departureDate;

@property (weak, nonatomic) IBOutlet UILabel *arrivalDateLabel;

@property (weak, nonatomic) IBOutlet UILabel *status;

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@end
