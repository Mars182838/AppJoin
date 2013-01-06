//
//  CardViewController.h
//  AppJoin
//
//  Created by Mars on 13-1-6.
//  Copyright (c) 2013年 Mars. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"


@interface CardViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,MBProgressHUDDelegate>

///名片展示tableView
@property (nonatomic, retain) UITableView *cardTableView;

@property (nonatomic, retain) NSArray *cardArray;

@end
