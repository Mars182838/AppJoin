//
//  QRcodeData.m
//  AppJoin
//
//  Created by Mars on 13-1-9.
//  Copyright (c) 2013年 Mars. All rights reserved.
//

#import "QRcodeData.h"
#import "DataBase.h"

@implementation QRcodeData

-(id)initWithID:(int)theID andName:(NSString *)theName andMessage:(NSString *)theMessage
{
    if (self = [super init]) {
        self.ID = theID;
        self.name = theName;
        self.message = theMessage;
    }
    return self;
}

+(int)addMessageWithName:(NSString *)theName andMessage:(NSString *)theMessage
{
    sqlite3 *db = [DataBase openDB];
    sqlite3_stmt *stmt = nil;
    
    NSString *insert = @"insert into appCard(name,message) values(?,?)";
    
    sqlite3_prepare_v2(db, [insert UTF8String], -1, &stmt, nil);
    if (theName == NULL) {
        theName = @"";
    }
    if (theMessage == NULL) {
        theMessage = @"";
    }
    
    sqlite3_bind_text(stmt, 1, [theName UTF8String], -1, nil);
    sqlite3_bind_text(stmt, 2, [theMessage UTF8String], -1, nil);
    int result = sqlite3_step(stmt);
    return result;

}


+(NSMutableArray *)findAllMessage
{
    sqlite3 *db = [DataBase openDB];
    sqlite3_stmt *stmt = nil;
    
    NSString *find = @"select * from appCard order by id desc";
    
    if (sqlite3_prepare_v2(db, [find UTF8String], -1, &stmt, nil) == SQLITE_OK)
    {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            int theID = sqlite3_column_int(stmt, 0);
            const unsigned char *name = sqlite3_column_text(stmt, 1);
            const unsigned char *message = sqlite3_column_text(stmt, 2);
            
            QRcodeData *plan = [[QRcodeData alloc] initWithID:theID
                                                  andName:[NSString stringWithUTF8String:(const char *)name]
                                                  andMessage:[NSString stringWithUTF8String:(const char *)message ]];
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
    
    NSString *delete = @"delete from appCard where ID = ?";
    
    sqlite3_prepare_v2(db, [delete UTF8String], -1, &stmt, nil);
    sqlite3_bind_int(stmt, 1, theID);
    int result = sqlite3_step(stmt);
    sqlite3_finalize(stmt);
    return result;
}


@end
