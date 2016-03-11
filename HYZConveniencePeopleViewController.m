//
//  HYZConveniencePeopleViewController.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-7.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZConveniencePeopleViewController.h"

@interface HYZConveniencePeopleViewController ()

@end

@implementation HYZConveniencePeopleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"便民";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    if (IOS7) {self.automaticallyAdjustsScrollViewInsets = NO;}
    
    _itemNameArray = [[NSArray alloc] initWithObjects:@"天气神",@"翻译通",@"车票搜",@"股票通",@"快递100", nil];
    
    _itemImageArray = [[NSArray alloc] initWithObjects:@"home_icon_tianqi.png",@"home_icon_fanyi.png",@"home_icon_chepiao.png",@"home_icon_gupiao.png",@"home_icon_kuaidi.png", nil];
    
    _convenienceTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64 - 49)];
    _convenienceTableView.tableFooterView = [[UIView alloc]init];
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
        HYZTopCell *cell = [[HYZTopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil backgroundImage:[UIImage imageNamed:@"home_icon_bianmin_top.png"]];
        
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
                
                webViewController.urlString = [NSString stringWithFormat:@"%@vipeng/web/weix/go_wether.do",URL_HTTP];
            }
                break;
            case 1:
            {
                webViewController.titleString = [_itemNameArray objectAtIndex:indexPath.row];
                
                webViewController.urlString = [NSString stringWithFormat:@"%@vipeng/web/weix/go_fanyi.do",URL_HTTP];
            }
                break;
            case 2:
            {
                webViewController.titleString = [_itemNameArray objectAtIndex:indexPath.row];
                
                webViewController.urlString = [NSString stringWithFormat:@"%@vipeng/web/weix/go_chepiao.do",URL_HTTP];
            }
                break;
            case 3:
            {
                webViewController.titleString = [_itemNameArray objectAtIndex:indexPath.row];
                
                webViewController.urlString = [NSString stringWithFormat:@"%@vipeng/web/weix/go_gupiao.do",URL_HTTP];
            }
                break;
            case 4:
            {
                webViewController.titleString = [_itemNameArray objectAtIndex:indexPath.row];
                
                webViewController.urlString = [NSString stringWithFormat:@"http://m.kuaidi100.com"];
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
