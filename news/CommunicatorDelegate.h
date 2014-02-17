//
//  CommunicatorDelegate.h
//  news
//
//  Created by Женя Михайлова on 13.02.14.
//  Copyright (c) 2014 Женя Михайлова. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CommunicatorDelegate
- (void)receivedNewsJSON:(NSData *)objectNotation;
- (void)receivedCitiesJSON:(NSData *)objectNotation;
- (void)fetchingFailedWithError:(NSError *)error;
@end
