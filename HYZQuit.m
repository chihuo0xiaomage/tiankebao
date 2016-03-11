//
//  HYZQuit.m
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-31.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "HYZQuit.h"
#import "HYZReplaceTabBar.h"
@implementation HYZQuit

- (void)initQuit;
{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    [[NSFileManager defaultManager] changeCurrentDirectoryPath:[documentsDirectory stringByExpandingTildeInPath]];
    
    [[NSFileManager defaultManager] removeItemAtPath:@"USERMESSAGE.plist" error:nil];
}

@end
