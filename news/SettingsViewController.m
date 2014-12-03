//
//  SettingsViewController.m
//  news
//
//  Created by Женя Михайлова on 26.02.14.
//  Copyright (c) 2014 Женя Михайлова. All rights reserved.
//

#import "SettingsViewController.h"
#import "SettingsCell.h"
#import "Settings.h"
#import "City.h"

@interface SettingsViewController () <UITableViewDataSource, UITableViewDelegate> {
    NSArray *_cities;
    BOOL _citiedDidChange;
}
@end

@implementation SettingsViewController

- (void)viewDidLoad
{
    self.navigationController.navigationBar.translucent = NO;
    [super viewDidLoad];
    _cities = [[[Settings sharedInstance] getAllCities] mutableCopy];
	[self.view addSubview:_tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _cities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SettingsCell";
    SettingsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    City *city = [self getCityByIndexPath:indexPath];
    cell.textLabel.text = city.name;
    if(city.selected) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (City *)getCityByIndexPath:(NSIndexPath *)indexPath
{
    City * city = [_cities objectAtIndex:indexPath.row];
    return city;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    City *city = [self getCityByIndexPath:indexPath];

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType == UITableViewCellAccessoryNone) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;        
        [[Settings sharedInstance] selectCity:city];
        _citiedDidChange = YES;
    }
    else {
        // список выбранных городов не может быть пустым
        if([[Settings sharedInstance] getSelectedCities].count != 1) {
            cell.accessoryType = UITableViewCellAccessoryNone;
            [[Settings sharedInstance] unselectCity:city];
            _citiedDidChange = YES;
        }
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (_delegate && _citiedDidChange) {
        [_delegate citiesDidChange];
    }
}

@end
