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

@interface ViewController () <ManagerDelegate, UITableViewDataSource,UITableViewDelegate> {
    Manager *_manager;
    NSArray *_cities;
    NSArray *_news;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:_tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    _manager = [[Manager alloc] init];
    _manager.communicator = [[Communicator alloc] init];
    _manager.communicator.delegate = _manager;
    _manager.delegate = self;
    
    [_manager fetchCities];
    [_manager fetchNews];
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
                    [segue.destinationViewController performSelector:@selector(setDetails:) withObject:_news[indexPath.row]];
                }
            }
        }
    }
}

#pragma mark - ManagerDelegate
- (void)didReceiveCities:(NSArray *)cities
{
    _cities = cities;
   // [self.tableView reloadData];
}

- (void)didReceiveNews:(NSArray *)news
{
    _news = news;
    [self.tableView reloadData];
}

- (void)fetchingFailedWithError:(NSError *)error
{
    NSLog(@"Error %@; %@", error, [error localizedDescription]);
}

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _news.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    News *new = _news[indexPath.row];
    [cell.titleTextView setText:new.title];
    [cell.dateLabel setText:new.published_at];
    [cell.cityLabel setText:new.city];
    
    return cell;
}

@end
