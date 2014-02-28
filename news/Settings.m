//
//  Settings.m
//  news
//
//  Created by Женя Михайлова on 28.02.14.
//  Copyright (c) 2014 Женя Михайлова. All rights reserved.
//

#import "Settings.h"
static NSDictionary * selectedCities;

@implementation Settings

+(NSDictionary *) selectedCities
{
    return selectedCities;
}

+ (void) setSelectedCities: (NSDictionary *) value
{
    selectedCities = value;
}

@end
