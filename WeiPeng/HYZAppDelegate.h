//
//  HYZAppDelegate.h
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-23.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HYZMainViewController.h"

#import "HYZPromotionActivityViewController.h"

#import "HYZShoppingCarViewController.h"

#import "HYZServeViewController.h"

#import "HYZMineViewController.h"

#import "HYZLoginViewController.h"


#import "HYZTopUpViewController.h"

#import "HYZCommitTopUpRequest.h"

#import "SBJsonParser.h"

@interface HYZAppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate,HYZCommitTopUpRequestDelegete>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) HYZTopUpViewController *topUpViewController;
@property (assign, nonatomic)BOOL aPay;
- (void)saveContext;

- (NSURL *)applicationDocumentsDirectory;

- (void)creatViewControllers:(UIWindow *)window;

- (void)settingUINavigationController;

@end
