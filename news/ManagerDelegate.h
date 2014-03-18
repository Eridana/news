//
//  ManagerDelegate.h
//  news
//
//  Created by Женя Михайлова on 13.02.14.
//  Copyright (c) 2014 Женя Михайлова. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ManagerDelegate
- (void)didReceiveNews:(NSArray *)news;
- (void)fetchingFailedWithError:(NSError *)error;
@end
