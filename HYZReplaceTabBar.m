//
//  HYZReplaceTabBar.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-20.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZReplaceTabBar.h"

#import "HYZMainViewController.h"

#import "HYZPromotionActivityViewController.h"

#import "HYZShoppingCarViewController.h"

#import "HYZServeViewController.h"

#import "HYZMineViewController.h"

#import "HYZLoginViewController.h"

@implementation HYZReplaceTabBar


//通过qq、新浪微博、微朋账号登陆成功以后
- (void)replaceTabBar:(int)tabBarIndex
{
//    UINavigationController *mainNavigationConotroller = [[UINavigationController alloc] initWithRootViewController:[[HYZMainViewController alloc] init]];
//    
//    UINavigationController *promotionNavigationConotroller = [[UINavigationController alloc] initWithRootViewController:[[HYZPromotionActivityViewController alloc] init]];
//    
//    
//    UINavigationController *shoppingCarNavigationConotroller = [[UINavigationController alloc] initWithRootViewController:[[HYZShoppingCarViewController alloc] init]];
//    
//    
//    UINavigationController *serveNavigationConotroller = [[UINavigationController alloc] initWithRootViewController:[[HYZServeViewController alloc] init]];
//    
//    
//    UINavigationController *mineNavigationConotroller = [[UINavigationController alloc] initWithRootViewController:[[HYZMineViewController alloc] init]];
//    
//    HYZAppDelegate *appDelegate = (HYZAppDelegate *)[[UIApplication sharedApplication] delegate];
//    
//    UITabBarController* tabBarController = (UITabBarController *)appDelegate.window.rootViewController;
//
//    
//    tabBarController.viewControllers = [NSArray arrayWithObjects:mainNavigationConotroller,promotionNavigationConotroller,shoppingCarNavigationConotroller,serveNavigationConotroller,mineNavigationConotroller, nil];
//    
//    tabBarController.selectedIndex = tabBarIndex;
//    
//    tabBarController.tabBar.barTintColor = [UIColor whiteColor];
//    
//        //    设置选中时TabBar的颜色为红色
//    tabBarController.tabBar.tintColor = [UIColor redColor];
//    
//    appDelegate.tabBarController = tabBarController;
}


//退出登录
- (void)LoginOutReplaceTabBar:(int)tabBarIndex
{
    UINavigationController *mainNavigationConotroller = [[UINavigationController alloc] initWithRootViewController:[[HYZMainViewController alloc] init]];
    
    UINavigationController *promotionNavigationConotroller = [[UINavigationController alloc] initWithRootViewController:[[HYZPromotionActivityViewController alloc] init]];
    
    
    UINavigationController *shoppingCarNavigationConotroller = [[UINavigationController alloc] initWithRootViewController:[[HYZShoppingCarViewController alloc] init]];
    
    
    UINavigationController *serveNavigationConotroller = [[UINavigationController alloc] initWithRootViewController:[[HYZServeViewController alloc] init]];
    
    
    UINavigationController *mineNavigationConotroller = [[UINavigationController alloc] initWithRootViewController:[[HYZLoginViewController alloc] init]];
    
    HYZAppDelegate *appDelegate = (HYZAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UITabBarController* tabBarController = (UITabBarController *)appDelegate.window.rootViewController;
    
    tabBarController.viewControllers = [NSArray arrayWithObjects:mainNavigationConotroller,promotionNavigationConotroller,shoppingCarNavigationConotroller,serveNavigationConotroller,mineNavigationConotroller, nil];
    
    tabBarController.tabBar.barTintColor = [UIColor whiteColor];
    
        //    设置选中时TabBar的颜色为红色
    tabBarController.tabBar.tintColor = [UIColor redColor];
    
    tabBarController.selectedIndex = tabBarIndex;
    
    appDelegate.tabBarController = tabBarController;
}

@end
