//
//  HYZShoppingCarModel.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-11.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYZShoppingCarModel : NSObject
{
    NSString   *DBARCODE;
    NSString   *DNAME;
    NSString   *DPRICE;
    NSString   *DNUMBER;
}

@property(nonatomic , strong) NSString *DBARCODE;
@property(nonatomic , strong) NSString *DNAME;
@property(nonatomic , strong) NSString *DPRICE;
@property(nonatomic , strong) NSString *DNUMBER;

@end
