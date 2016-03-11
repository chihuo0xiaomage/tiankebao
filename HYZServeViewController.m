//
//  HYZServeViewController.m
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-25.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "HYZServeViewController.h"
#import "ServerViewCell.h"
#import "HYZQuit.h"
#import "CustomerSurveyViewController.h"
#import "OrderViewController.h"
#define BUTTON_WIDTH 106

#define BUTTON_HEIGHT 106

@interface HYZServeViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UIAlertViewDelegate>
{
    UICollectionView * _collectionView;
    NSArray          * _titleArray;
    NSArray          * _imageArray;
}
@end

@implementation HYZServeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @"服务";
        self.navigationItem.title = @"服务";
        self.tabBarItem.image = [UIImage imageNamed:@"icon_4_n.png"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUND_COLOR;
    _titleArray = [NSArray arrayWithObjects:@"余额积分", @"消费历史", @"金额变动", @"电子券", @"密码修改", @"挂失", @"解挂",@"我的", @"退出", nil];
    _imageArray = [NSArray arrayWithObjects:@"yueyulan.png", @"xiaofeilishi.png", @"yuebiandong.png", @"dianziquan.png",@"mimaxiugai.png", @"guashi.png", @"jiegua.png", @"wode.png", @"tuichu.png", nil];
    [self initWithCollectionView];
    
}
- (void)initWithCollectionView
{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(106, 106);
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.minimumInteritemSpacing = 1;
    layout.minimumLineSpacing = 1;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [_collectionView registerClass:[ServerViewCell class] forCellWithReuseIdentifier:@"serverViewCell"];
    _collectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_collectionView];
    
}
//- (void)imageButtonClicked:(NSString *)tag
//{
//        //    查看沙盒，看看有没有用户的登录信息
//    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    
//    NSString *filePath = [docDir stringByAppendingPathComponent:@"USERMESSAGE.plist"];
//    
//    NSArray *array = [[NSArray alloc]initWithContentsOfFile:filePath];
//    
//    if ([array objectAtIndex:0] && [array objectAtIndex:1] && ![tag  isEqual: @"退出"])
//        {
//        if ([tag isEqualToString:@"余额积分"])
//            {
//            [self.navigationController pushViewController:[[HYZBalanceViewController alloc] init] animated:YES];
//            }
//        else if ([tag isEqualToString:@"消费历史"])
//            {
//            [self.navigationController pushViewController:[[HYZHistoryViewController alloc] init] animated:YES];
//            }
//        else if ([tag isEqualToString:@"金额变动"])
//            {
//            [self.navigationController pushViewController:[[HYZMoneyChangeViewController alloc] init] animated:YES];
//            }
//        else if ([tag isEqualToString:@"电子券"])
//            {
//            [self.navigationController pushViewController:[[HYZQueruTheElectronicTicketViewController alloc] init] animated:YES];
//            }
//        else if ([tag isEqualToString:@"密码修改"])
//            {
//            [self.navigationController pushViewController:[[HYZChangePasswordViewController alloc] init] animated:YES];
//            }
//        else if ([tag isEqualToString:@"挂失"])
//            {
//            [self.navigationController pushViewController:[[HYZReportMyCardViewController alloc] init] animated:YES];
//            }
//        else if ([tag isEqualToString:@"解挂"])
//            {
//            [self.navigationController pushViewController:[[HYZOpenMyCardViewController alloc] init] animated:YES];
//            }
//        else if ([tag isEqualToString:@"我的"])
//            {
//            [self.navigationController pushViewController:[[HYZMineViewController alloc] init] animated:YES];
//            }
//        }
//    else if ([tag isEqualToString:@"退出"])
//        {
//        if ([array firstObject]== nil && [array objectAtIndex:1] == nil) {
//            UIAlertView * alertView1 = [[UIAlertView alloc]
//                                        initWithTitle:@"提示"  message:@"亲，您还没有登录呀!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//            [alertView1 show];
//        }else
//            {
//            _alertView2 = [[UIAlertView alloc]
//                           initWithTitle:@"提示" message:@"您确定退出吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//            [_alertView2 show];
//            }
//        }
//    else
//        {
//        [self.navigationController pushViewController:[[HYZLoginViewController alloc] init] animated:YES];
//        }
//    
//    
//}

#pragma mark -
#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        
        [[HYZQuit alloc] initQuit];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString * filePath = [documentPath stringByAppendingPathComponent:@"USERMESSAGE.plist"];
    NSArray * userArray = [NSArray arrayWithContentsOfFile:filePath];
    NSLog(@"================%@", userArray);
    if ([userArray objectAtIndex:0] && [userArray objectAtIndex:1]) {
        switch (indexPath.item) {
                    //积分余额
            case 0:
                [self.navigationController pushViewController:[[HYZBalanceViewController alloc] init] animated:YES];
                break;
                    //消费历史
            case 1:
                [self.navigationController pushViewController:[[HYZHistoryViewController alloc] init] animated:YES];
                break;
                    //金额变动
            case 2:
                [self.navigationController pushViewController:[[HYZMoneyChangeViewController alloc] init] animated:YES];
                break;
                    //电子券
            case 3:
                [self.navigationController pushViewController:[[HYZQueruTheElectronicTicketViewController alloc] init] animated:YES];
                break;
                    //密码修改
            case 4:
                [self.navigationController pushViewController:[[HYZChangePasswordViewController alloc] init] animated:YES];
                break;
                    //挂失
            case 5:
                [self.navigationController pushViewController:[[HYZReportMyCardViewController alloc] init] animated:YES];
                break;
                    //解挂
            case 6:
                [self.navigationController pushViewController:[[HYZOpenMyCardViewController alloc] init] animated:YES];
                break;
//            case 7:
//                [self.navigationController pushViewController:[[CustomerSurveyViewController alloc] init] animated:YES];
//                break;
//            case 8:[self.navigationController pushViewController:[[OrderViewController alloc] init] animated:YES];
//                break;
                    //我的
            case 7:
                [self.navigationController pushViewController:[[HYZMineViewController alloc] init] animated:YES];
                break;
                    //退出
            case 8:{
                UIAlertView * alertView2 = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您确定退出吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [alertView2 show];
            }
                       default:
                break;
        }
    }else if (indexPath.item == 8){
            UIAlertView * alertView1 = [[UIAlertView alloc]initWithTitle:@"提示"  message:@"亲，您还没有登录呀!" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alertView1 show];
    }else{
        [self.navigationController pushViewController:[[HYZLoginViewController alloc] init] animated:YES];
    }

}
#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _titleArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ServerViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"serverViewCell" forIndexPath:indexPath];
    cell.label.text = [_titleArray objectAtIndex:indexPath.item];
    cell.imageView.image = [UIImage imageNamed:[_imageArray objectAtIndex:indexPath.row]];
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
