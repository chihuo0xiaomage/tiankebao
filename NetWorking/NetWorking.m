//
//  NetWorking.m
//  NewWeipeng
//
//  Created by 宝源科技 on 14-5-9.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "NetWorking.h"
#import "Reachability.h"
#import "MBProgressHUD.h"
@interface NetWorking ()
@property(nonatomic, retain)NSMutableData * receiveData;
@end

@implementation NetWorking
- (void)dealloc
{
    [_receiveData release];
    _receiveData = nil;
    [super dealloc];
}
    //GET请求
- (id)initWithURL:(NSString *)urlStr target:(id)target action:(SEL)action identifier:(NSString *)identifier
{
    self = [super init];
    if (self) {
        _urlStr = urlStr;
        _target = target;
        _action = action;
        _identifier = identifier;
    }
    return self;
}
+ (id)NetWorkingURL:(NSString *)urlStr target:(id)target action:(SEL)action identifier:(NSString *)identifier
{
    NetWorking * netWorking = [[NetWorking alloc] initWithURL:urlStr target:target action:action identifier:(NSString *)identifier];
    [netWorking startLoadData:@"GET"];
    return [netWorking autorelease];
}

    //POST请求
- (id)initWithURlArray:(NSArray *)urlArray target:(id)target action:(SEL)action identifier:(NSString *)identifier
{
    self = [super init];
    if (self) {
        _urlArray = urlArray;
        _target   = target;
        _action   = action;
        _identifier = identifier;
    }
    return self;
}

+ (id)NetWorkingURLArray:(NSArray *)urlArray target:(id)target action:(SEL)action identifier:(NSString *)identifier
{
    NetWorking * netWorking = [[NetWorking alloc] initWithURlArray:urlArray target:target action:action identifier:(NSString *)identifier];
    [netWorking startLoadData:@"POST"];
    return [netWorking autorelease];
}

    //开始请求数据
- (void)startLoadData:(NSString *)requestType
{
    Reachability * reach = [Reachability reachabilityWithHostname:@"www.apple.com"];
        //建立新的连接之前先取消请求
    [self cancelLoadData];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:{
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络连接错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
        }
        case ReachableViaWWAN:
        case ReachableViaWiFi:{
            if ([requestType isEqualToString:@"GET"]) {
                NSString * urlEncodeStr = [_urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSURL * url = [NSURL URLWithString:urlEncodeStr];
                NSURLRequest * request = [NSURLRequest requestWithURL:url];
                [NSURLConnection connectionWithRequest:request delegate:self];
            }else{
                NSString * urlEncodeStr = [[_urlArray objectAtIndex:0] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSURL * url = [NSURL URLWithString:urlEncodeStr];
                NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
                [request setHTTPMethod:requestType];
                NSData * paramsData = [[_urlArray objectAtIndex:1] dataUsingEncoding:NSUTF8StringEncoding];
                [request setHTTPBody:paramsData];
                [NSURLConnection connectionWithRequest:request delegate:self];
            }
            
        }
            break;
        default:
            break;
    }
}
    //取消请求
- (void)cancelLoadData
{
    [_connection cancel];
    [_connection release];
     _connection = nil;
}

    //代理方法
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.receiveData = [NSMutableData dataWithCapacity:1];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.receiveData appendData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;
{
    [[NSNotificationCenter defaultCenter] postNotificationName:_identifier object:_receiveData];
}
    //请求错误调用
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [[NSNotificationCenter defaultCenter] postNotificationName:_identifier object:_receiveData];
//    NSLog(@"%@", [error.userInfo objectForKey:@"NSLocalizedDescription"]);
//    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络连接错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
//    [alertView show];

}

@end
