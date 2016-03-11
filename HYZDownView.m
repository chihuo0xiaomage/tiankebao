//
//  HYZDownView.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-15.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZDownView.h"

#import "HYZGetCardDetailModel.h"

@implementation HYZDownView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
        
        self.backgroundColor = [UIColor whiteColor];
        
        _messageArray = [[NSMutableArray alloc] initWithCapacity:0];
        
        NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        NSString *filePath = [docDir stringByAppendingPathComponent:@"CARD.plist"];
        
        NSArray *array = [[NSArray alloc]initWithContentsOfFile:filePath];
        
        for (int i = 0; i < [array count]; i ++ ) {
            
            HYZGetCardDetailModel *getCardModel = [[HYZGetCardDetailModel alloc] initWithDictionary:[array objectAtIndex:i] error:nil];
            
            [_messageArray addObject:getCardModel.cardNo];
        }
    }
    return self;
}

- (void)creatUI
{
//    cart_icon_cardlist.png
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 25)];
    
    lable.text =@"选择付款卡号";
    
    lable.backgroundColor = [UIColor clearColor];
    
    lable.textColor = BACKGROUND_COLOR;
    
    lable.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:lable];
    
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(20, 25, 280, 32)];
    
    bgView.backgroundColor = BACKGROUND_COLOR;
    
    [self addSubview:bgView];
    
    
    
    _cardButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _cardButton.frame = CGRectMake(1, 1, 278, 30);
    
    [_cardButton setBackgroundImage:[UIImage imageNamed:@"cart_icon_cardlist.png"] forState:UIControlStateNormal];
    
    [_cardButton setBackgroundColor:[UIColor whiteColor]];
        
    _cardButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    
    [_cardButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [_cardButton addTarget:self action:@selector(cardButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [bgView addSubview:_cardButton];
    
    
    _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_sureButton setTitle:@"确认付款" forState:UIControlStateNormal];
    
    _sureButton.frame = CGRectMake(20, 60, 280, 45);
    
    [_sureButton setBackgroundColor:[UIColor redColor]];
    
    [_sureButton addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_sureButton];
}

- (void)cardButtonClick
{
    UIActionSheet *cardActionSheet = [[UIActionSheet alloc]
                                      
                                      initWithTitle:@"选择您的付款卡"
                                      
                                      delegate:self
                                      
                                      cancelButtonTitle:@"取消"
                                      
                                      destructiveButtonTitle:nil
                                      
                                      otherButtonTitles:nil, nil];
    
    for (int i = 0; i < [_messageArray count]; i ++ ) {
        [cardActionSheet addButtonWithTitle:[_messageArray objectAtIndex:i]];
    }
    [cardActionSheet showFromRect:self.bounds inView:self animated:YES];
    
    [cardActionSheet showInView:self];
}

#pragma mark - 
#pragma mark UIActionSheetDelegate -
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0){return;}
    else{
        [_cardButton setTitle:[_messageArray objectAtIndex:buttonIndex - 1] forState:UIControlStateNormal];}
}

- (void)sureButtonClick
{
    if ([_delegate respondsToSelector:@selector(sure:)]) {
        [_delegate sure:_cardButton.titleLabel.text];
    }
}

@end
