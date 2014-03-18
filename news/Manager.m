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
   //NSMutableArray *news;
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

#pragma mark - CommunicatorDelegate

-(void)sendNews
{
     //[self.delegate didReceiveNews:[news copy]];
}

- (void)receivedNewsJSON:(NSData *)objectNotation
{
    NSError *error = nil;
    NSArray *data = [JsonParser newsFromJSON:objectNotation error:&error];
    if (error != nil) {
        [self.delegate fetchingFailedWithError:error];
        
    }
  else {
        [self.delegate didReceiveNews:data];
    }
}

- (void)fetchingFailedWithError:(NSError *)error
{
    [self.delegate fetchingFailedWithError:error];
}
@end
