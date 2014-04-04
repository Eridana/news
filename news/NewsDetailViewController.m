//
//  NewsDetailViewController.m
//  news
//
//  Created by Женя Михайлова on 17.02.14.
//  Copyright (c) 2014 Женя Михайлова. All rights reserved.
//

#import "NewsDetailViewController.h"

@interface NewsDetailViewController () {
    News *_news;
    NSUInteger _currentNewsIndex;
    NSMutableArray *_displayNews;
}
@end

@implementation NewsDetailViewController

-(void)viewDidLoad
{
    //[super viewDidLoad]; // это вызывает и индикатор загрузки тоже.
    self.navigationController.navigationBar.translucent = NO;
    
    UISwipeGestureRecognizer *upSwipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(loadNext:)];
    [upSwipeRecognizer setDirection:UISwipeGestureRecognizerDirectionLeft];
    [[self view] addGestureRecognizer:upSwipeRecognizer];
    // возможно swipe влево должен выходить обратно на первый контроллер, нужно уточнить.
    UISwipeGestureRecognizer *downSwipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(loadPrevious:)];
    [downSwipeRecognizer setDirection:UISwipeGestureRecognizerDirectionRight];
    [[self view] addGestureRecognizer:downSwipeRecognizer];
    
    _displayNews = [[NSMutableArray alloc] init];
    
    NSMutableArray *selectedCities = [[Settings sharedInstance] getSelectedCities];
    for (City *city in selectedCities) {
        [_displayNews addObjectsFromArray: [[NewsHelper sharedInstance] getNewsByCity:city]];
    }
    
    _currentNewsIndex = 0;
}

-(void) setDetails:(News *)details
{
    _details = details;
    [self updateDetails];
}

-(void)updateDetails
{
    if(!_displayNews) {
        [self viewDidLoad];
    }
    else {
        _currentNewsIndex = [_displayNews indexOfObjectIdenticalTo: _details];
    }
    [self.detailTitle setText:_details.title];
    [self.summary setText:_details.summary];
    [self.dateLabel setText:_details.dateAsString];
    if(_details.city) {
        [self.cityLabel setText:_details.city.name];
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

-(IBAction)loadNext:(UISwipeGestureRecognizer *)gesture
{
    [self loadNewsForIndex:_currentNewsIndex];
    if(_currentNewsIndex ==  [_displayNews count] - 1) {
        _currentNewsIndex = 0;
    }
    _currentNewsIndex++;
}

-(IBAction)loadPrevious:(UISwipeGestureRecognizer *)gesture
{
    [self loadNewsForIndex:_currentNewsIndex];
    if(_currentNewsIndex == 0) {
        _currentNewsIndex = [_displayNews count] - 1;
    }
    _currentNewsIndex--;
}
    
-(void)loadNewsForIndex:(NSUInteger)index
{
    if(index < [_displayNews count]) {
        [self setDetails:_displayNews[index]];
    }
}
    
@end

