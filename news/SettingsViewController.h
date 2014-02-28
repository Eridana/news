//
//  SettingsViewController.h
//  news
//
//  Created by Женя Михайлова on 26.02.14.
//  Copyright (c) 2014 Женя Михайлова. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
