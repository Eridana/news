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

-(void)setPublished_at:(NSString *)published_at
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZ"];
    published_at =[self removeColonFromTimeZoneInDate:published_at];
    _date= [dateFormatter dateFromString:published_at];
}

- (NSString *)removeColonFromTimeZoneInDate:(NSString *)dateAsString {
       return [dateAsString stringByReplacingOccurrencesOfString:@":"
                                           withString:@""
                                              options:0
                                                range:NSMakeRange([dateAsString length] - 5,5)];
}

@end
