//
//  QRcodeData.h
//  AppJoin
//
//  Created by Mars on 13-1-9.
//  Copyright (c) 2013年 Mars. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QRcodeData : NSObject

@property (nonatomic, assign) NSUInteger ID;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *message;

/** 初始化方法
 *theID    是唯一标示这个信息
 *theName  是名片的介绍
 *thePlace 是名片信息
 *@return  返回一个任意的实例对象
 **/
-(id)initWithID:(int)theID
        andName:(NSString *)theName
       andMessage:(NSString *)theMessage;

/** 在数据库中查找所有的数据
 *@return 返回一个可变的数组
 */
+(NSMutableArray *)findAllMessage;

/** 添加数据到数据库中
 *theID    是唯一标示这个信息
 *theName  是活动的名称
 *theDate  是活动的时间
 *thePlace 是活动地点
 *@return  返回一个int值
 */
+(int)addMessageWithName:(NSString *)theName
              andMessage:(NSString *)theMessage;

/** 从数据库中删除数据
 *theID    是唯一标示这个信息
 *theName  是活动的名称
 *theDate  是活动的时间
 *thePlace 是活动地点
 *@return  返回一个任意的实例对象
 */
+(int)deleteMessageID:(NSInteger)theID;

@end
