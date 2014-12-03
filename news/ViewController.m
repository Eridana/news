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
#import "Communicator.h"
#import "Settings.h"
#import "NewsHelper.h"
#import "UIView+ActivityIndicator.h"

@interface ViewController ()
{
    UIActivityIndicatorView *_activityIndicator;
    UIView *_overlayView;
    Manager *_manager;
    NSDateFormatter *_dateFormatter;
    NSInteger _pageCount;
    BOOL _clearTable;
    UIView *_footerView;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    
    [self addButtons];
    [self.view addSubview:_tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self addPullToRefreshButton];
    [self startIndicator];
    
    _clearTable = NO;
    _manager = [[Manager alloc] init];
    _manager.communicator = [[Communicator alloc] init];
    _manager.communicator.delegate = _manager;
    _manager.delegate = self;
    _pageCount = 1;
    [_manager fetchNewsByCitiesAndPage: [self getSelectedCities] atPage:[NSString stringWithFormat:@"%ld", (long)_pageCount]];
}

-(void)startIndicator
{
    [self.navigationController.view showActivityIndicator];
}

-(void)stopIndicator
{
    [self.navigationController.view hideActivityIndicator];
}

- (void)addPullToRefreshButton
{
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@""];
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
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:uiSettingsButton, nil];
    
    // add footer view
   [self addFooterToTableView];
}


-(void)addFooterToTableView
{
    // separator is dissappearing (ios7 bug)
    _footerView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 2.0, 300.0, 60.0)];
    UIButton *loadMoreButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [loadMoreButton setTitle: @"Загрузить еще новости" forState:UIControlStateNormal];
    [loadMoreButton addTarget:self action:@selector(loadMoreNews:) forControlEvents:UIControlEventTouchUpInside];
    [loadMoreButton setFrame:CGRectMake(10.0, 2.0, 300.0, 44.0)];
    [_footerView addSubview:loadMoreButton];
    _footerView.hidden = YES;
    [self.tableView setTableFooterView:_footerView];
}


-(void)showSettings:(UIButton *)sender
{
    SettingsViewController *settingsController = [self.storyboard instantiateViewControllerWithIdentifier:@"settingsViewController"];
    settingsController.delegate = self;
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
                    //id cell = [self.tableView cellForRowAtIndexPath:indexPath];
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
        [self.tableView reloadData];
    });
}


- (void)refresh:(UIRefreshControl *)refreshControl {
    [self startIndicator];
    [_manager fetchNewsByCitiesAndPage: [self getSelectedCities] atPage:[NSString stringWithFormat:@"%d", 1]];
    [refreshControl endRefreshing];
    [self stopIndicator];
    [self updateTable];
}

- (void)reloadTable
{
    [self startIndicator];
    _clearTable = YES;
    [self updateTable];
    _clearTable = NO;
    
    //[[NewsHelper sharedInstance] clearNews];
    _pageCount = 1;
    [_manager fetchNewsByCitiesAndPage: [self getSelectedCities] atPage:[NSString stringWithFormat:@"%ld", (long)_pageCount]];
    //[self stopIndicator];
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
    //[_activityIndicator stopAnimating];
    if(news) {
        [self stopIndicator];
        [self updateTable];
        _footerView.hidden = NO;
    }
}

- (void)fetchingFailedWithError:(NSError *)error
{
    NSLog(@"Error %@; %@", error, [error localizedDescription]);
}

- (void)loadMoreNews:(id)sender {
    [self startIndicator];
    _pageCount++;
    [_manager fetchNewsByCitiesAndPage: [self getSelectedCities] atPage:[NSString stringWithFormat:@"%ld", (long)_pageCount]];
    [self updateTable];
    [self stopIndicator];
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
}
*/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *newsByCity = [[NewsHelper sharedInstance] getNewsByCity:[self getSelectedCities][indexPath.section]];
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    News *new = newsByCity[indexPath.row];
    [cell.titleTextView setText:new.title];
    [cell.dateLabel setText:new.dateAsString];
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

#pragma mark - SettingsDelegate

- (void)citiesDidChange
{
    [self reloadTable];
}


@end
