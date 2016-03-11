//
//  FirstTableViewCell.m
//  BaoYuanWeiPeng
//
//  Created by 宝源科技 on 14-6-11.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "FirstTableViewCell.h"
#import "CycleScrollView.h"
#import "ImageView.h"
#import "UIImageView+WebCache.h"
@interface FirstTableViewCell ()
{
    NSMutableArray * _imageArray;
}
@property(nonatomic, retain)CycleScrollView * baseScrollView;
@end

@implementation FirstTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addControl];
    }
    return self;
}
- (void)addControl
{
    NSMutableArray * viewsArray = [@[] mutableCopy];
    for (int i = 0; i < 4; i++) {
        ImageView * imageView = [[ImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 160)];
        [viewsArray addObject:imageView];
    }
    _imageArray = viewsArray;
    self.baseScrollView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 160) animationDuration:3.0];
    self.baseScrollView.fetchContentViewAtIndex = ^UIView * (NSInteger pageIndex){
        return  viewsArray[pageIndex];
    };
    
    self.baseScrollView.totalPagesCount = ^NSInteger(void){
        return 4;
    };
    self.baseScrollView.scrollView.pagingEnabled = YES;
        //__block FirstTableViewCell * cell = self;
    self.baseScrollView.TapActionBlock = ^(NSInteger pageIndex){
            //NSLog(@"点击了第%d个", pageIndex);
            //[cell goToDetail:[cell.array objectAtIndex:pageIndex]];
    };
    [self addSubview:self.baseScrollView];
}
- (void)goToDetail:(NSDictionary *)urlDic
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"urlDic" object:urlDic userInfo:nil];
}
- (void)setArray:(NSArray *)array
{
    if (_array != array) {
        _array = array;
    }
    for (int i = 0; i < _imageArray.count; i++) {
        ImageView * view = [_imageArray objectAtIndex:i];
        [view.imageView setImageWithURL:[NSURL URLWithString:[[_array objectAtIndex:i] objectForKey:@"image"]] placeholderImage:nil];
        view.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
}
- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
