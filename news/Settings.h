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
-(void)selectCity:(City *)city;
-(void)unselectCity:(City *)city;

- (void)saveSelectedSities;

@end
