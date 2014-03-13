//
//  News.m
//  news
//
//  Created by Женя Михайлова on 13.02.14.
//  Copyright (c) 2014 Женя Михайлова. All rights reserved.
//

#import "News.h"
#import "Settings.h"

@implementation News

-(id)init
{
    self = [super init];
    return self;
}

-(void)setCity_id:(NSString *)city_id
{
    _city = [[Settings sharedInstance] getCityById:city_id];
    _city_id = city_id;
}

@end
