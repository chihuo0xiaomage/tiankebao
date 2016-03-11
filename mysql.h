//
//  mysql.h
//  LoveCar
//
//  Created by apple on 12-5-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"

#define fileName    @"data.sqlite"
@interface mysql : NSObject{
    sqlite3 *database;
}
+(mysql *)shareMysql;
-(NSString *)loadPath;
-(BOOL)openDatabase;
-(void)closeDatabase;
-(void)createTable:(NSString *)sql;
-(void)insert:(NSString *)sql;
-(void)deleteData:(NSString *)sql;
-(void)update:(NSString *)sql;
-(void)dropTable:(NSString *)tableName;
//查
-(NSArray *)show:(NSString *)sql;
-(NSString *)selectMinCreatDate:(NSString *)tableName;
-(NSInteger)getNumOfRow:(NSString *)tableName;
@end
