//
//  FourViewController.h
//  AppJoin
//
//  Created by Mars on 12-12-29.
//  Copyright (c) 2012年 Mars. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FourViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) IBOutlet UITableView *editerTableView;

///存放相关数据，例如:关于、大会微博、意见反馈等
@property (nonatomic, retain) NSArray *messageArray;



@end
