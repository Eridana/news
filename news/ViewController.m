//
//  ViewController.m
//  news
//
//  Created by Женя Михайлова on 13.02.14.
//  Copyright (c) 2014 Женя Михайлова. All rights reserved.
//

#import "ViewController.h"
#import "City.h"
#import "News.h"
#import "DetailCell.h"
#import "Manager.h"
#import "Communicator.h"
#import "Settings.h"
#import "SettingsViewController.h"

@interface ViewController () <ManagerDelegate, UITableViewDataSource, UITableViewDelegate> {
    Manager *_manager;
    NSArray *_cities;
    NSArray *_news;
    NSInteger _pageCount;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addSettingsButton];
    [self.view addSubview:_tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.navigationController.navigationBar.translucent = NO;
    
    _manager = [[Manager alloc] init];
    _manager.communicator = [[Communicator alloc] init];
    _manager.communicator.delegate = _manager;
    _manager.delegate = self;
    _pageCount = 1;
    _cities = [[Settings  sharedInstance] getSelectedCities];
    [_manager fetchCities];
    [_manager fetchNewsByCitiesAndPage: _cities atPage:[NSString stringWithFormat:@"%d", _pageCount]];
}

-(void)addSettingsButton
{
    UIButton *settingsButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [settingsButton setFrame:CGRectMake(10.0, 2.0, 25.0, 25.0)];
    [settingsButton addTarget:self action:@selector(showSettings:) forControlEvents:UIControlEventTouchUpInside];
    [settingsButton setImage:[UIImage imageNamed:@"settings_gray_44.png"] forState:UIControlStateNormal];
    UIBarButtonItem *button = [[UIBarButtonItem alloc]initWithCustomView:settingsButton];
    self.navigationItem.rightBarButtonItem = button;
}

-(void)showSettings:(UIButton *)sender
{
    SettingsViewController *settingsController = [self.storyboard instantiateViewControllerWithIdentifier:@"settingsViewController"];
    [self.navigationController pushViewController:settingsController animated:YES];
}

-(NSArray *)getNewsByCity:(City *)city
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (News *news in _news) {
        if ([[NSString stringWithFormat:@"%@", news.city_id]
             isEqualToString:[NSString stringWithFormat:@"%@", city.city_id]]) {
            [result addObject:news];
        }
    }
    return [result copy];
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if (indexPath) {
            if ([segue.identifier isEqualToString:@"showDetails"]) {
                if ([segue.destinationViewController respondsToSelector:@selector(setDetails:)]) {
                    id cell = [self.tableView cellForRowAtIndexPath:indexPath];
                    NSArray *newsByCity = [self getNewsByCity:_cities[indexPath.section]];
                    [segue.destinationViewController performSelector:@selector(setDetails:)
                                                          withObject:newsByCity[indexPath.row]];
                }
            }
        }
    }
}

#pragma mark - ManagerDelegate
- (void)didReceiveCities:(NSArray *)cities
{
//    [Settings initSelectedCitiesWithArray:cities];
//    [Settings initAllCitiesWithArray:cities];
//    [self.tableView reloadData];
}

- (void)didReceiveNews:(NSArray *)news
{
    if(![_news lastObject]) {
        _news = news;
    }
    else{
        NSMutableArray *news2 = [_news mutableCopy];
        [news2 addObjectsFromArray:news];
        _news = news2;
    }
    [self.tableView reloadData];
}

- (void)fetchingFailedWithError:(NSError *)error
{
    NSLog(@"Error %@; %@", error, [error localizedDescription]);
}

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self getNewsByCity:_cities[section]].count;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSInteger currentOffset = scrollView.contentOffset.y;
    NSInteger maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
    // 60 до конца скролла в таблице
    if (maximumOffset - currentOffset <= -60) {
        _pageCount++;
        [_manager fetchNewsByCitiesAndPage: _cities atPage:[NSString stringWithFormat:@"%d", _pageCount]];
        [self.tableView reloadData];
        NSLog(@"reload");
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSArray *newsByCity = [self getNewsByCity:_cities[indexPath.section]];
    News *new = newsByCity[indexPath.row];
    [cell.titleTextView setText:new.title];
    [cell.dateLabel setText:new.published_at];
    if(new.city) {
        [cell.cityLabel setText:[new.city name]];
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_cities count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_cities[section] name];
}

@end
