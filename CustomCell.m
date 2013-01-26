//
//  CustomCell.m
//  AppJoin
//
//  Created by Mars on 13-1-21.
//  Copyright (c) 2013年 Mars. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 320, 100)];
        _nameLabel.font = [UIFont systemFontOfSize:18.0f];
        _nameLabel.backgroundColor = [UIColor clearColor];        
        _nameLabel.numberOfLines = 0;
        _nameLabel.lineBreakMode = NSLineBreakByCharWrapping;

        [self.contentView addSubview:_nameLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

@end
