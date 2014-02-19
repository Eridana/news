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
    // почему-то sendAsynchronousRequest не работает.
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://rbcitynews.ru/api/v1/news.json"]];
//    
//    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//        
//        if (error) {
//            [self.delegate fetchingFailedWithError:error];
//        } else {
//            [self.delegate receivedNewsJSON:data];
//        }
//    }];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[[NSURL alloc] initWithString:@"http://rbcitynews.ru/api/v1/news.json"]];
    NSError *error = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    if (error) {
        [self.delegate fetchingFailedWithError:error];
    } else {
        [self.delegate receivedNewsJSON:response];
    }
}


- (void)searchCities
{
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://rbcitynews.ru/api/v1/cities.json"]];
//
//    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//        
//        if (error) {
//            [self.delegate fetchingFailedWithError:error];
//        } else {
//            [self.delegate receivedCitiesJSON:data];
//        }
//    }];

    NSURLRequest *request = [NSURLRequest requestWithURL:[[NSURL alloc] initWithString:@"http://rbcitynews.ru/api/v1/cities.json"]];
    NSError *error = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    if (error) {
        [self.delegate fetchingFailedWithError:error];
    } else {
        [self.delegate receivedCitiesJSON:response];
    }
}


@end
