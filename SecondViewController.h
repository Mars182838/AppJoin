//
//  SecondViewController.h
//  AppJoin
//
//  Created by Mars on 12-12-29.
//  Copyright (c) 2012年 Mars. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopBarView.h"
#import "DownLoadString.h"
#import "EGORefreshTableHeaderView.h"
#import <QuartzCore/QuartzCore.h>

@interface SecondViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDataDelegate,downLoadStringProtocal,EGORefreshTableHeaderDelegate>
{
    NSURLConnection *connect;
    NSMutableData   *mutableData;
    
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
    
}

/** infoTableView 用于显示从服务器中下载的数据 */
@property (retain, nonatomic) UITableView *infoTableView;

/** messageArray 用于存储从服务其中下载的数据，
 *  并且通过TabelView显示给用户
 */
@property (nonatomic, retain) NSMutableArray *messageArray;

///自定义的导航栏
@property (nonatomic, retain) TopBarView *topBar;

///下载类
@property (nonatomic, retain) DownLoadString *downLoad;


- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

@end
