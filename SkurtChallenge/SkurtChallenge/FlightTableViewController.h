//
//  FlightTableViewController.h
//  SkurtChallenge
//
//  Created by Chang Choi on 3/2/16.
//  Copyright © 2016 solechang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlightTableViewController : UITableViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *flightNumberTextField;

@property (weak, nonatomic) IBOutlet UITextField *carrierCodeTextField;
@property (weak, nonatomic) IBOutlet UILabel *departingOrArrivingLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *refreshActivityIndicator;

@end
