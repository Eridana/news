//
//  JsonParser.m
//  news
//
//  Created by Женя Михайлова on 13.02.14.
//  Copyright (c) 2014 Женя Михайлова. All rights reserved.
//

#import "JsonParser.h"
#import "NewsHelper.h"
#import "News.h"

@implementation JsonParser

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
            if([key isEqualToString:@"id"]) {
                [new setValue:[newsDic valueForKey:key] forKey:@"news_id"];
            }
            if ([new respondsToSelector:NSSelectorFromString(key)]) {
                if([newsDic objectForKey:key] != [NSNull null]) {
                    [new setValue:[newsDic valueForKey:key] forKey:key];
                }
            }
        }
        // a lot of time
        if([[NewsHelper sharedInstance] containsNews:new] == NO) {
            [news addObject:new];
        }
    }
    
    return news;
}

@end
