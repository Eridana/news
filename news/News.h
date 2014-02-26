//
//  News.h
//  news
//
//  Created by Женя Михайлова on 13.02.14.
//  Copyright (c) 2014 Женя Михайлова. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject

//@property (strong, nonatomic) NSString *news_id;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSString *summary;
@property (strong, nonatomic) NSString *city_id;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *published_at;
@property (strong, nonatomic) NSString *legacy_url;



@end
