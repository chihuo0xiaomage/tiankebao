//
//  HYZRecommendViewController.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-8.
//  Copyright (c) 2014年 apple. All rights reserved.
//
/*
#import "HYZRecommendViewController.h"


@interface HYZRecommendViewController ()

@end

@implementation HYZRecommendViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"应用推荐";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    [self creatImageView];
    
    [self creatShareButton];
}

- (void)creatImageView{
    UIImageView *TwoDimensionCodeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 80, 240, 240)];
    
    TwoDimensionCodeImageView.image = [UIImage imageNamed:@"erweima.png"];
    
    [self.view addSubview:TwoDimensionCodeImageView];
}

- (void)creatShareButton
{
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    shareButton.frame = CGRectMake(40, 330, 240, 30);
    
    [shareButton setTitle:@"分享" forState:UIControlStateNormal];
    
    [shareButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [shareButton setBackgroundColor:[UIColor colorWithRed:230.0/255.0 green:121.0/255.0 blue:23.0/255.0 alpha:1]];
    
    [shareButton addTarget:self action:@selector(shareButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:shareButton];
}

- (void)shareButtonClicked
{
    AWActionSheet *sheet = [[AWActionSheet alloc] initwithIconSheetDelegate:self ItemCount:[self numberOfItemsInActionSheet]];
    
    [sheet showInView:self.view];
}

-(int)numberOfItemsInActionSheet
{
    return 4;
}

-(AWActionSheetCell *)cellForActionAtIndex:(NSInteger)index
{
    AWActionSheetCell* cell = [[AWActionSheetCell alloc] init];
    switch (index)
    {
        case 0:
            [[cell titleLabel] setText:@"新浪微博"];
            cell.iconView.image = [UIImage imageNamed:@"sina_weibo.png"];
            break;
        case 1:
            [[cell titleLabel] setText:@"QQ分享"];
            cell.iconView.image = [UIImage imageNamed:@"qzone.png"];
            break;
        case 2:
            [[cell titleLabel] setText:@"微信朋友圈"];
            cell.iconView.image = [UIImage imageNamed:@"pengyou_icon.png"];
            break;
        case 3:
            [[cell titleLabel] setText:@"微信朋友"];
            cell.iconView.image = [UIImage imageNamed:@"weixin_icon.png"];
            break;
        default:
            [[cell titleLabel] setText:@"899"];
            break;
    }
    cell.index = index;
    return cell;
}

-(void)DidTapOnItemAtIndex:(NSInteger)index
{
    switch (index)
    {
        case 0:
        {
            NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            
            NSString *filePath = [docDir stringByAppendingPathComponent:@"USERMESSAGE.plist"];
            
            NSArray *array = [[NSArray alloc]initWithContentsOfFile:filePath];
            
            if([[array objectAtIndex:3] rangeOfString:@"."].location !=NSNotFound)
            {
                HYZSinaShareViewController *shareViewControlller = [[HYZSinaShareViewController alloc] init];
                
                shareViewControlller.accessTokenString = [array objectAtIndex:3];
                
                [self.navigationController pushViewController:shareViewControlller animated:YES];
            }
            else
            {
                UIAlertView *alertView = [[UIAlertView alloc]
                                          initWithTitle:@"您未使用新浪微博登录"
                                          message:@"暂不能分享到新浪微博"
                                          delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil, nil];
                [alertView show];
            }
        }
            break;
        case 1:
        {
            _tencentOAuth = [[TencentOAuth alloc] initWithAppId:QQ_APP_ID andDelegate:nil];
            
            [_tencentOAuth accessToken];
            
            [_tencentOAuth openId];
            
            NSString *utf8String = @"http://tiankebao.net/index.html";
            
            NSString *title = @"添客宝二维码分享";
            
            NSString *description = @"分享成功!";
            
            NSString *previewImageUrl = @"http://mobile.wp99.cn/vipeng/images/download_code.png";
            
            QQApiNewsObject *newsObj = [QQApiNewsObject
                                        objectWithURL:[NSURL URLWithString:utf8String]
                                        title:title
                                        description:description
                                        previewImageURL:[NSURL URLWithString:previewImageUrl]];
            SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
            
            QQApiSendResultCode sent = [QQApiInterface sendReq:req];
            
            [self handleSendResult:sent];
        }
            break;
        case 2:
        {
            WXMediaMessage *message = [WXMediaMessage message];
            
            message.title = @"添客宝二维码分享";
            
            message.description = @"添客宝专注实体电商O2O服务体验，我们组织了众多优质的电商服务资源，帮助实体店商低成本享有电子商务的成本红利";
            
            [message setThumbImage:[UIImage imageNamed:@"erweimax.png"]];

            WXWebpageObject *ext = [WXWebpageObject object];
            
            ext.webpageUrl = @"http://tiankebao.net/index.html";
            
            message.mediaObject = ext;
            
            SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
            
            req.bText = NO;
            
            req.message = message;
            
            req.scene = WXSceneTimeline;
            
            [WXApi sendReq:req];
        }
            break;
        case 3:
        {
            WXMediaMessage *message = [WXMediaMessage message];
            
            message.title = @"添客宝二维码分享";
            
            message.description = @"添客宝专注实体电商O2O服务体验，我们组织了众多优质的电商服务资源，帮助实体店商低成本享有电子商务的成本红利";
            
            [message setThumbImage:[UIImage imageNamed:@"erweimax.png"]];

            WXWebpageObject *ext = [WXWebpageObject object];
            
            ext.webpageUrl = @"http://tiankebao.net/index.html";
            
            message.mediaObject = ext;
            
            SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
            
            req.bText = NO;
            
            req.message = message;
            
            req.scene = WXSceneSession;
            
            [WXApi sendReq:req];
        }
            break;
        default:
            break;
    }
}

- (void)handleSendResult:(QQApiSendResultCode)sendResult
{
    switch (sendResult)
    {
        case EQQAPIAPPNOTREGISTED:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"App未注册" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case EQQAPIMESSAGECONTENTINVALID:
        case EQQAPIMESSAGECONTENTNULL:
        case EQQAPIMESSAGETYPEINVALID:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"发送参数错误" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case EQQAPIQQNOTINSTALLED:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"未安装手Q" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case EQQAPIQQNOTSUPPORTAPI:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"API接口不支持" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case EQQAPISENDFAILD:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"发送失败" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        default:
        {
            break;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end*/
