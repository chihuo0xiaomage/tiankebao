//
//  HYZUITapGestureRecognizer+Tag.m
//  WeiPu
//
//  Created by 韩亚周 on 13-12-16.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "HYZUITapGestureRecognizer+Tag.h"

@implementation UITapGestureRecognizer(tag)

static char tagKey;

-(NSNumber *)tag
{
    return objc_getAssociatedObject(self, &tagKey);
}
-(void)setTag:(NSNumber *)tag
{
    objc_setAssociatedObject(self, &tagKey, tag, OBJC_ASSOCIATION_RETAIN);
}

@end
