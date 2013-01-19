//
//  DownLoadString.m
//  AppJoin
//
//  Created by Mars on 13-1-14.
//  Copyright (c) 2013年 Mars. All rights reserved.
//

#import "DownLoadString.h"

@implementation DownLoadString

-(id)init
{
    self = [super init];
    if (self) {
        NSURL *url = [NSURL URLWithString:@"http://42.121.237.116/customapp/?cat=1&author=2&json=1"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f];
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

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
}

@end
