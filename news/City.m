//
//  City.m
//  news
//
//  Created by Женя Михайлова on 13.02.14.
//  Copyright (c) 2014 Женя Михайлова. All rights reserved.
//

#import "City.h"

@implementation City

-(id)init
{
    self = [super init];
    return self;
}

-(id)initWithId:(NSString *)city_id name:(NSString *)city_name
{
    self = [self init];
    if (self) {
        self.city_id = city_id;
        self.name = city_name;
    }
    return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.city_id forKey:@"city_id"];
    [aCoder encodeObject:self.name forKey:@"name"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        _city_id = [aDecoder decodeObjectForKey:@"city_id"];
        _name = [aDecoder decodeObjectForKey:@"name"];
    }
    return self;
}

@end
