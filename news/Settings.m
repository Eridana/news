//
//  Settings.m
//  news
//
//  Created by Женя Михайлова on 28.02.14.
//  Copyright (c) 2014 Женя Михайлова. All rights reserved.
//

#import "Settings.h"
#import "City.h"

 NSMutableArray * selectedCities;
 NSMutableArray * allCities;
 NSMutableArray * allNews;

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
        NSData * data = [NSData dataWithContentsOfFile:[NSHomeDirectory() stringByAppendingString:@"/Documents/selected_cities.bin"]];
        selectedCities = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        if (selectedCities == nil) {
            selectedCities = [NSMutableArray arrayWithArray:[self getCitiesArray]];
            [self saveSelectedSities];
        }
        if(allCities == nil) {
            allCities = [NSMutableArray arrayWithArray:[self getCitiesArray]];
        }
    }
    return self;
}
                              
-(NSArray *)getCitiesArray
{
    return
    @[
        [[City alloc] initWithId: @"4" name: @"Уфа"],
        [[City alloc] initWithId: @"7" name: @"Белебей"],
        [[City alloc] initWithId: @"1" name: @"Ишимбай"],
        [[City alloc] initWithId: @"5" name: @"Нефтекамск"],
        [[City alloc] initWithId: @"8" name: @"Октябрьский"],
        [[City alloc] initWithId: @"2" name: @"Салават"],
        [[City alloc] initWithId: @"3" name: @"Стерлитамак"]
    ];
}

-(void)saveSelectedSities
{
    NSString * filename = [NSHomeDirectory() stringByAppendingString:@"/Documents/selected_cities.bin"];
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:selectedCities];
    [data writeToFile:filename atomically:YES];
}

-(NSArray *) allNews
{
    if(!allNews) {
        return [[NSArray alloc] init];
    }
    return allNews;
}

-(void)initAllNewsWithArray:(NSArray *)news
{
    allNews = [[NSMutableArray alloc] initWithArray:news];
}

-(NSArray *)getNewsByCity:(City *)city
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (News *news in allNews) {
        if ([[NSString stringWithFormat:@"%@", news.city_id]
             isEqualToString:[NSString stringWithFormat:@"%@", city.city_id]]) {
             [result addObject:news];
         }
    }
    return [result copy];
}

-(NSArray *) getSelectedCities
{
    return selectedCities;
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

//
//-(void)initSelectedCitiesWithArray:(NSArray *)cities
//{
//    selectedCities = [[NSMutableArray alloc] initWithArray:cities];
//}
//
//-(void)initAllCitiesWithArray:(NSArray *)cities
//{
//    allCities = [[NSMutableArray alloc] initWithArray:cities];
//}

-(void)addSelectedCity:(City *)city
{
    if(![selectedCities containsObject:city])
    {
        [selectedCities addObject:city];
    }
}

-(void)removeSelectedCity:(City *)city
{
    [selectedCities removeObject:city];
}

@end
