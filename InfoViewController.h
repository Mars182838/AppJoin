//
//  InfoViewController.h
//  AppJoin
//
//  Created by Mars on 12-12-29.
//  Copyright (c) 2012年 Mars. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@class TopBarView;

@interface InfoViewController : UIViewController<UIWebViewDelegate>
{
    /**  下载数据的总长度     */
    long long expectedLength;
    
    /**  当前数据的下载长度   */
    long long currentLength;

}

/** hud 是第三方库 用于提醒用户正在请求网络下载数据 */
@property (nonatomic, retain) MBProgressHUD *hud;

/** infoWebView 用于显示展会资讯的详细信息 */
@property (nonatomic, retain) UIWebView *infoWebView;

/** urlString 用于接收从SecondViewController传过来的网址*/
@property (nonatomic, copy) NSString *urlString;

/** topBar 用于实现导航栏的自定义定制 */
@property (nonatomic, retain) TopBarView *topBar;



@end
