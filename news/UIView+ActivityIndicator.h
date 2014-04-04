//
//  UIView+ActivityIndicator.h
//  news
//
//  Created by Женя Михайлова on 02.04.14.
//  Copyright (c) 2014 Женя Михайлова. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ActivityIndicator)

- (void)showActivityIndicator;
- (void)showActivityIndicatorWithStyle:(UIActivityIndicatorViewStyle)style;
- (void)hideActivityIndicator;

@end
