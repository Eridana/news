//
//  Settings.m
//  news
//
//  Created by Женя Михайлова on 28.02.14.
//  Copyright (c) 2014 Женя Михайлова. All rights reserved.
//

#import "Settings.h"
#import "City.h"

 //NSMutableArray * selectedCities;
 NSMutableArray * allCities;

@implementation Settings

+ (Settings *)sharedInstance
{
    static Settings * _sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[Settings alloc] init];
    });
    return _sharedInstance;
}


- (id)init
{
    self = [super init];
    if (self) {
        NSData * data = [NSData dataWithContentsOfFile:[NSHomeDirectory() stringByAppendingString:@"/Documents/all_cities.bin"]];
        allCities = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        if (allCities == nil) {
            allCities = [NSMutableArray arrayWithArray:[self getCitiesArray]];
            [self saveCities];
        }
    }
    return self;
}


-(NSArray *)getCitiesArray
{
    return
    @[
        [[City alloc] initWithId: @"4" name: @"Уфа"         selected: YES],
        [[City alloc] initWithId: @"7" name: @"Белебей"     selected: YES],
        [[City alloc] initWithId: @"1" name: @"Ишимбай"     selected: YES],
        [[City alloc] initWithId: @"5" name: @"Нефтекамск"  selected: YES],
        [[City alloc] initWithId: @"8" name: @"Октябрьский" selected: YES],
        [[City alloc] initWithId: @"2" name: @"Салават"     selected: YES],
        [[City alloc] initWithId: @"3" name: @"Стерлитамак" selected: YES]
    ];
}


-(void)saveCities
{
    NSString * filename = [NSHomeDirectory() stringByAppendingString:@"/Documents/all_cities.bin"];
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:allCities];
    [data writeToFile:filename atomically:YES];
}


-(NSArray *) getSelectedCities
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (City *city in allCities) {
        if(city && city.selected == YES) {
            [result addObject:city];
        }
    }
    return result;
}


-(NSArray *) getAllCities
{
    return allCities;
}


-(City *)getCityById:(NSString *)byId
{
    City *result = [[City alloc] init];
    for (City *city in allCities) {
        if(city) {
            if(city.city_id == byId) {
                result = city;
                break;
            }
        }
    }
    return result;
}


-(void)selectCity:(City *)city
{
    city.selected = YES;
}


-(void)unselectCity:(City *)city
{
    city.selected = NO;
}

@end
