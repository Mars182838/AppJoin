//
//  DownLoadString.h
//  AppJoin
//
//  Created by Mars on 13-1-14.
//  Copyright (c) 2013年 Mars. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol downLoadStringProtocal <NSObject>

-(void)downLoadFinished:(NSDictionary *)info;

@end

@interface DownLoadString : NSObject<NSURLConnectionDataDelegate>
{
    NSURLConnection *connection;
    NSMutableData   *mutableData;
}

@property (nonatomic, retain) id<downLoadStringProtocal>delegate;
-(NSDictionary *)MainPraseJsonString;

@end
