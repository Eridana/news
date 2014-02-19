//
//  News.m
//  news
//
//  Created by Женя Михайлова on 13.02.14.
//  Copyright (c) 2014 Женя Михайлова. All rights reserved.
//

#import "News.h"
#import "City.h"

@implementation News

-(void)setCity:(NSString *)city
{
    _city = [City getNameById:city];
}

@end
