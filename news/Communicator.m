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
    for (int i = 0; i < cities.count; i++) {
        City *city = [cities objectAtIndex:i];
        if(city.selected == NO) continue;
        
        NSString *urlAsString = [NSString stringWithFormat:@"http://rbcitynews.ru/api/v1/cities/%@/news.json?page=%@", city.city_id, page];
        NSURL *url = [[NSURL alloc] initWithString:urlAsString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        // возможно все это нужно делать через NSOperationQueue.
        [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            if (error) {
                [self.delegate fetchingFailedWithError:error];
            }
            else {
                [self.delegate receivedNewsJSON:data];
            }
        }];
    }
    [self.delegate sendNews];
}

- (void)searchNews
{
    if(![[Settings sharedInstance] getSelectedCities]) {
        [self searcNewsByCitiesAndPage: [[Settings sharedInstance] getSelectedCities] atPage: @"1"];
    }
    else {
        NSURLRequest *request = [NSURLRequest requestWithURL:[[NSURL alloc] initWithString:@"http://rbcitynews.ru/api/v1/news.json"]];
        [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            if (error) {
                [self.delegate fetchingFailedWithError:error];
            } else {
                [self.delegate receivedNewsJSON:data];
            }
        }];
    }
}

@end
