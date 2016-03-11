//
//  HYZDMMessageViewController.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-9.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZDMMessageViewController.h"

#import "UIImageView+WebCache.h"

#import "MBProgressHUD.h"

@interface HYZDMMessageViewController ()

@end

@implementation HYZDMMessageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"DM信息";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    if (IOS7){self.automaticallyAdjustsScrollViewInsets = NO;}
    
    _childMessageArray = [[NSArray alloc] init];
    
    _mainMessageDictionary = [[NSDictionary alloc] init];
    
    [self creatTableView];
    
    [self DMMessageQurest];
}

- (void)creatTableView
{
    _DMMessageTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_HEIGHT, WIDTH, HEIGHT-NAVIGATION_HEIGHT-TABBAR_HEIGHT) style:UITableViewStylePlain];
    
    _DMMessageTableView.delegate = self;
    
    _DMMessageTableView.dataSource = self;
    
    [self.view addSubview:_DMMessageTableView];
}

- (void)DMMessageQurest
{
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.labelText = NSLocalizedString(@"加载中...", nil);
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@vipeng/web/sucai/dmdetail.do?messageid=%@",URL_HTTP,_idString];
    
    urlString = [urlString  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    HYZDMMessageRequest * request = [[HYZDMMessageRequest alloc] init];
    
    request.delegate = self;
    
    [request DMMessageRequest:urlString];
}

#pragma mark -
#pragma mark TableViewDataSource -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 380;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {return [_childMessageArray count];}
    
    else{return 1;}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CellIdentifier";
    
    HYZMessageDMCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[HYZMessageDMCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        cell.selected = NO;
    }
    
    if (indexPath.section == 0)
    {
        cell.childTitleLable.text = [[_childMessageArray objectAtIndex:indexPath.row] objectForKey:@"child"];
        
        NSURL *urlString = [NSURL URLWithString:[NSString stringWithFormat:@"%@vipeng/%@",URL_HTTP,[[_childMessageArray objectAtIndex:indexPath.row] objectForKey:@"childimage"]]];
        
        [cell.childImageView setImageWithURL:urlString placeholderImage:[UIImage imageNamed:@"sina_weibo.png"]];
    }
    else{
        cell.childTitleLable.text = [_mainMessageDictionary objectForKey:@"title"];
        
        NSURL *urlString = [NSURL URLWithString:[NSString stringWithFormat:@"%@vipeng/%@",URL_HTTP,[_mainMessageDictionary objectForKey:@"titleimage"]]];
        
        [cell.childImageView setImageWithURL:urlString placeholderImage:[UIImage imageNamed:@"sina_weibo.png"]];
        
        cell.nodeLable.text = [_mainMessageDictionary objectForKey:@"node"];
    }
    return cell;
}

#pragma mark -
#pragma mark HYZDMMessageRequestDelegate -

- (void)getDMMessageSuccess:(NSArray *)messageArray mainmsgDictionary:(NSDictionary *)dictionary
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    _childMessageArray = messageArray;
    
    _mainMessageDictionary = dictionary;
    
    [_DMMessageTableView reloadData];
}

- (void)requestFaild:(NSString *)faildString
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    UIAlertView *alert = [[UIAlertView alloc]
                          
                          initWithTitle:faildString
                          
                          message:@"请检查您的网络设置"
                          
                          delegate:nil
                          
                          cancelButtonTitle:@"确定 "
                          
                          otherButtonTitles:nil, nil];
    
    [alert show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
