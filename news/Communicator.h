//
//  Communicator.h
//  news
//
//  Created by Женя Михайлова on 13.02.14.
//  Copyright (c) 2014 Женя Михайлова. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol CommunicatorDelegate;

@interface Communicator : NSObject
@property (weak, nonatomic) id<CommunicatorDelegate> delegate;

- (void)searchNews;
- (void)searcNewsByCitiesAndPage:(NSArray *)cities atPage:(NSString *)page;
- (void)searchCities;

@end