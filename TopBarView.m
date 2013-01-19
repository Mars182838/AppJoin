//
//  TopBarView.m
//  AppJoin
//
//  Created by Mars on 13-1-15.
//  Copyright (c) 2013年 Mars. All rights reserved.
//

#import "TopBarView.h"

@implementation TopBarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _navImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 46)];
        _navImage.image = [UIImage imageNamed:@"top.png"];
        [self  addSubview:_navImage];
        
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _backBtn.frame = CGRectMake(5, 6, 50, 30);
        [_backBtn setImage:[UIImage imageNamed:@"back1.png"] forState:UIControlStateNormal];
        [self addSubview:_backBtn];
        
        _navLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 320, 30)];
        _navLabel.font = [UIFont systemFontOfSize:22.0f];
        _navLabel.textColor = [UIColor whiteColor];
        _navLabel.textAlignment = NSTextAlignmentCenter;
        _navLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_navLabel];
    }
    return self;
}

-(void)dealloc
{
    [_navImage release];
    [_navLabel release];
    [_backBtn  release];
    [super dealloc];
}

@end
