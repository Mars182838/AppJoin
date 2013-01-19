//
//  DateViewController.h
//  AppJoin
//
//  Created by Mars on 13-1-11.
//  Copyright (c) 2013年 Mars. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"


@interface DateViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDataDelegate>
{
    NSURLConnection *connect;
    NSMutableData *messageData;
    
    /**  下在数据的总长度     */
    long long expectedLength;
    
    /**  当前数据的下载长度   */
    long long currentLength;
    
    BOOL isEditer;

}

@property (nonatomic, retain) UITableView *dateTableView;

@property (nonatomic, retain) NSMutableArray *dateArray;

@property (nonatomic, retain) NSMutableArray *detailArray;

/**  hud 是第三方库 用于提醒用户正在请求网络下载数据 */
@property (nonatomic, retain) MBProgressHUD *hud;

@property (nonatomic, retain) UIButton *rightBtn;

@property (nonatomic, retain) TopBarView *topBar;



@end
