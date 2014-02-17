//
//  JsonParser.h
//  news
//
//  Created by Женя Михайлова on 13.02.14.
//  Copyright (c) 2014 Женя Михайлова. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonParser : NSObject

+ (NSArray *)newsFromJSON:(NSData *)objectNotation error:(NSError **)error;
+ (NSArray *)citiesFromJSON:(NSData *)objectNotation error:(NSError **)error;

@end
