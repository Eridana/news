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

@interface Manager() <CommunicatorDelegate> {
   NSMutableArray *news;
}
@end

@implementation Manager
- (void)fetchNews
{
    [self.communicator searchNews];
}

-(void)fetchNewsByCitiesAndPage:(NSArray *)cities atPage:(NSString *)page
{
    [self.communicator searcNewsByCitiesAndPage:cities atPage:page];
}

- (void)fetchCities
{
    [self.communicator searchCities];
}

#pragma mark - CommunicatorDelegate

-(void)sendNews
{
     [self.delegate didReceiveNews:[news copy]];
}

- (void)receivedNewsJSON:(NSData *)objectNotation
{
    NSError *error = nil;
    NSArray *data = [JsonParser newsFromJSON:objectNotation error:&error];
    if (error != nil) {
        [self.delegate fetchingFailedWithError:error];
        
    }
  else {
//        [self.delegate didReceiveNews:news];
      if(!news) {
          news = [[NSMutableArray alloc] initWithArray:data];
      }
      else {
          [news addObjectsFromArray:data];
      }
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
