//
//  mysql.m
//  LoveCar
//
//  Created by apple on 12-5-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "mysql.h"
#import "HYZShoppingCarModel.h"

@implementation mysql
static mysql *mydata;
+(mysql *)shareMysql{
    if (mydata==nil) {
        mydata=[[mysql alloc] init];
    }
    return mydata;
}
-(NSString *)loadPath{
	NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *thePath=[paths objectAtIndex:0];
	NSString *path2=[thePath stringByAppendingPathComponent:fileName];
	return path2;
}
-(BOOL)openDatabase{
	if(sqlite3_open([[self loadPath] UTF8String], &database)!=SQLITE_OK){
		sqlite3_close(database);
		return NO;
	}
	return YES;
}
-(void)closeDatabase{
	sqlite3_close(database);
}
//创建表格
-(void)createTable:(NSString *)sql{
    [self openDatabase];
	char *errorMessage=nil;
	if(sqlite3_exec(database, [sql UTF8String], nil, nil, &errorMessage)!=SQLITE_OK){
		sqlite3_close(database);
		NSAssert1(0,@"Error:%s",errorMessage);
	}
    //[self closeDatabase];
}
//增1
-(void)insert:(NSString *)sql{
	[self openDatabase];
	char *errorMessage=nil;
	if (sqlite3_exec(database, [sql UTF8String], nil, nil, &errorMessage)!=SQLITE_OK) {
		sqlite3_close(database);
	}
	[self closeDatabase];
}
//删
-(void)deleteData:(NSString *)sql{
    [self openDatabase];
	char *errorMessage;
	if (sqlite3_exec(database, [sql UTF8String], nil, nil, &errorMessage)!=SQLITE_OK) {
		sqlite3_close(database);
	}
    [self closeDatabase];
}
//改
-(void)update:(NSString *)sql{
    [self openDatabase];
	char *errorMessage;
	if (sqlite3_exec(database, [sql UTF8String], nil, nil, &errorMessage)!=SQLITE_OK) {
		sqlite3_close(database);
	}
	[self closeDatabase];
}

-(NSMutableArray *)show:(NSString *)sql{
    [self openDatabase];
	sqlite3_stmt *stmt;
	NSMutableArray *arr=[[NSMutableArray alloc] initWithCapacity:0];
	if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil)==SQLITE_OK){
		while (sqlite3_step(stmt)==SQLITE_ROW) {
            
            HYZShoppingCarModel *md = [[HYZShoppingCarModel alloc] init];
            
            char *DNAME=(char *)sqlite3_column_text(stmt,0);
            md.DNAME=[NSString stringWithUTF8String:DNAME];
            
            char *DNUMBER=(char *)sqlite3_column_text(stmt,1);
            md.DNUMBER=[NSString stringWithUTF8String:DNUMBER];
            
            char *DBARCODE=(char *)sqlite3_column_text(stmt,2);
            md.DBARCODE=[NSString stringWithUTF8String:DBARCODE];
            
            char *DPRICE=(char *)sqlite3_column_text(stmt,3);
            md.DPRICE=[NSString stringWithUTF8String:DPRICE];
            
            [arr addObject:md];
		}
	}
	sqlite3_finalize(stmt);
    [self closeDatabase];
	return arr;
    
}
            
//获取MinCreatDate
-(NSString *)selectMinCreatDate:(NSString *)tableName{
	[self openDatabase];
    
	NSString *MinCreateDate=nil;
    NSString *strSQL =[NSString stringWithFormat:@"SELECT min(createDate) FROM %@",tableName];
	sqlite3_stmt *stmt;
	if (sqlite3_prepare_v2(database, [strSQL UTF8String], -1, &stmt, nil)==SQLITE_OK) {
		if (sqlite3_step(stmt)==SQLITE_ROW) {
			char *createDate=(char *)sqlite3_column_text(stmt,0);
            if (createDate==NULL) {
                MinCreateDate=@"";
            }else{
              MinCreateDate=[NSString stringWithUTF8String:createDate];  
            }
		}
	}
	sqlite3_finalize(stmt);
    [self closeDatabase];
	return MinCreateDate;
}
//删除表
-(void)dropTable:(NSString *)tableName{
    [self openDatabase];

	NSString *sql=[NSString stringWithFormat:@"drop table %@;",tableName];
	char *errorMessage;
	if (sqlite3_exec(database, [sql UTF8String], nil, nil, &errorMessage)!=SQLITE_OK) {
		sqlite3_close(database);
	}
    [self closeDatabase];
}
//获取最大行数
-(NSInteger)getNumOfRow:(NSString *)tableName{
	[self openDatabase];

	NSInteger Maxid=0;
	NSString *strSQL =[NSString stringWithFormat:@"SELECT COUNT(*) FROM %@;",tableName];
	
	sqlite3_stmt *stmt;
	
	if (sqlite3_prepare_v2(database, [strSQL UTF8String], -1, &stmt, nil)==SQLITE_OK) {
		
		if (sqlite3_step(stmt)==SQLITE_ROW) {
			Maxid=sqlite3_column_int(stmt, 0);
			
		}
	}
	sqlite3_finalize(stmt);
    [self closeDatabase];
	return Maxid;
}
@end