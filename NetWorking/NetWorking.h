//
//  NetWorking.h
//  NewWeipeng
//
//  Created by 宝源科技 on 14-5-9.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetWorking : NSObject
{
    NSString * _urlStr;
    id      _target;
    SEL     _action;
    NSArray  * _urlArray;
    NSURLConnection * _connection;
    NSString * _identifier;
}
@property(nonatomic, retain)id target;
    //GET请求
- (id)initWithURL:(NSString *)urlStr target:(id)target action:(SEL)action identifier:(NSString *)identifier;
+ (id)NetWorkingURL:(NSString *)urlStr target:(id)target action:(SEL)action identifier:(NSString *)identifier;

    //POST请求
- (id)initWithURlArray:(NSArray *)urlArray target:(id)target action:(SEL)action identifier:(NSString *)identifier;
+ (id)NetWorkingURLArray:(NSArray *)urlArray target:(id)target action:(SEL)action identifier:(NSString *)identifier;

    //开始请求数据
- (void)startLoadData:(NSString *)requestType;
    //取消请求
- (void)cancelLoadData;
@end
