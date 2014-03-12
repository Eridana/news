//
//  Settings.m
//  news
//
//  Created by Женя Михайлова on 28.02.14.
//  Copyright (c) 2014 Женя Михайлова. All rights reserved.
//

#import "Settings.h"
static NSMutableArray * selectedCities;

@implementation Settings

+(NSArray *) selectedCities
{
    if(!selectedCities) {
        City * defaultCity = [[City alloc] init];
        defaultCity.city_id = @"4";
        defaultCity.name = @"Уфа";
        [self initSelectedCitiesWithArray: @[defaultCity]];
    }
    return selectedCities;
}

+(void)initSelectedCitiesWithArray:(NSArray *)cities
{
    selectedCities = [[NSMutableArray alloc] initWithArray:cities];
}

//+ (void) setSelectedCities: (NSArray *) value
//{
//    selectedCities = [value mutableCopy];
//}

+(void)addSelectedCity:(City *)city
{
    if(![selectedCities containsObject:city])
    {
        [selectedCities addObject:city];
    }
}

+(void)removeSelectedCity:(City *)city
{
    [selectedCities removeObject:city];
}

@end
