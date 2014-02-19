//
//  NewsDetailViewController.m
//  news
//
//  Created by Женя Михайлова on 17.02.14.
//  Copyright (c) 2014 Женя Михайлова. All rights reserved.
//

#import "NewsDetailViewController.h"

@interface NewsDetailViewController ()

@end

@implementation NewsDetailViewController

-(void) setDetails:(News *)details
{
    _details = details;
    [self updateDetails];
}

-(void)updateDetails
{
    [self.detailTitle setText:_details.title];
    [self.summary setText:_details.summary];
    [self.dateLabel setText:_details.published_at];
    [self.linkLabel setText:_details.rbcitynews_url];
    [self.cityLabel setText:_details.city];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateDetails];
  }

@end