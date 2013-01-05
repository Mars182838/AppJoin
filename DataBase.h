//
//  DataBase.h
//  AppJoin
//
//  Created by Mars on 13-1-4.
//  Copyright (c) 2013年 Mars. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

///数据库文件后缀
#define KDBPATH @"db.sqlite"

@interface DataBase : NSObject

///打开数据库方法
+(sqlite3 *)openDB;

///关闭数据库方法
+(void)closeDB;



@end
