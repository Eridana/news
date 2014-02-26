//
//  ViewController.h
//  news
//
//  Created by Женя Михайлова on 13.02.14.
//  Copyright (c) 2014 Женя Михайлова. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end
