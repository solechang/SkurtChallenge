//
//  FlightInfoTableViewCell.h
//  SkurtChallenge
//
//  Created by Chang Choi on 3/4/16.
//  Copyright © 2016 solechang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlightInfoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *flightNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *carrierCodeTextField;


@end
