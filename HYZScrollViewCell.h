//
//  HYZScrollViewCell.h
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-25.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HYZCardTransactionScrollView.h"

@protocol HYZScrollViewCellDelegate <NSObject>

- (void)scrollViewImageClicked:(NSString *)tag;

@end

@interface HYZScrollViewCell : UITableViewCell<UIScrollViewDelegate,HYZCardTransactionScrollViewDelegate>

@property (nonatomic, assign) id <HYZScrollViewCellDelegate> scrollViewImageDelegate;

@property (nonatomic, strong) UIPageControl                  *pageControl;
@property (nonatomic, strong) HYZCardTransactionScrollView   *scrollView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier imageNameArray:(NSArray *)array;

- (void)pageChange:(int)sender;

@end
