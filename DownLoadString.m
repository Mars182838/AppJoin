//
//  DownLoadString.m
//  AppJoin
//
//  Created by Mars on 13-1-14.
//  Copyright (c) 2013年 Mars. All rights reserved.
//

#import "DownLoadString.h"
#import "MBProgressHUD.h"

@implementation DownLoadString

static DownLoadString *instance;

+(DownLoadString *)shareInstanceWithNSStringWithUrl:(NSStringWithUrl)target
{
    if (instance == nil) {
        instance = [[DownLoadString alloc] initWithShareTarget:target];
    }
    return instance;
}

-(id)initWithShareTarget:(NSStringWithUrl)astarget
{
    _shareTarget = astarget;
    if (self = [super init]) {
        
        if (astarget == NSStringWithUrlMain) {
            _url = [NSURL URLWithString:KRURLWithStringMain];
        }
        else if (astarget == NSStringWithUrlFirst)
        {
            _url = [NSURL URLWithString:KRURLWithStringFirst];
        }
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:_url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f];
        connection = [NSURLConnection connectionWithRequest:request delegate:self];
        if (connection) {
            mutableData = [[NSMutableData alloc] initWithLength:0];
        }
    }
    return self;
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
//    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.labelText = @"下载中，请稍后";
    expectedLength = [response expectedContentLength];
    currentLength = 0;
    _hud.delegate = self;
    
    [mutableData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    currentLength += [data length];
    _hud.progress = currentLength/(float)expectedLength;
    
    [mutableData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [_hud hide:YES afterDelay:1.0f];

    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:mutableData options:NSJSONReadingAllowFragments error:&error];
    [self.delegate downLoadFinished:dic];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.mode = MBProgressHUDModeText;
//    hud.delegate = self;
//    hud.labelText = @"下载失败，请查看网络连接状态";
//    [hud hide:YES afterDelay:1.0f];
}

-(void)hudWasHidden:(MBProgressHUD *)hud
{
    [hud removeFromSuperview];
}
@end
