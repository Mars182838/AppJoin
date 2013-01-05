//
//  DatePlan.h
//  AppJoin
//
//  Created by Mars on 13-1-4.
//  Copyright (c) 2013年 Mars. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DatePlan : NSObject

@property (nonatomic, assign) NSInteger ID;

///活动名称
@property (nonatomic, copy) NSString *name;
///活动时间
@property (nonatomic, copy) NSString *date;
///活动地点
@property (nonatomic, copy) NSString *place;

/** 初始化方法
 *theID    是唯一标示这个信息
 *theName  是活动的名称
 *theDate  是活动的时间
 *thePlace 是活动地点
 *@return  返回一个任意的实例对象
 **/
-(id)initWithID:(int)theID
        andName:(NSString *)theName
        andDate:(NSString *)theDate
       andPlace:(NSString *)thePlace;

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
                 andDate:(NSString *)theDate
                andPlace:(NSString *)thePlace;

/** 从数据库中删除数据
 *theID    是唯一标示这个信息
 *theName  是活动的名称
 *theDate  是活动的时间
 *thePlace 是活动地点
 *@return  返回一个任意的实例对象
 */
+(int)deleteMessageID:(NSInteger)theID;

@end
