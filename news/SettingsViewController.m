//
//  SettingsViewController.m
//  news
//
//  Created by Женя Михайлова on 26.02.14.
//  Copyright (c) 2014 Женя Михайлова. All rights reserved.
//

#import "SettingsViewController.h"
#import "SettingsCell.h"
#import "City.h"

@interface SettingsViewController () <UITableViewDataSource, UITableViewDelegate> {
    NSDictionary *_cities;
    NSArray *_keyArray;
    NSMutableArray *_selectedCities;
}
@end

@implementation SettingsViewController

- (void)viewDidLoad
{
    self.navigationController.navigationBar.translucent = NO;
    [super viewDidLoad];
    _cities = [City cities];
    _keyArray = [_cities allKeys];
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
    return _keyArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SettingsCell";
    SettingsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSString *key = [_keyArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [_cities objectForKey:key];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    //_keyArray[indexPath.row];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType == UITableViewCellAccessoryNone) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
         cell.accessoryType = UITableViewCellAccessoryNone;
    }
}

@end
