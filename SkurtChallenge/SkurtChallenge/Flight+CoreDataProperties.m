//
//  Flight+CoreDataProperties.m
//  SkurtChallenge
//
//  Created by Chang Choi on 3/7/16.
//  Copyright © 2016 solechang. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Flight+CoreDataProperties.h"

@implementation Flight (CoreDataProperties)

@dynamic carrierFsCode;
@dynamic airlineName;
@dynamic departureAirportFsCode;
@dynamic arrivalAirportFsCode;
@dynamic status;
@dynamic departureDate;
@dynamic arrivalDate;

@end
