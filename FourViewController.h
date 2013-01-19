//
//  FourViewController.h
//  AppJoin
//
//  Created by Mars on 12-12-29.
//  Copyright (c) 2012年 Mars. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TopBarView;

@interface FourViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) UITableView *editerTableView;

///存放相关数据，例如:关于、大会微博、意见反馈等
@property (nonatomic, retain) NSArray *messageArray;

/// topBar 实现导航栏的自定义的定制
@property (nonatomic, retain) TopBarView *topBar;


@end
