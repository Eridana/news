//
//  NewsHelper.m
//  news
//
//  Created by Женя Михайлова on 16.03.14.
//  Copyright (c) 2014 Женя Михайлова. All rights reserved.
//

#import "NewsHelper.h"

@implementation NewsHelper

+ (NewsHelper *)sharedInstance
{
    static NewsHelper * _sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[NewsHelper alloc] init];
    });
    return _sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        if(!_allNews) {
            _allNews = [[NSMutableArray alloc] init];            
        }
    }
    return self;
}

-(void)setNews:(NSArray *)news
{
    // проверять на повторения
    [_allNews addObjectsFromArray:news];
}

-(NSArray *)getNewsByCity:(City *)city
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (News *news in [_allNews copy]) {
        if ([[NSString stringWithFormat:@"%@", news.city_id]
             isEqualToString:[NSString stringWithFormat:@"%@", city.city_id]]) {
            [result addObject:news];
        }
    }
    return result;
}

-(BOOL) containsNews:(News *)news
{
    if(news && news.news_id) {
        NSArray *resultsArray = [_allNews filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"%K == %@", @"news_id", news.news_id]];
        return resultsArray.count > 0;
    }
    return NO;
}

@end
