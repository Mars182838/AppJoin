//
//  CardViewController.h
//  AppJoin
//
//  Created by Mars on 13-1-6.
//  Copyright (c) 2013年 Mars. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "ZBarSDK.h"
#import "TopBarView.h"


@interface CardViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,MBProgressHUDDelegate,ZBarReaderDelegate>

///名片展示tableView
@property (nonatomic, retain) UITableView *cardTableView;

///存放名片元素的数组
@property (nonatomic, retain) NSArray *cardArray;

///qrView 自定义的UIView，用于显示生成的二维码
@property (nonatomic, retain) UIView *qrView;

///qrImage 显示二维码图片
@property (nonatomic, retain) UIImageView *qrImage;

///用于存储UITextView中的信息
@property (nonatomic, retain) NSMutableArray *cardArr;

@property (nonatomic, retain) TopBarView *topBar;

@property (nonatomic, retain) UIButton *rightBtn;

@end
