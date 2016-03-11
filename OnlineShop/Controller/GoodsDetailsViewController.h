//
//  GoodsDetailsViewController.h
//  WeiPeng
//
//  Created by 宝源科技 on 14-8-18.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsDetailsViewController : UIViewController
@property (nonatomic, strong)NSDictionary * receiveDic;
@property (nonatomic, strong)NSString * goodID;
@property (nonatomic, strong)UIImageView * aImageView;
@property (nonatomic, strong)NSString * imageUrl;
@property (nonatomic, assign)BOOL       begin;
@end
