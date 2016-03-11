//
//  HYZDetailMessageViewController.m
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-27.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "HYZDetailMessageViewController.h"

#import "UIImageView+WebCache.h"

#import "MBProgressHUD.h"

#import "HYZSinaShareViewController.h"

@interface HYZDetailMessageViewController ()

@end

@implementation HYZDetailMessageViewController

@synthesize messageIdString = _messageIdString;

@synthesize detailMessageArray = _detailMessageArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _detailMessageArray = [[NSArray alloc] init];
    
    if (IOS7){self.automaticallyAdjustsScrollViewInsets = NO;}
    
    _promotionTablleView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64 - 49)];
    
    _promotionTablleView.dataSource = self;
    
    _promotionTablleView.delegate = self;
    
    _promotionTablleView.separatorStyle = NO;
    
    [self.view addSubview:_promotionTablleView];
    
    
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.labelText = NSLocalizedString(@"加载中...", nil);
    
	
    NSString *urlString = [NSString stringWithFormat:@"%@vipeng/web/matter/huodong_detail.do?id=%@",URL_HTTP,_messageIdString];

    HYZPromotionDetainMessageRequest *detailMessage = [[HYZPromotionDetainMessageRequest alloc] initWithUrlString:urlString];
    
    detailMessage.delegate =self;
}

#pragma mark -
#pragma mark HYZPromotionDetainMessageRequestDelegate -

- (void)getMessageSuccess:(NSArray *)messageArray
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    _detailMessageArray = messageArray;
    
    [_promotionTablleView reloadData];
}

- (void)getMessageFaild:(NSString *)FaildString{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              
                              initWithTitle:FaildString
                              
                              message:@"请检查您的网络设置"
                              
                              delegate:nil
                              
                              cancelButtonTitle:@"确定"
                              
                              otherButtonTitles:nil, nil];
    [alertView show];
}

#pragma mark -
#pragma mark UITableViweDataSource -

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 410;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_detailMessageArray count] == 0){return 0;}else{return 1;}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CellIdentifier";
    
    HYZPromotionDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    HYZDetailmessageModel *model = [[HYZDetailmessageModel alloc] initWithDictionary:[_detailMessageArray objectAtIndex:0] error:nil];
    
    if (!cell)
    {
        cell = [[HYZPromotionDetailCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        
        cell.cellDelegate = self;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.smallpromotionLable.text = [NSString stringWithFormat:@"微促销"];
    
    cell.smallImageView.image = [UIImage imageNamed:@"Icon.png"];
    
    cell.detailLable.text = [NSString stringWithFormat:@"  %@",model.huodong_jianjie];
    
    cell.titleLable.text = [NSString stringWithFormat:@"  %@",model.huodong_title];
    
    NSURL *urlString = [NSURL URLWithString:[NSString stringWithFormat:@"%@vipeng/%@",URL_HTTP,model.huodong_head]];
    
    [cell.activityImageView setImageWithURL:urlString placeholderImage:[UIImage imageNamed:@"Icon.png"]];
    
    cell.themeLable.text = [NSString stringWithFormat:@"  %@",model.huodong_jianjie];
    
    cell.detailLable.text = [NSString stringWithFormat:@"  %@",model.huodong_node];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:model.createDate/1000];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    [dateFormat setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSString *createDate = [dateFormat stringFromDate: date];
    
    cell.begainTimeLable.text = [NSString stringWithFormat:@"  %@",createDate];
    
    cell.shareButton.tag = indexPath.row;
    
    return cell;
}

#pragma mark -
#pragma mark HYZPROMOTIONDETAILCELLDELEGATE -

- (void)share:(UIButton *)sender
{
    AWActionSheet *sheet = [[AWActionSheet alloc] initwithIconSheetDelegate:self ItemCount:[self numberOfItemsInActionSheet]];
    
    [sheet showInView:self.view];
}

#pragma mark -
#pragma mark AWActionSheetCellDelegate -

-(int)numberOfItemsInActionSheet
{
    return 4;
}
/*
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
            
            NSString *utf8String = @"http://www.woshang88.com/shop/index.shtml";
            
            NSString *title = @"添客宝";
            
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
*/
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
