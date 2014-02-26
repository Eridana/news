//
//  Manager.h
//  news
//
//  Created by Женя Михайлова on 13.02.14.
//  Copyright (c) 2014 Женя Михайлова. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#import "ManagerDelegate.h"
#import "CommunicatorDelegate.h"

@class Communicator;

@interface Manager : NSObject<CommunicatorDelegate>
@property (strong, nonatomic) Communicator *communicator;
@property (weak, nonatomic) id<ManagerDelegate> delegate;


- (void)fetchNews;
- (void)fetchNewsByCitiesAndPage:(NSArray *)cities atPage:(NSString *)page;
- (void)fetchCities;
@end