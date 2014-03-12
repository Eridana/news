//
//  City.m
//  news
//
//  Created by Женя Михайлова on 13.02.14.
//  Copyright (c) 2014 Женя Михайлова. All rights reserved.
//

#import "City.h"

static NSArray * cities;

@implementation City

//+(NSDictionary *)cities
//{
////    return @{  @"Ишимбай" : @"1",
////               @"Салават" : @"2",
////               @"Стерлитамак" : @"3",
////               @"Уфа" : @"4",
////               @"Нефтекамск" : @"5",
////               @"Белебей" : @"7",
////               @"Октябрьский" : @"8"
////            };
//    return @{
//               @"1" :@"Ишимбай",
//               @"2" : @"Салават",
//               @"3" : @"Стерлитамак",
//               @"4" : @"Уфа",
//               @"5" : @"Нефтекамск",
//               @"7" : @"Белебей",
//               @"8" : @"Октябрьский"
//            };
//}

//+(NSString *)getNameById:(NSString *)byId
//{
//    return [cities valueForKey:byId];
//}
//
//-(NSString *)name
//{
//    return [cities valueForKey:_city_id];
//}

+(NSArray *)cities
{
    return cities;
}

+(void)initCitiesWithArray:(NSArray *)cities
{
    if(!cities) {
        cities = [[NSArray alloc] initWithArray:cities];
    }
}

@end
