//
//  DownLoadString.h
//  AppJoin
//
//  Created by Mars on 13-1-14.
//  Copyright (c) 2013年 Mars. All rights reserved.
//

#import <Foundation/Foundation.h>
//http://42.121.237.116/customapp/?cat=1&author=2&json=1
///首页展示
#define KRURLWithStringMain @"http://42.121.237.116/customapp/?cat=1&author=2&json=1"

///新闻资讯
#define KRURLWithStringFirst @"http://42.121.237.116/customapp/?cat=3&author=2&json=2"

///展商列表
#define KRURLWithStringSecond @"http://42.121.237.116/customapp/?cat=6&author=2&json=2"

///关于大会
#define KRURLWithStringThird @"http://42.121.237.116/customapp/?cat=5&author=2&json=2"

typedef NS_ENUM(NSInteger, NSStringWithUrl)
{
    NSStringWithUrlMain   = 0,
    NSStringWithUrlFirst,
    NSStringWithUrlSecond,
    NSStringWithUrlThird
};

@protocol downLoadStringProtocal <NSObject>

-(void)downLoadFinished:(NSDictionary *)info;

@end

@interface DownLoadString : NSObject<NSURLConnectionDataDelegate>
{
    NSURLConnection *connection;
    NSMutableData   *mutableData;
    
}

@property (nonatomic, retain) id<downLoadStringProtocal>delegate;


@property NSStringWithUrl shareTarget;

@property (nonatomic, retain) NSURL *url;

+(DownLoadString *)shareInstanceWithNSStringWithUrl:(NSStringWithUrl)target;

-(id)initWithShareTarget:(NSStringWithUrl)target;

@end
