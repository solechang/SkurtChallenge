//
//  FlightInfoTableViewCell.m
//  SkurtChallenge
//
//  Created by Chang Choi on 3/4/16.
//  Copyright © 2016 solechang. All rights reserved.
//

#import "FlightInfoTableViewCell.h"
#import "PureLayout.h"

@interface FlightInfoTableViewCell()
@property (nonatomic, assign) BOOL didSetupConstraints;
@end

@implementation FlightInfoTableViewCell


- (void)awakeFromNib {
    // Initialization code

}
-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    // Enter Custom Code

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
