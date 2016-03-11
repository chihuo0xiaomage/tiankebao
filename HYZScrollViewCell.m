//
//  HYZScrollViewCell.m
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-25.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "HYZScrollViewCell.h"

@implementation HYZScrollViewCell

@synthesize pageControl = _pageControl;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier imageNameArray:(NSArray *)array;
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creadScrollView:array];
    }
    return self;
}

static int i = 0;
- (void)doSomething
{
    i ++;
    
    _pageControl.currentPage = i;
    
    if (i == 4)
    {
        i = 0;
        
        [self pageChange:i];
    }
    else
    {
        [self pageChange:i];
    }
}

- (void)creadScrollView:(NSArray *)imageNameArray
{
    _scrollView  = [[HYZCardTransactionScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 163) imageNameArray:imageNameArray];
    
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    _scrollView.showsVerticalScrollIndicator = NO;
    
    _scrollView.scrollDelegate = self;
    
    _scrollView.backgroundColor = [UIColor redColor];
    
    _scrollView.delegate = self;
    
    _scrollView.contentSize = CGSizeMake(320 * [imageNameArray count], 100);
    
    [self.contentView addSubview:_scrollView];
    
//    创建一个pageControl
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 133, self.bounds.size.width, 30)];
    
    _pageControl.numberOfPages = [imageNameArray count];
    
    _pageControl.currentPage = 0;
    
    [_pageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self addSubview:_pageControl];
    
    [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(doSomething) userInfo:nil repeats:YES];
}

- (void)pageChange:(int)sender
{
    [_scrollView setContentOffset:CGPointMake(sender * 320, 0) animated:YES];
}

- (void)pageChanged:(id)sender
{
    UIPageControl *pageControlTemp = (UIPageControl *)sender;
    
    [_scrollView setContentOffset:CGPointMake(pageControlTemp.currentPage * 320, 0) animated:YES];
    
}

#pragma mark -
#pragma mark HYZCardTransactionCellDelegate -

- (void)imageTouchUpInside:(NSString *)tag
{
    if ([_scrollViewImageDelegate respondsToSelector:@selector(scrollViewImageClicked:)]) {
        [_scrollViewImageDelegate scrollViewImageClicked:tag];
    }
}

#pragma mark -
#pragma mark UISrollViewDelegate -


- (void)scrollViewDidScroll:(UIScrollView *)aScrollView
{
//    NSString *str = NSStringFromCGPoint(aScrollView.contentOffset);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
//    NSLog(@"将要开始拖拽");
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
//    NSLog(@"已经结束拖拽");
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
//    NSLog(@"将要开始减速");
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)aScrollView
{
//    NSLog(@"已经停止");
    
    int offsetX = aScrollView.contentOffset.x;
    
    int index = offsetX / 320;
    
//    NSLog(@"-----%d----",index);
    
    _pageControl.currentPage = index;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
