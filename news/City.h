//
//  City.h
//  news
//
//  Created by Женя Михайлова on 13.02.14.
//  Copyright (c) 2014 Женя Михайлова. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject

@property (strong, nonatomic) NSString *city_id;
@property (strong, nonatomic) NSString *name;
@property (nonatomic) BOOL selected;

-(id)initWithId:(NSString *)city_id name:(NSString *)city_name selected:(BOOL) isSelected;
-(id)init;
@end
