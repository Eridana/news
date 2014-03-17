//
//  NewsHelper.h
//  news
//
//  Created by Женя Михайлова on 16.03.14.
//  Copyright (c) 2014 Женя Михайлова. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ManagerDelegate.h"
#import "News.h"
#import "City.h"

@interface NewsHelper : NSObject

@property (strong , nonatomic) NSMutableArray *allNews;

+ (NewsHelper *)sharedInstance;

-(void)setNews:(NSArray *)news;
-(void)cleanNews;
-(NSArray *)getNewsByCity:(City *)city;

@end
