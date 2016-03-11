//
//  HYZPromotionActivityViewController.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-22.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZPromotionActivityViewController.h"

@interface HYZPromotionActivityViewController ()

@end

@implementation HYZPromotionActivityViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @"促销";
        
        self.navigationItem.title = @"促销活动";
        
        self.tabBarItem.image = [UIImage imageNamed:@"icon_2_n.png"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    if (IOS7) {self.automaticallyAdjustsScrollViewInsets = NO;}
    
    _itemNameArray = [[NSArray alloc] initWithObjects:@"幸运转盘",@"刮刮乐",@"团购",@"秒杀", nil];
    
    _itemImageArray = [[NSArray alloc] initWithObjects:@"cxhd_icon_zhuan.png",@"cxhd_icon_le.png",@"cxhd_icon_tuan.png",@"cxhd_icon_miao.png", nil];
    
    _convenienceTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_HEIGHT, WIDTH, HEIGHT - NAVIGATION_HEIGHT - TABBAR_HEIGHT)];
    
    _convenienceTableView.dataSource = self;
    
    _convenienceTableView.delegate = self;
    
    [self.view addSubview:_convenienceTableView];
}

#pragma mark -
#pragma mark UITableViweDataSource -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){return 100;} else {return 44;}
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0){return 1;} else {return [_itemNameArray count];}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        HYZTopCell *cell = [[HYZTopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil backgroundImage:[UIImage imageNamed:@"cxhd_icon_top.png"]];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.selected = NO;
        
        return cell;
    }
    else{
        static NSString *cellIdentifier = @"CellIdentifier";
        
        HYZSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell)
        {
            cell = [[HYZSettingCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        cell.cellLable.text = [_itemNameArray objectAtIndex:indexPath.row];
        
        cell.leftImageView.image = [UIImage imageNamed:[_itemImageArray objectAtIndex:indexPath.row]];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){return;}
    else{
        HYZWebViewController *webViewController = [[HYZWebViewController alloc] init];
        
        [self.navigationController pushViewController:webViewController animated:YES];
        
        switch (indexPath.row) {
            case 0:
            {
                webViewController.titleString = [_itemNameArray objectAtIndex:indexPath.row];
                
                webViewController.urlString = [NSString stringWithFormat:@"%@vipeng/web/lottery/get_lottery.do",URL_HTTP];
            }
                break;
            case 1:
            {
                webViewController.titleString = [_itemNameArray objectAtIndex:indexPath.row];
                
                webViewController.urlString = [NSString stringWithFormat:@"%@vipeng/web/lottery/get_scratch.do",URL_HTTP];
            }
                break;
            case 2:
            {
                webViewController.titleString = [_itemNameArray objectAtIndex:indexPath.row];
                
                webViewController.urlString = [NSString stringWithFormat:@"%@vipeng/web/lottery/tuan.do",URL_HTTP];
            }
                break;
            case 3:
            {
                webViewController.titleString = [_itemNameArray objectAtIndex:indexPath.row];
                
                webViewController.urlString = [NSString stringWithFormat:@"%@vipeng/web/lottery/seckill.do",URL_HTTP];
            }
                break;
                
            default:
                break;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
