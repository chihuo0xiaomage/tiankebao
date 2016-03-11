//
//  HYZSettingViewController.m
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-31.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "HYZSettingViewController.h"
#import "MBProgressHUD.h"

@interface HYZSettingViewController ()

@end

@implementation HYZSettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"更多";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (IOS7){
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
	self.view.backgroundColor = BACKGROUND_COLOR;
    _itemNameArray = [[NSArray alloc] initWithObjects:@"修改密码",@"帮助",@"意见反馈",@"关于添客宝",@"安全退出", nil];
    _itemImageArray = [[NSArray alloc] initWithObjects:@"more_icon_editpwd.png",@"more_icon_help.png",@"more_icon_feedback.png",@"more_icon_about.png",@"more_icon_exit.png", nil];
    
    UITableView *itemTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64 - 49)];
    itemTableView.tableFooterView = [[UIView alloc]init];
    itemTableView.dataSource = self;
    itemTableView.delegate = self;
    [self.view addSubview:itemTableView];
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
    if (section == 0){
        return 1;
    } else {
        return [_itemNameArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){
        HYZTopCell *cell = [[HYZTopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil backgroundImage:[UIImage imageNamed:@"main_icon_top.png"]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.selected = NO;
        return cell;
    }else{
        static NSString *cellIdentifier = @"CellIdentifier";
        HYZSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell){
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
    if (indexPath.section == 0){
        return;
    }else{
        switch (indexPath.row){
            case 0:
            [self.navigationController pushViewController:[[HYZChangePSWViewController alloc] init] animated:YES];
                break;
            case 1:
                break;
            case 2:
                [self.navigationController pushViewController:[[HYZFeedBackViewController alloc] init] animated:YES];
                break;
            case 3:
                [self.navigationController pushViewController:[[HYZAboutViewController alloc] init] animated:YES];
                break;
//            case 4:
//                [self.navigationController pushViewController:[[HYZRecommendViewController alloc] init] animated:YES];
//                break;
//            case 5:{
//                MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//                hud.labelText = NSLocalizedString(@"加载中...", nil);
//                HYZInspectRequest *request = [[HYZInspectRequest alloc] init];
//                NSString *urlString = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=680107964"];
//                request.delegate = self;
//                [request updata:urlString];
//            }
//                break;
            case 4:{
                UIActionSheet *actionSheet =[[UIActionSheet alloc]initWithTitle:@"确认退出"delegate:self cancelButtonTitle:@"取消"
                    destructiveButtonTitle:@"确定"
                    otherButtonTitles:nil, nil];
                [actionSheet showInView:self.view];
            }
                break;
            default:
                break;
        }
    }
}

#pragma mark -
#pragma mark HYZInspectRequestDelegate -
/*
- (void)getVersionSuccess:(NSString *)nowVersion
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];

    if ([version isEqualToString:nowVersion]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@""
                              message:@"当前为最新版本"
                              delegate:nil
                              cancelButtonTitle:@"确定 "
                              otherButtonTitles:nil, nil];
        [alert show];
    }else{
        UIAlertView *alertNewVer = [[UIAlertView alloc] initWithTitle:nil message:@"版本有更新" delegate:self cancelButtonTitle:@"取消"
            otherButtonTitles:@"更新", nil];
        alertNewVer.tag = 10;
        [alertNewVer show];
    }
}

- (void)getVersionFaild:(NSString *)faileString
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    UIAlertView *alert = [[UIAlertView alloc]
                          
                          initWithTitle:faileString
                          
                          message:@"请检查您的网络设置"
                          
                          delegate:nil
                          
                          cancelButtonTitle:@"确定 "
                          
                          otherButtonTitles:nil, nil];
    [alert show];
}
#pragma mark -
#pragma mark UIAlertViewDelegate -

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 10 && buttonIndex==1){
//        跳入appstore下载新版本
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/wei-peng/id680107964?mt=8&uo=4"]];
    }
}
*/
#pragma mark -
#pragma mark UIActionSheetDelegate -

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if (buttonIndex == 0) {
        [[HYZQuit alloc] initQuit];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
