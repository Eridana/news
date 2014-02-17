//
//  Manager.m
//  news
//
//  Created by Женя Михайлова on 13.02.14.
//  Copyright (c) 2014 Женя Михайлова. All rights reserved.
//

#import "Manager.h"
#import "JsonParser.h"
#import "Communicator.h"

@implementation Manager
- (void)fetchNews
{
    [self.communicator searchNews];
}

- (void)fetchCities
{
    [self.communicator searchCities];
}

#pragma mark - CommunicatorDelegate

- (void)receivedNewsJSON:(NSData *)objectNotation
{
    NSError *error = nil;
    NSArray *news = [JsonParser newsFromJSON:objectNotation error:&error];
    
    if (error != nil) {
        [self.delegate fetchingFailedWithError:error];
        
    } else {
        [self.delegate didReceiveNews:news];
    }
}

- (void)receivedCitiesJSON:(NSData *)objectNotation
{
    NSError *error = nil;
    NSArray *cities = [JsonParser citiesFromJSON:objectNotation error:&error];
    
    if (error != nil) {
        [self.delegate fetchingFailedWithError:error];
        
    } else {
        [self.delegate didReceiveCities:cities];
    }
}

- (void)fetchingFailedWithError:(NSError *)error
{
    [self.delegate fetchingFailedWithError:error];
}
@end
