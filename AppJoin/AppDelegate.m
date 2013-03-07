//
//  AppDelegate.m
//  AppJoin
//
//  Created by Mars on 12-12-29.
//  Copyright (c) 2012年 Mars. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourViewController.h"
#import "DataBase.h"
#import <sqlite3.h>
#import "ZBarSDK.h"
#import "Harpy.h"

@implementation AppDelegate

- (void)dealloc
{
    [_mainController   release];
    [_firstContrller   release];
    [_secondController release];
    [_thirdContrller   release];
    [_fourController   release];
    [_window           release];
    [super             dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    [self performSelector:@selector(location:)];
    
    _mainController = [[MainViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController *navMain = [[UINavigationController alloc] initWithRootViewController:_mainController];
    navMain.tabBarItem.title   = @"首页";
    navMain.tabBarItem.image   = [UIImage imageNamed:@"首页.png"];
    navMain.navigationBarHidden = YES;
    
    _firstContrller = [[FirstViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController *navFirst = [[UINavigationController alloc] initWithRootViewController:_firstContrller];
    navFirst.tabBarItem.title  = @"看展会";
    navFirst.tabBarItem.image  = [UIImage imageNamed:@"icon_eyes.png"];
    navFirst.navigationBarHidden = YES;
    
    _secondController = [[SecondViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController *navSecond = [[UINavigationController alloc] initWithRootViewController:_secondController];
    navSecond.tabBarItem.title = @"资讯";
    navSecond.tabBarItem.image = [UIImage imageNamed:@"icon_information.png"];
    navSecond.navigationBarHidden = YES;

    _thirdContrller = [[ThirdViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController *navThird = [[UINavigationController alloc] initWithRootViewController:_thirdContrller];
    navThird.tabBarItem.title  = @"服务";
    navThird.tabBarItem.image  = [UIImage imageNamed:@"服务.png"];
    navThird.navigationBarHidden = YES;
    
    _fourController = [[FourViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController *navFour = [[UINavigationController alloc] initWithRootViewController:_fourController];
    navFour.tabBarItem.title   = @"更多";
    navFour.tabBarItem.image   =  [UIImage imageNamed:@"store.png"];
    navFour.navigationBarHidden = YES;
    
    /** UITabBarController 控制视图的切换，将5个需要切换的视图控制器
     *  的视图数组里面
     */
    UITabBarController *tabBar = [[UITabBarController alloc] init];
    NSArray *viewController = [[NSArray alloc] initWithObjects:navMain,navFirst,navSecond,navThird,navFour, nil];
    tabBar.viewControllers = viewController;
    
    [viewController release];
    _isFirstRun = [[[NSUserDefaults standardUserDefaults] valueForKey:IS_FIRST_RUN] boolValue];
    if (!IS_FIRST_RUN) {
       [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithBool:YES] forKey:IS_FIRST_RUN];
        sqlite3 *db;
        db = [DataBase openDB];
        char *errorMsg;
        
        const char *createSql = "create table if not exists 'appJion' (id integer primary key, name text,date text,place text)";
        if (sqlite3_exec(db, createSql, NULL, NULL, &errorMsg) == SQLITE_OK) {
            NSLog(@"creat table ok");
        }
        
        const char *createTable = "create table if not exists 'appCard' (id integer primary key, name text,message text)";
        if (sqlite3_exec(db, createTable, NULL, NULL, &errorMsg) == SQLITE_OK) {
            NSLog(@"creat table ok");
        }
        
        if (errorMsg!=nil) {
            NSLog(@"%s",errorMsg);
        }
    
        ///关闭数据库
        [DataBase closeDB];
    }
    
    [ZBarReaderView class];
    self.window.rootViewController = tabBar;
    
    [navMain   release];
    [navFirst  release];
    [navSecond release];
    [navThird  release];
    [navFour   release];
    [tabBar    release];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
    
  }

#pragma mark - CLLocationManager Delegate Methods

-(void)location:(id)sender
{
    if ([CLLocationManager locationServicesEnabled]) {
        locationManager = [[CLLocationManager alloc] init];//初始化位置管理器
        [locationManager setDelegate:self];
        [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];//设置精度
        locationManager.distanceFilter = 1000.0f;//设置距离筛选器
        [locationManager startUpdatingLocation];//启动位置管理器
    }
}

- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation;
{
    _location = [newLocation coordinate];//当前经纬
    //插针的经纬  有偏移量
    _location.latitude += 0.000958;
    _location.longitude += 0.005958;
    lat = _location.latitude;
    lon = _location.longitude;
    
    MKCoordinateSpan theSpan;
    theSpan.latitudeDelta = 0.01f;
    theSpan.longitudeDelta = 0.01f;
    _theRegion.center = _location;
    _theRegion.span = theSpan;
    
    [locationManager stopUpdatingLocation];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
