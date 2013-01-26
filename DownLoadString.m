//
//  DownLoadString.m
//  AppJoin
//
//  Created by Mars on 13-1-14.
//  Copyright (c) 2013年 Mars. All rights reserved.
//

#import "DownLoadString.h"

@implementation DownLoadString

///实现单利模式步骤
static DownLoadString *instance = nil;

+(DownLoadString *)shareInstanceWithNSStringWithUrl:(NSStringWithUrl)target
{
    @synchronized(self){
        if (instance == nil) {
            instance = [[self alloc] initWithShareTarget:target];
        }
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
        else if (astarget == NSStringWithUrlSecond)
        {
             _url = [NSURL URLWithString:KRURLWithStringSecond];
        }
        else if (astarget == NSStringWithUrlThird)
        {
            _url = [NSURL URLWithString:KRURLWithStringThird];
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
    [mutableData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [mutableData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:mutableData options:NSJSONReadingAllowFragments error:&error];
    [self.delegate downLoadFinished:dic];
}



@end
