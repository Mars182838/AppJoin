//
//  DownLoadString.h
//  AppJoin
//
//  Created by Mars on 13-1-14.
//  Copyright (c) 2013年 Mars. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
#define KRURLWithStringMain @"http://42.121.237.116/customapp/?cat=1&author=2&json=1"
#define KRURLWithStringFirst @"http://42.121.237.116/mimi/json.php?c=7&t=1358221626&p=0"

typedef NS_ENUM(NSInteger, NSStringWithUrl)
{
    NSStringWithUrlMain   = 0,
    NSStringWithUrlFirst  = 1,
    NSStringWithUrlSecond = 2,
};

@protocol downLoadStringProtocal <NSObject>

-(void)downLoadFinished:(NSDictionary *)info;

@end

@interface DownLoadString : NSObject<NSURLConnectionDataDelegate,MBProgressHUDDelegate>
{
    NSURLConnection *connection;
    NSMutableData   *mutableData;
    
    /**  下在数据的总长度     */
    long long expectedLength;
    
    /**  当前数据的下载长度   */
    long long currentLength;
}

@property (nonatomic, retain) id<downLoadStringProtocal>delegate;

/**  hud 是第三方库 用于提醒用户正在请求网络下载数据 */
@property (nonatomic, retain) MBProgressHUD *hud;

@property NSStringWithUrl shareTarget;

@property (nonatomic, retain) NSURL *url;

+(DownLoadString *)shareInstanceWithNSStringWithUrl:(NSStringWithUrl)target;

-(id)initWithShareTarget:(NSStringWithUrl)target;

@end
