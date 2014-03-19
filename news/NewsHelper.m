//
//  NewsHelper.m
//  news
//
//  Created by Женя Михайлова on 16.03.14.
//  Copyright (c) 2014 Женя Михайлова. All rights reserved.
//

#import "NewsHelper.h"

@interface NewsHelper () //<ManagerDelegate>
{
    NSMutableArray * _news;
}
@end

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
        if(!_news) {
            _news = [[NSMutableArray alloc] init];
        }
        if(!_allNews)
        {
            _allNews = [[NSMutableArray alloc] init];
        }
        
    }
    return self;
}

-(void)setNews:(NSArray *)news
{
    [_news addObjectsFromArray: news];
    [_allNews addObjectsFromArray:news];
}

-(void)clearNews
{
    [_news removeAllObjects];
}

-(NSArray *)getNewsByCity:(City *)city
{
    if(city.selected == NO) return [[NSArray alloc] init];
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (News *news in [_news copy]) {
        if ([[NSString stringWithFormat:@"%@", news.city_id]
             isEqualToString:[NSString stringWithFormat:@"%@", city.city_id]]) {
            [result addObject:news];
        }
    }
    return [result copy];
}

//#pragma mark - ManagerDelegate
//- (void)didReceiveCities:(NSArray *)cities
//{
//    //    [[Settings sharedInstance] initWithCities:cities];
//    //    [self.tableView reloadData];
//}
//
//- (void)didReceiveNews:(NSArray *)news
//{
//    [_news addObjectsFromArray: news];
//}
//
//- (void)fetchingFailedWithError:(NSError *)error
//{
//    NSLog(@"Error %@; %@", error, [error localizedDescription]);
//}

@end
