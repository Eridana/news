//
//  City.m
//  news
//
//  Created by Женя Михайлова on 13.02.14.
//  Copyright (c) 2014 Женя Михайлова. All rights reserved.
//

#import "City.h"

static NSDictionary * cities;

@implementation City

+(NSDictionary *)cities
{
    return @{@"Ишимбай" : @"1",
               @"Салават" : @"2",
               @"Стерлитамак" : @"3",
               @"Уфа" : @"4",
               @"Нефтекамск" : @"5",
               @"Белебей" : @"7",
               @"Октябрьский" : @"8"
               };
}

+(NSString *)getNameById:(NSString *)id
{
    return [cities valueForKey:id];
}

-(NSString *)name
{
    return [cities valueForKey:_city_id];
}

@end
