//
//  ThirdTableViewCell.m
//  WeiPeng
//
//  Created by 宝源科技 on 14-8-29.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "ThirdTableViewCell.h"
#import "SecondView.h"
#import "UIImageView+WebCache.h"
@implementation ThirdTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.imageArray = [NSMutableArray array];
        UILabel * flashSale = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 80, 20)];
        flashSale.text = @"秒杀";
        [self addSubview:flashSale];
        
        self.aImageView = [[UIImageView alloc] initWithFrame:CGRectMake(flashSale.frame.origin.x, flashSale.frame.origin.y + flashSale.bounds.size.height + 5, 300, 80)];
        self.aImageView.image = [UIImage imageNamed:@"qianggou.png"];
        self.aImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [self.aImageView addGestureRecognizer:tap];
        [self addSubview:self.aImageView];
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(self.aImageView.frame.origin.x,self.aImageView.frame.origin.y + self.aImageView.bounds.size.height + 10, 80, 20)];
        label.text = @"今日推荐";
        [self addSubview:label];
        
        for (int i = 0; i < 2; i ++) {
            for (int j = 0; j < 2; j++) {
                self.secondView = [[SecondView alloc] initWithFrame:CGRectMake(10 + i * 155, label.frame.origin.y + label.bounds.size.height + 10 + j * 110, 145, 100)];
                [self.imageArray addObject:self.secondView];
                    //self.secondView.backgroundColor = [UIColor redColor];
                UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1:)];
                [self.secondView addGestureRecognizer:tap1];
                [self addSubview:self.secondView];
            }
        }
    }
    return self;
}
- (void)tap
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GOOD" object:nil];
}
- (void)tap1:(UITapGestureRecognizer *)tap
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BYRECOMMEND" object:[NSNumber numberWithInt:5]];
}
- (void)setArray:(NSArray *)array
{
    if (_array != array) {
        _array = array;
    }
    NSLog(@"array ====== %@", array);
        for (int i = 0 ; i < 4; i++) {
            
        NSString * imageUrl = [[_array objectAtIndex:i] objectForKey:@"image"];
        SecondView * second = [self.imageArray objectAtIndex:i];
        [second.imageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
            [second.imageView setContentMode:UIViewContentModeScaleAspectFit];
        second.nameLabel.text = [[_array objectAtIndex:i] objectForKey:@"name"];
        second.originalPrice.text = [[_array objectAtIndex:i] objectForKey:@"introduction"];
        second.grabLabel.text = [[_array objectAtIndex:i] objectForKey:@"point"];
        second.ident = [[_array objectAtIndex:i] objectForKey:@"link"];
    }
}
//- (void)tap:(UITapGestureRecognizer *)tap
//{
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"GOOD" object:[NSNumber numberWithInteger:((SecondView *)tap.view).ident]];
//}
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
