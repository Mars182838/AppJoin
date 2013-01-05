//
//  DatePlan.m
//  AppJoin
//
//  Created by Mars on 13-1-4.
//  Copyright (c) 2013年 Mars. All rights reserved.
//

#import "DatePlan.h"
#import "DataBase.h"

@implementation DatePlan

-(id)initWithID:(int)theID andName:(NSString *)theName andDate:(NSString *)theDate andPlace:(NSString *)thePlace
{
    if (self == [super init]) {
        self.ID = theID;
        self.name = theName;
        self.date = theDate;
        self.place = thePlace;
    }
    return self;
}

+(int)addMessageWithName:(NSString *)theName andDate:(NSString *)theDate andPlace:(NSString *)thePlace
{
    sqlite3 *db = [DataBase openDB];
    sqlite3_stmt *stmt = nil;
    
    NSString *insert = [[NSString alloc] initWithFormat:@"%@",@"insert into appJion(name,date,place) values(?,?,?)"];
    
    sqlite3_prepare_v2(db, [insert UTF8String], -1, &stmt, nil);
    if (theName == NULL) {
        theName = @"";
    }
    if (theDate == NULL) {
        theDate = @"";
    }
    if (thePlace == NULL) {
        thePlace = @"";
    }
    
    sqlite3_bind_text(stmt, 1, [theName UTF8String], -1, nil);
    sqlite3_bind_text(stmt, 2, [theDate UTF8String], -1, nil);
    sqlite3_bind_text(stmt, 3, [thePlace UTF8String], -1, nil);
    int result = sqlite3_step(stmt);
    return result;
}

+(NSMutableArray *)findAllMessage
{
    sqlite3 *db = [DataBase openDB];
    sqlite3_stmt *stmt = nil;
    
    NSString *find = @"select * from appJion order by name desc";
    
    if (sqlite3_prepare_v2(db, [find UTF8String], -1, &stmt, nil)) {
        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
        while (sqlite3_step(stmt) == SQLITE_OK) {
            
            int theID = sqlite3_column_int(stmt, 0);
            const unsigned char *name = sqlite3_column_text(stmt, 1);
            const unsigned char *date = sqlite3_column_text(stmt, 2);
            const unsigned char *place = sqlite3_column_text(stmt, 3);
            
            DatePlan *plan = [[DatePlan alloc] initWithID:theID
                                                  andName:[NSString stringWithUTF8String:(const char *)name]
                                                  andDate:[NSString stringWithUTF8String:(const char *)date ]
                                                 andPlace:[NSString stringWithUTF8String:(const char *)place]];
            [array addObject:plan];
            [plan release];
        }
        //结束数据库
        sqlite3_finalize(stmt);
        return [array autorelease];
    }
    else{
        sqlite3_finalize(stmt);
        return [NSMutableArray array];
    }
}

+(int)deleteMessageID:(NSInteger)theID
{
    sqlite3 *db = [DataBase openDB];
    sqlite3_stmt *stmt;
    
    NSString *delete = @"delete from appJion where ID = ?";
    
    sqlite3_prepare_v2(db, [delete UTF8String], -1, &stmt, nil);
    sqlite3_bind_int(stmt, 1, theID);
    int result = sqlite3_step(stmt);
    sqlite3_finalize(stmt);
    return result;
}

@end
