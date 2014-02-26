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

-(void)searcNewsByCitiesAndPage:(NSArray *)cities atPage:(NSString *)page
{
    // example - http://rbcitynews.ru/api/v1/cities/1/news.json?page=2
    
    NSString *urlAsString = [NSString stringWithFormat:@"http://rbcitynews.ru/api/v1/cities/%@/news.json?page=%@", [cities objectAtIndex:0], page];
    NSURL *url = [[NSURL alloc] initWithString:urlAsString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSError *error = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    if (error) {
        [self.delegate fetchingFailedWithError:error];
    } else {
        [self.delegate receivedNewsJSON:response];
    }
}

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
