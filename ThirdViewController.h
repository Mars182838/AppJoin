//
//  ThirdViewController.h
//  AppJoin
//
//  Created by Mars on 12-12-29.
//  Copyright (c) 2012年 Mars. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Place.h"
#import "AppDelegate.h"
#import "TopBarView.h"
#import "DownLoadString.h"

#import "EGORefreshTableHeaderView.h"
#import <QuartzCore/QuartzCore.h>

@interface ThirdViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MKMapViewDelegate,CLLocationManagerDelegate,downLoadStringProtocal,EGORefreshTableHeaderDelegate>
{
    ///自定义的大头针对象
    Place *place;
    BOOL isEditer;
    
    ///下拉刷新
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
    
}

///显示行车路线的Label
@property (nonatomic, retain) UILabel *label;

///地图类
@property (nonatomic, retain) MKMapView *myMapView;

///当前位置的定位类
@property (nonatomic, retain) CLLocation *location;

///我的收藏日程数组
@property (nonatomic, retain) NSMutableArray *myDateArray;

///显示我的收藏日程的tableView
@property (retain, nonatomic) UITableView *dateTableView;

///显示二维码信息TableView
@property (nonatomic, retain) UITableView *qrTableView;

///存储名片信息的数组
@property (nonatomic, retain) NSMutableArray *qrArray;

///导航栏右按钮
@property (nonatomic, retain) UIButton *rightBtn;

///自定义的导航栏
@property (nonatomic, retain) TopBarView *topBar;

///下载类，传递一个字典
@property (nonatomic, retain) DownLoadString *downLoad;

///segment方法，0代表显示我的日程，1是行车路线，2是我的当前位置地图
- (IBAction)segmentActive:(id)sender;

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;


@end
