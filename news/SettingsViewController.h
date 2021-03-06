//
//  SettingsViewController.h
//  news
//
//  Created by Женя Михайлова on 26.02.14.
//  Copyright (c) 2014 Женя Михайлова. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SettingsDelegate;

@interface SettingsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISwitch *citySwitch;
@property (weak, nonatomic) IBOutlet UISwitch *dateSwitch;
@property (weak, nonatomic) id <SettingsDelegate> delegate;
@end

@protocol SettingsDelegate
@required
- (void)citiesDidChange;
@end
