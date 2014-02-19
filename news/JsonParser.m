//
//  JsonParser.m
//  news
//
//  Created by Женя Михайлова on 13.02.14.
//  Copyright (c) 2014 Женя Михайлова. All rights reserved.
//

#import "JsonParser.h"
#import "City.h"
#import "News.h"

@implementation JsonParser

+ (NSArray *)citiesFromJSON:(NSData *)objectNotation error:(NSError **)error
{
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:objectNotation options:0 error:&localError];
    
    if (localError != nil) {
        *error = localError;
        return nil;
    }
    
    NSMutableArray *cities = [[NSMutableArray alloc] init];
    
    NSArray *results = [parsedObject valueForKey:@"cities"];
    
    for (NSDictionary *cityDic in results) {
        City *city = [[City alloc] init];
        
        for (NSString *key in cityDic) {
            if ([city respondsToSelector:NSSelectorFromString(key)]) {
                [city setValue:[cityDic valueForKey:key] forKey:key];
            }
        }
        
        [cities addObject:city];
    }
    
    return cities;

}

+ (NSArray *)newsFromJSON:(NSData *)objectNotation error:(NSError **)error
{
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:objectNotation options:0 error:&localError];
    
    if (localError != nil) {
        *error = localError;
        return nil;
    }
    
    NSMutableArray *news = [[NSMutableArray alloc] init];
    
    NSArray *results = [parsedObject valueForKey:@"news"];
    
    for (NSDictionary *newsDic in results) {
        News *new = [[News alloc] init];
        
        for (NSString *key in newsDic) {
            if ([new respondsToSelector:NSSelectorFromString(key)]) {
                [new setValue:[newsDic valueForKey:key] forKey:key];
            }
        }
        
        [news addObject:new];
    }
    
    return news;
}

@end
