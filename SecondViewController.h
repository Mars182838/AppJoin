//
//  SecondViewController.h
//  AppJoin
//
//  Created by Mars on 12-12-29.
//  Copyright (c) 2012年 Mars. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface SecondViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDataDelegate>
{
    NSURLConnection *connect;
    NSMutableData   *mutableData;
    
  
    /**  下在数据的总长度     */
    long long expectedLength;
    
    /**  当前数据的下载长度   */
    long long currentLength;
}

/** infoTableView 用于显示从服务器中下载的数据 */
@property (retain, nonatomic) IBOutlet UITableView *infoTableView;

/** messageArray 用于存储从服务其中下载的数据，
 *  并且通过TabelView显示给用户
 */
@property (nonatomic, retain) NSMutableArray *messageArray;

/**  hud 是第三方库 用于提醒用户正在请求网络下载数据 */
@property (nonatomic, retain) MBProgressHUD *hud;

@end
