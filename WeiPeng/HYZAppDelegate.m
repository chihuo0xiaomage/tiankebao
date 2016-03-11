//
//  HYZAppDelegate.m
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-23.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "HYZAppDelegate.h"

#define PUSH_MESSAGE_ARRAY @"PushMessageArray"

#import "SBJsonParser.h"
//#import "AlixPayResult.h"

//#import "OnlineViewController.h"
#import "BYOnlineShopViewController.h"
#import "ConvenienceViewController.h"

#import "PartnerConfig.h"


#import "DataVerifier.h"
@implementation HYZAppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize tabBarController = _tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self creatViewControllers:self.window];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
       // [self apns:launchOptions];
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    
}

- (void)creatViewControllers:(UIWindow *)window
{
    HYZMainViewController *mainViewController = [[HYZMainViewController alloc] init];
    
    BYOnlineShopViewController * onlineShopViewController = [[BYOnlineShopViewController alloc] init];
    
    HYZShoppingCarViewController *shoppingViewController = [[HYZShoppingCarViewController alloc] init];
    
    HYZServeViewController *serveViewController = [[HYZServeViewController alloc] init];

    ConvenienceViewController *  convenience = [[ConvenienceViewController alloc] init];
    
    UINavigationController *mainNavigationController = [[UINavigationController alloc] initWithRootViewController:mainViewController];
            
    UINavigationController *promotionNavigationController = [[UINavigationController alloc] initWithRootViewController:onlineShopViewController];

    
    UINavigationController *shoppingNavigationController = [[UINavigationController alloc] initWithRootViewController:shoppingViewController];

    
    UINavigationController *serveNavigationController = [[UINavigationController alloc] initWithRootViewController:serveViewController];
    
    UINavigationController *  convenienceNav = [[UINavigationController alloc] initWithRootViewController:convenience];

//    创建一个TabBarController
    _tabBarController = [[UITabBarController alloc] init];
        _tabBarController.viewControllers = [NSArray arrayWithObjects:mainNavigationController,promotionNavigationController,shoppingNavigationController,serveNavigationController, convenienceNav,nil];

    _tabBarController.tabBar.tintColor = [UIColor redColor];
    window.rootViewController = _tabBarController;
    [self settingUINavigationController];
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application{}

- (void)applicationWillEnterForeground:(UIApplication *)application{}

- (void)applicationDidBecomeActive:(UIApplication *)application{}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;

    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            abort();
        } 
    }
}

#pragma mark - Core Data stack

- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"WeiPeng" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"WeiPeng.sqlite"];
    
    NSError *error = nil;
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (void)settingUINavigationController
{
        // 自定义UINavigationBar
        //设置颜色 (appearance是apple在iOS5.0上加的一个协议，它让程序员可以很轻松地改变某控件的全局样式（背景)
    [[UINavigationBar appearance] setBarTintColor:[UIColor grayColor]];
    
    NSShadow *shadow = [[NSShadow alloc] init];
    
    shadow.shadowColor = [UIColor whiteColor];
    
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,shadow, NSShadowAttributeName,[UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:18.0], NSFontAttributeName, nil]];
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    //如果极简 SDK 不可用,会跳转支付宝钱包进行支付,需要将支付宝钱包的支付结果回传给 SDK if ([url.host isEqualToString:@"safepay"]) {
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        NSLog(@"result = %@",resultDic);
    }];
    if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回 authCode
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    }
    return YES;
}

//#pragma mark -
//- (AlixPayResult *)resultFromURL:(NSURL *)url {
//	NSString * query = [[url query] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//#if ! __has_feature(objc_arc)
//    return [[[AlixPayResult alloc] initWithString:query] autorelease];
//#else
//	return [[AlixPayResult alloc] initWithString:query];
//#endif
//}
//
//- (AlixPayResult *)handleOpenURL:(NSURL *)url {
//	AlixPayResult * result = nil;
//	
//	if (url != nil && [[url host] compare:@"safepay"] == 0) {
//		result = [self resultFromURL:url];
//	}
//	return result;
//}
//- (void)parse:(NSURL *)url application:(UIApplication *)application {
//    
//        //结果处理
//        //NSLog(@"url = %@", url);
//    AlixPayResult* result = [self handleOpenURL:url];
//    
//	if (result)
//        {
//		if (result.statusCode == 9000)
//            {
//			/*
//			 *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
//			 */
//            
//                //交易成功
//            NSString* key = AlipayPubKey;
//			id<DataVerifier> verifier;
//            verifier = CreateRSADataVerifier(key);
//            
//			if ([verifier verifyString:result.resultString withSign:result.signString])
//                {
//                    //验证签名成功，交易结果无篡改
//                [[[UIAlertView alloc] initWithTitle:nil message:@"交易成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
//                }
//            
//            }
//        else
//            {
//                //交易失败
//            [[[UIAlertView alloc] initWithTitle:nil message:@"交易失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
//            }
//        }
//    else
//        {
//            //失败
//        }
//    
//}
//
- (void)commit
{
//    必选，卡号。
//    cardNo
//    *必选，卡密码。
//    cardPwd
//    *必选，充值金额。
//    money
//    *必选，充值方案编号。
//    czfaNo
//    *必选，赠送类型。
//    zsType
//    *必选，赠送明细。
//    zsMx
//    *必选，标识用户身份的Token。
//    token
//    *必选， 第三方系统的交易编号，用于对账。
//    transactionNo
    
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *filePath = [docDir stringByAppendingPathComponent:@"TopUpMessage.Plist"];
    
        //从内存中读取数据
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:filePath];
    
        //拼接一个url比转化成NSUTF8
    NSString *urlString = [[NSString stringWithFormat:@"%@/card/open/api/saveChongzhi.do?cardNo=%@&cardPwd=%@&money=%@&czfaNo=%@&zsType=%@&zsMx=%@&token=%@&transactionNo=%@",URL_HTTP,[dic objectForKey:@"cardNo"],[dic objectForKey:@"cardPwd"],[dic objectForKey:@"money"],[dic objectForKey:@"czfaNo"],[dic objectForKey:@"zsType"],[dic objectForKey:@"zsMx"],[dic objectForKey:@"token"],[dic objectForKey:@"transactionNo"]]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        //网络请求
    HYZCommitTopUpRequest *commitTopUpRequest = [[HYZCommitTopUpRequest alloc] init];
        //设置代理
    commitTopUpRequest.delegate = self;
        //调用方法
    [commitTopUpRequest commitChongZhiMessageRequest:urlString];
}

#pragma mark -
#pragma mark HYZCommitTopUpRequestDelegate -
    //实现HYZCommitTopUpRequestDelegate的代理方法
    //交易成功
- (void)commitTopUpMessageSuccess:(NSString *)messageString{
    UIAlertView *alert = [[UIAlertView alloc]
                          
                          initWithTitle:@"交易成功"
                          
                          message:nil
                          
                          delegate:nil
                          cancelButtonTitle:@"确定 "
                          
                          otherButtonTitles:nil, nil];
    [alert show];
}
    //交易失败
- (void)commitTopUpMessagefalse:(NSString *)messageString{
        //    [_topUpViewController TopUpFaild];
    UIAlertView *alert = [[UIAlertView alloc]
                          
                          initWithTitle:@"交易失败"
                          
                          message:@"取消付款或金额不在充值范围内"
                          
                          delegate:nil
                          
                          cancelButtonTitle:@"确定 "
                          
                          otherButtonTitles:nil, nil];
    [alert show];
}
    //请求失败
- (void)requestFaild:(NSString *)faildString{
        //    [_topUpViewController TopUpFaild];
    UIAlertView *alert = [[UIAlertView alloc]
                          
                          initWithTitle:@"交易失败"
                          
                          message:@"取消付款或金额不在充值范围内"
                          
                          delegate:nil
                          
                          cancelButtonTitle:@"确定 "
                          
                          otherButtonTitles:nil, nil];
    [alert show];
    
}
    //
- (void)apns:(NSDictionary *)launchOptions
{
    [[UIApplication sharedApplication]registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeAlert| UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound)];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber  =  0;
    
    NSString *msgStr = [[launchOptions objectForKey:@"UIApplicationLaunchOptionsRemoteNotificationKey"] objectForKey:@"msg"];
    
    SBJsonParser *json = [[SBJsonParser alloc] init];
    
    NSDictionary *msgID = [json objectWithString:msgStr];
    
    NSString *idStr = [msgID objectForKey:@"id"];
    
    if (launchOptions && idStr)
        {
        [[NSUserDefaults standardUserDefaults] setObject:idStr forKey:@"NewMessage"];
        [[NSUserDefaults standardUserDefaults] synchronize];
            //NSString *urlString = [NSString stringWithFormat:@"%@vipeng/web/message/getAllmsg.do?messageid=%@",URL_HTTP,idStr];
        }
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
//        
//        UIUserNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
//        
//        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:myTypes categories:nil];
//        
//        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
//        
//    }else
//    {
//        
//        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
//        
//        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
//        
//    }
//
    
    
        //出去Token
	NSString* oldToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"PUSH_DEVICE_TOKEN"];
        //
	NSString* newToken = [deviceToken description];
        //NSLog(@"**********%@", newToken);
        //
	newToken = [newToken stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
        //
	newToken = [newToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    
	if (![newToken isEqualToString:oldToken])
	{
        [[NSUserDefaults standardUserDefaults] setObject:newToken forKey:@"PUSH_DEVICE_TOKEN"];
        [[NSUserDefaults standardUserDefaults] synchronize];
	}
}
    //错误回调
- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
        //NSLog(@"%@", error);
}

@end
