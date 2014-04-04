//
//  NewsDetailViewController.h
//  news
//
//  Created by Женя Михайлова on 17.02.14.
//  Copyright (c) 2014 Женя Михайлова. All rights reserved.
//

#import "ViewController.h"
#import "News.h"
#import "Settings.h"
#import "NewsHelper.h"

@interface NewsDetailViewController : ViewController
@property (weak, nonatomic) IBOutlet UITextView *detailTitle;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UITextView *summary;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property(strong, nonatomic) News *details;

-(void)setDetails:(News *)details;
-(void)loadNewsForIndex:(NSUInteger)index;

@end
