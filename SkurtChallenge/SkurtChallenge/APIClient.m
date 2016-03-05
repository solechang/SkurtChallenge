//
//  APIClient.m
//  SkurtChallenge
//
//  Created by Chang Choi on 3/3/16.
//  Copyright © 2016 solechang. All rights reserved.
//

#import "APIClient.h"
static NSString *const APIClientURLString = @"https://api.flightstats.com/flex/flightstatus/";

@implementation APIClient

+ (instancetype) sharedClient{
    
    static APIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        _sharedClient = [[APIClient alloc] initWithBaseURL:[NSURL URLWithString:APIClientURLString]];
        
    });
    return _sharedClient;
}
@end
