//
//  HYZPromotionViewController.m
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-25.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "HYZPromotionViewController.h"

#import "UIImageView+WebCache.h"

#import "MBProgressHUD.h"

@interface HYZPromotionViewController ()

@end

@implementation HYZPromotionViewController

@synthesize messageArray = _messageArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @"促销";
        
        self.navigationItem.title = @"促销";        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _messageArray = [[NSArray alloc] init];
    
    [self creatMyTableView];
}

- (void)creatMyTableView
{
    if (IOS7){self.automaticallyAdjustsScrollViewInsets = NO;}
    
    _promotionTablleView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, 320, HEIGHT - 64 - 49)];
    
    _promotionTablleView.dataSource = self;
    
    _promotionTablleView.delegate = self;
    
    [self.view addSubview:_promotionTablleView];
    
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.labelText = NSLocalizedString(@"加载中...", nil);
    
    NSString *urlString = [NSString stringWithFormat:@"%@vipeng/web/matter/huodong.do?pageNumber=1&pageSize=100",URL_HTTP];
        //NSString * urlString = [NSString stringWithFormat:@"%@vipeng/web/lottery/seckill.do",URL_HTTP];
    HYZPromotionRequest *request = [[HYZPromotionRequest alloc] initWithUrlString:urlString];
    request.delegate = self;
}

#pragma mark -
#pragma mark HYZPromotionRequestDelegate -

- (void)getmessageSuccess:(NSArray *)messageArray
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    _messageArray = messageArray;
    
    [_promotionTablleView reloadData];
    
}

- (void)getmessageFaild:(NSString *)faildString
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              
                              initWithTitle:faildString
                              
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
    return 265;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_messageArray count] == 0)
    {
        return 0;
    }
    else
    {
        return [_messageArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CellIdentifier";
    
    HYZPromotionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
     HYZPromotionModel *model = [[HYZPromotionModel alloc] initWithDictionary:[_messageArray objectAtIndex:indexPath.row] error:nil];
    
    if (!cell)
    {
        cell = [[HYZPromotionCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier headImage:@"Icon.png" title:@"微促销"];
        
        cell.cellDelegate =self;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.titleTimeLable.text = [NSString stringWithFormat:@"【%@】", model.huodong_title];
    
    cell.detailLable.text = [NSString stringWithFormat:@"  %@",model.huodong_jianjie];
    
    NSURL *urlString = [NSURL URLWithString:[NSString stringWithFormat:@"%@vipeng/%@",URL_HTTP,model.huodong_head]];
    
    [cell.activityImageView setImageWithURL:urlString placeholderImage:[UIImage imageNamed:@"Icon.png"]];
    
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:model.createDate/1000];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    [dateFormat setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSString *createDate = [dateFormat stringFromDate: date];
    
    cell.begainTimeLable.text = [NSString stringWithFormat:@"  %@",createDate];
    
    cell.shareButton.tag = indexPath.row;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYZDetailMessageViewController *detailMessageViewController = [[HYZDetailMessageViewController alloc] init];
    
    HYZPromotionModel *model = [[HYZPromotionModel alloc] initWithDictionary:[_messageArray objectAtIndex:indexPath.row] error:nil];
    
    detailMessageViewController.messageIdString = model.id;
    
    [self.navigationController pushViewController:detailMessageViewController animated:YES];
    
}

#pragma mark -
#pragma mark HYZPROMOTIONCELLDELEGATE -

-(void)shareButtonClicke:(UIButton *)sender
{
    AWActionSheet *sheet = [[AWActionSheet alloc] initwithIconSheetDelegate:self ItemCount:[self numberOfItemsInActionSheet]];
    
    [sheet showInView:self.view];
}

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
            
            NSString *title = @"微朋";
            
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
            ext.webpageUrl = @"http://tiankebao.net/index.html#";
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
            ext.webpageUrl = @"http://tiankebao.net/index.html#";
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
