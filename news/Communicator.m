//
//  Communicator.m
//  news
//
//  Created by Женя Михайлова on 13.02.14.
//  Copyright (c) 2014 Женя Михайлова. All rights reserved.
//

#import "Communicator.h"
#import "CommunicatorDelegate.h"

@implementation Communicator

- (void)searchNews
{
//    NSString *urlAsString = @"http://rbcitynews.ru/api/v1/news.json";
//    NSURL *url = [[NSURL alloc] initWithString:urlAsString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://rbcitynews.ru/api/v1/news.json"]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (error) {
            [self.delegate fetchingFailedWithError:error];
        } else {
            [self.delegate receivedNewsJSON:data];
        }
    }];
}


- (void)searchCities
{
    //NSString *urlAsString = @"http://rbcitynews.ru/api/v1/cities";
    //NSURL *url = [[NSURL alloc] initWithString:urlAsString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://rbcitynews.ru/api/v1/cities.json"]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (error) {
            [self.delegate fetchingFailedWithError:error];
        } else {
          [self.delegate receivedCitiesJSON:data];
        }
    }];
}


@end
