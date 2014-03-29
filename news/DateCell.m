//
//  DateCell.m
//  news
//
//  Created by Женя Михайлова on 23.03.14.
//  Copyright (c) 2014 Женя Михайлова. All rights reserved.
//

#import "DateCell.h"

@implementation DateCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
