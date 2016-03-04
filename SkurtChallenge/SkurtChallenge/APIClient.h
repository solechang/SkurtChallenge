//
//  APIClient.h
//  SkurtChallenge
//
//  Created by Chang Choi on 3/3/16.
//  Copyright © 2016 solechang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@interface APIClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end
