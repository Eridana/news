//
//  Settings.h
//  news
//
//  Created by Женя Михайлова on 28.02.14.
//  Copyright (c) 2014 Женя Михайлова. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "City.h"

@interface Settings : NSObject
+(NSMutableArray *)selectedCities;
+(void)initSelectedCitiesWithArray:(NSArray *)cities;
+(void)addSelectedCity:(City *)city;
+(void)removeSelectedCity:(City *)city;
@end
