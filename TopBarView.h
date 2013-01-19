//
//  TopBarView.h
//  AppJoin
//
//  Created by Mars on 13-1-15.
//  Copyright (c) 2013年 Mars. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopBarView : UIView

///导航栏上的图片 红色
@property (nonatomic, retain) UIImageView *navImage;

///导航栏上面的字体
@property (nonatomic, retain) UILabel *navLabel;

///导航栏上面的返回按钮
@property (nonatomic, retain) UIButton *backBtn;

///导航栏上的编辑按钮
@property (nonatomic, retain) UIButton *saveBtn;


@end
