//
//  DataBase.m
//  AppJoin
//
//  Created by Mars on 13-1-4.
//  Copyright (c) 2013年 Mars. All rights reserved.
//

#import "DataBase.h"

///初始化一个静态的数据库指针
static sqlite3 *dbPointer = nil;

@implementation DataBase

/**
 *判断数据库是否打开，若打开了就返回该指针,否则从文件夹中打开
 *@return 返回一个数据库指针
 */
+(sqlite3 *)openDB
{
    if (dbPointer) {
        return dbPointer;
    }
    ///从沙盒中取得sql文件
    NSArray *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [documentPath objectAtIndex:0];
    NSString *sqlitePath = [filePath stringByAppendingPathComponent:KDBPATH];
    sqlite3_open([sqlitePath UTF8String], &dbPointer);
    return dbPointer;
}

/** 关闭数据库 */
+(void)closeDB
{
    if (dbPointer) {
        sqlite3_close(dbPointer);
        dbPointer = nil;
    }
}

@end
