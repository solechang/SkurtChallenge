//
//  Flight+CoreDataProperties.h
//  SkurtChallenge
//
//  Created by Chang Choi on 3/7/16.
//  Copyright © 2016 solechang. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Flight.h"

NS_ASSUME_NONNULL_BEGIN

@interface Flight (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *carrierFsCode;
@property (nullable, nonatomic, retain) NSString *airlineName;
@property (nullable, nonatomic, retain) NSString *departureAirportFsCode;
@property (nullable, nonatomic, retain) NSString *arrivalAirportFsCode;
@property (nullable, nonatomic, retain) NSString *status;
@property (nullable, nonatomic, retain) NSString *departureDate;
@property (nullable, nonatomic, retain) NSString *arrivalDate;

@end

NS_ASSUME_NONNULL_END
