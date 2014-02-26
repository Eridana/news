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

@interface SettingsViewController () <UITableViewDataSource> {
    NSDictionary *_cities;
    NSArray *_keyArray;
}

@end

@implementation SettingsViewController

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        _cities = [City cities];
//        [self.view addSubview:_tableView];
//        self.tableView.dataSource = self;
//        [self.tableView reloadData];
//
//    }
//    return self;
//}

- (void)viewDidLoad
{
    self.navigationController.navigationBar.translucent = NO;
    [super viewDidLoad];
    _cities = [City cities];
    _keyArray = [_cities allKeys];
	[self.view addSubview:_tableView];
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
    if([tableView cellForRowAtIndexPath:indexPath].accessoryType == UITableViewCellAccessoryCheckmark) {
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
    }
    else {
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    }
}

@end
