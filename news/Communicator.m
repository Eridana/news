//
//  Communicator.m
//  news
//
//  Created by Женя Михайлова on 13.02.14.
//  Copyright (c) 2014 Женя Михайлова. All rights reserved.
//

#import "Communicator.h"
#import "CommunicatorDelegate.h"
#import "City.h"
#import "Settings.h"

@implementation Communicator

-(void)searcNewsByCitiesAndPage:(NSArray *)cities atPage:(NSString *)page
{
    // example - http://rbcitynews.ru/api/v1/cities/1/news.json?page=2
    // нужно это наверное как-то пределать. и сделать sendAsynchronousRequest
    for (int i = 0; i < cities.count; i++) {
        City *city = [cities objectAtIndex:0];
        NSString *urlAsString = [NSString stringWithFormat:@"http://rbcitynews.ru/api/v1/cities/%@/news.json?page=%@", city.city_id, page];
        NSURL *url = [[NSURL alloc] initWithString:urlAsString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSError *error = nil;
        NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
        
        if (error) {
            [self.delegate fetchingFailedWithError:error];
        }
        else {
            [self.delegate receivedNewsJSON:response];
        }
    }
    [self.delegate sendNews];
}

- (void)searchNews
{
    if(![Settings selectedCities]) {
        [self searcNewsByCitiesAndPage: [Settings selectedCities] atPage: @"1"];
    }
    else {
        NSURLRequest *request = [NSURLRequest requestWithURL:[[NSURL alloc] initWithString:@"http://rbcitynews.ru/api/v1/news.json"]];
        NSError *error = nil;
        NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
        
        if (error) {
            [self.delegate fetchingFailedWithError:error];
        } else {
            [self.delegate receivedNewsJSON:response];
        }
    }
        
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
