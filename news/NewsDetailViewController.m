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

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
}

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
    if(_details.city) {
        [self.cityLabel setText:[_details.city name]];
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateDetails];
  }

- (IBAction)goToNew:(id)sender {
    if([_details.legacy_url description]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: [_details.legacy_url description]]];
    }
}

@end
