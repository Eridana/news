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
#import "NewsHelper.h"

@interface ViewController () <ManagerDelegate, UITableViewDataSource, UITableViewDelegate> {
    UIActivityIndicatorView *_activityIndicator;
    Manager *_manager;
    NSDateFormatter *_dateFormatter;
    NSInteger _pageCount;
    BOOL _clearTable;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addButtons];
    [self.view addSubview:_tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.navigationController.navigationBar.translucent = NO;
    [self addPullToRefreshButton];
    
    _clearTable = NO;
    _dateFormatter = [[NSDateFormatter alloc] init];
    [_dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    
    _activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityIndicator.center = CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0);
    [self.tableView addSubview: _activityIndicator];
    
    [_activityIndicator startAnimating];
    
    _manager = [[Manager alloc] init];
    _manager.communicator = [[Communicator alloc] init];
    _manager.communicator.delegate = _manager;
    _manager.delegate = self;
    _pageCount = 1;
    [_manager fetchNewsByCitiesAndPage: [self getSelectedCities] atPage:[NSString stringWithFormat:@"%d", _pageCount]];
}


- (void)addPullToRefreshButton
{
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
}


-(void)addButtons
{
    UIButton *settingsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingsButton setFrame:CGRectMake(10.0, 2.0, 25.0, 25.0)];
    [settingsButton addTarget:self action:@selector(showSettings:) forControlEvents:UIControlEventTouchUpInside];
    [settingsButton setImage:[UIImage imageNamed:@"_settings_icon_48.png"] forState:UIControlStateNormal];
    UIBarButtonItem *uiSettingsButton = [[UIBarButtonItem alloc] initWithCustomView:settingsButton];
    
    UIButton *reloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [reloadButton setFrame:CGRectMake(10.0, 2.0, 25.0, 25.0)];
    [reloadButton addTarget:self action:@selector(reload:) forControlEvents:UIControlEventTouchUpInside];
    [reloadButton setImage:[UIImage imageNamed:@"_refresh_icon_48.png"] forState:UIControlStateNormal];
    UIBarButtonItem *uiReloadButton = [[UIBarButtonItem alloc] initWithCustomView:reloadButton];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:uiSettingsButton, uiReloadButton, nil];
    
    // add footer view
   [self addFooterToTableView];
}


-(void)addFooterToTableView
{
    // separator is dissappearing (ios7 bug)
    // will need to add activity indicator in footerview
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 2.0, 300.0, 60.0)];
    UIButton *loadMoreButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [loadMoreButton setTitle: @"Загрузить еще новости" forState:UIControlStateNormal];
    [loadMoreButton addTarget:self action:@selector(LoadMoreNews:) forControlEvents:UIControlEventTouchUpInside];
    [loadMoreButton setFrame:CGRectMake(10.0, 2.0, 300.0, 44.0)];
    [footerView addSubview:loadMoreButton];
    [self.tableView setTableFooterView:footerView];
}


-(void)showSettings:(UIButton *)sender
{
    SettingsViewController *settingsController = [self.storyboard instantiateViewControllerWithIdentifier:@"settingsViewController"];
    [self.navigationController pushViewController:settingsController animated:YES];
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
                    NSArray *newsByCity = [[NewsHelper sharedInstance] getNewsByCity:[self getSelectedCities][indexPath.section]];
                    [segue.destinationViewController performSelector:@selector(setDetails:)
                                                          withObject:newsByCity[indexPath.row]];
                }
            }
        }
    }
}


- (void) updateTable
{
    dispatch_async(dispatch_get_main_queue(), ^{
    [   self.tableView reloadData];
    });
}


- (void)refresh:(UIRefreshControl *)refreshControl {
    [_manager fetchNewsByCitiesAndPage: [self getSelectedCities] atPage:[NSString stringWithFormat:@"%d", 1]];
    [self updateTable];
    [refreshControl endRefreshing];
}

- (void)reloadTable
{
    _clearTable = YES;
    [self updateTable];
    _clearTable = NO;
    
    //[[NewsHelper sharedInstance] clearNews];
    _pageCount = 1;
    [_manager fetchNewsByCitiesAndPage: [self getSelectedCities] atPage:[NSString stringWithFormat:@"%d", _pageCount]];
}

-(void)reload:(UIButton *)sender
{
    [self reloadTable];
}


-(void)updateData:(UIButton *)sender
{
    [self updateTable];
}

#pragma mark - ManagerDelegate

- (void)didReceiveNews:(NSArray *)news
{
    [[NewsHelper sharedInstance] setNews:news];
    [_activityIndicator stopAnimating];
    if(news) {
        [self updateTable];
    }
}

- (void)fetchingFailedWithError:(NSError *)error
{
    NSLog(@"Error %@; %@", error, [error localizedDescription]);
}

- (void)LoadMoreNews:(id)sender {
    //[_activityIndicator startAnimating];
    _pageCount++;
    [_manager fetchNewsByCitiesAndPage: [self getSelectedCities] atPage:[NSString stringWithFormat:@"%d", _pageCount]];
    [self updateTable];
    //[_activityIndicator stopAnimating];
    NSLog(@"loading more");
}

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_clearTable) return 0;
    return [[NewsHelper sharedInstance] getNewsByCity:[self getSelectedCities][section]].count;
}


/*
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if([[NewsHelper sharedInstance] allNews].count != 0) {
        NSInteger currentOffset = scrollView.contentOffset.y;
        NSInteger maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
        // 60 до конца скролла в таблице
        if (maximumOffset - currentOffset <= -60) {
            _pageCount++;
            [_manager fetchNewsByCitiesAndPage: [self getSelectedCities] atPage:[NSString stringWithFormat:@"%d", _pageCount]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self updateTable];
            });
            NSLog(@"reload");
        }
    }
}*/


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *newsByCity = [[NewsHelper sharedInstance] getNewsByCity:[self getSelectedCities][indexPath.section]];
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    News *new = newsByCity[indexPath.row];
    [cell.titleTextView setText:new.title];
    NSString *date = [_dateFormatter stringFromDate:new.date];
    [cell.dateLabel setText:date];
    if(new.city) {
        [cell.cityLabel setText:[new.city name]];
    }
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if([[NewsHelper sharedInstance] allNews].count == 0) {
        return 0;
    }
    return [[self getSelectedCities] count];
}


- (NSMutableArray *)getSelectedCities
{
    return [[Settings sharedInstance] getSelectedCities];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[self getSelectedCities][section] name];
}

@end
