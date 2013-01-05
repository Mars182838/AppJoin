//
//  AppDelegate.h
//  AppJoin
//
//  Created by Mars on 12-12-29.
//  Copyright (c) 2012年 Mars. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@class MainViewController;
@class FirstViewController;
@class SecondViewController;
@class ThirdViewController;
@class FourViewController;

#define ShareApp ((AppDelegate *)[[UIApplication sharedApplication] delegate])

///判断是不是第一次运行程序
#define IS_FIRST_RUN  @"isFirstRun"

@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>
{
    CLLocationManager * locationManager;//定义位置管理器
    CLLocationDegrees lat;//定义经度
    CLLocationDegrees lon;//定义纬度
    
    MKPointAnnotation *annotation;
}

@property (strong, nonatomic) UIWindow *window;

/** 本应用使用UITabBarController 控制视图切换一共有五个视图分别为下面 */
@property (nonatomic, strong) MainViewController *mainController;
@property (nonatomic, strong) FirstViewController *firstContrller;
@property (nonatomic, strong) SecondViewController *secondController;
@property (nonatomic, strong) ThirdViewController *thirdContrller;
@property (nonatomic, strong) FourViewController *fourController;

@property (assign, nonatomic) MKCoordinateRegion theRegion;
@property (assign, nonatomic) CLLocationCoordinate2D location;

@property (nonatomic, assign) BOOL isFirstRun;

@end
