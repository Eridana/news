//
//  Settings.h
//  news
//
//  Created by Женя Михайлова on 28.02.14.
//  Copyright (c) 2014 Женя Михайлова. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "City.h"
#import "News.h"

@interface Settings : NSObject

+ (Settings *)sharedInstance;

-(NSMutableArray *)getSelectedCities;
-(NSMutableArray *)getAllCities;
-(City *)getCityById:(NSString *)byId;
//-(void)initAllCitiesWithArray:(NSArray *)cities;
//-(void)initSelectedCitiesWithArray:(NSArray *)cities;
-(void)addSelectedCity:(City *)city;
-(void)removeSelectedCity:(City *)city;

-(NSMutableArray *)allNews;
-(void)initAllNewsWithArray:(NSArray *)news;
-(NSArray *)getNewsByCity:(City *)city;

- (void)saveSelectedSities;

@end
