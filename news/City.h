//
//  City.h
//  news
//
//  Created by Женя Михайлова on 13.02.14.
//  Copyright (c) 2014 Женя Михайлова. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject

+(NSDictionary *)cities;
+(NSString *)getNameById:(NSString *)id;

@property (strong, nonatomic) NSString *city_id;
@property (strong, nonatomic) NSString *name;

@end
