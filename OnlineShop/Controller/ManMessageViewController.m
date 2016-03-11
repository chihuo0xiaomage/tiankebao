//
//  ManMessageViewController.m
//  WeiPeng
//
//  Created by 宝源科技 on 14-8-19.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "ManMessageViewController.h"
#import "ManMessageTableViewCell.h"
#import "ReceivingInformationViewController.h"
#import "NetWorking.h"
#import "Encrypt.h"
#import "NewAddressViewController.h"
#import "BYAlipay.h"
#import "NewAddressViewController.h"
#import "HYZAppDelegate.h"
#import "ChineseToPinyin.h"
static NSString * const manMessage = @"manMessage";
static NSString * const orderItem = @"orderItem";
@interface ManMessageViewController ()<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
{
    UIView  * aView;
    UILabel * _message;
    UILabel * _nameLabel;
    UILabel * _phoneLabel;
    UILabel * _addressLabel;
    UITableView * _tableView;
    UIView  * _barView;
    UILabel * _sumLabel;
    float     _sumPrice;
    NSArray * _requestArray;
    NSArray * _payCodeArray;
    NSDictionary * _addressDic;
    NSMutableDictionary * _shopInformation;
}
@property(nonatomic, strong)BYAlipay * alipay;
@end

@implementation ManMessageViewController

    //订单界面
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"填写订单";
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    _nameLabel.text = @"";
    _phoneLabel.text = @"";
    _addressLabel.text = @"";
   NSDictionary * dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"address"];
    if (dic == NULL) {
        [self manMessageStartRequest];
    }else{
        _addressDic = dic;
        _nameLabel.text = [[NSString stringWithFormat:@"姓名:%@", [dic objectForKey:@"name"]] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        _phoneLabel.text = [NSString stringWithFormat:@"手机:%@", [dic objectForKey:@"phone"]];
        _addressLabel.text = [NSString stringWithFormat:@"地址:%@", [dic objectForKey:@"areaName"]];
    }
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:manMessage object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:orderItem object:nil];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(manMessageSuccefulData:) name:manMessage object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(submittedSuccessfully:) name:orderItem object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(returnsTheResult:) name:@"paymentCoding" object:nil];
    [self sumPrice];
    [self initWithControl];
    [self initWithTableView];
    [self paymentCoding];
    
}
- (void)paymentCoding
{
    CGFloat time = [Encrypt timeInterval];
    NSString * keyValues = [NSString stringWithFormat:@"appKey=00001&method=wop.product.order.paymentMethod.get&v=1.0&format=json&locale=zh_CN&timestamp=%.0f&client=iPhone", time];
    NSString * sign = [Encrypt generate:keyValues];
    NSString * urlStr = [NSString stringWithFormat:@"%@?%@&sign=%@", HTTP, keyValues, sign];
        //NSLog(@"%@", urlStr);
    [NetWorking NetWorkingURL:urlStr target:nil action:nil identifier:@"paymentCoding"];
    
}
- (void)returnsTheResult:(NSNotification *)nsnotification
{
   _payCodeArray = [[NSJSONSerialization JSONObjectWithData:[nsnotification object] options:0 error:nil] objectForKey:@"paymentMethodList"];
        //NSLog(@"_payCodeArray = %@", _payCodeArray);
}
- (void)manMessageStartRequest
{
    CGFloat time = [Encrypt timeInterval];
    NSString * keyValues = [NSString stringWithFormat:@"appKey=00001&method=wop.product.receiver.list.get&v=1.0&format=json&locale=zh_CN&timestamp=%.0f&client=iPhone&memberId=%@", time, MEMBERID];
    NSString * sign = [Encrypt generate:keyValues];
    NSString * urlStr = [NSString stringWithFormat:@"%@?%@&sign=%@", HTTP, keyValues, sign];
    [NetWorking NetWorkingURL:urlStr target:nil action:nil identifier:manMessage];
}
- (void)manMessageSuccefulData:(NSNotification *)notification
{
    NSData * data = notification.object;
    _requestArray = [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] objectForKey:@"receivers"];
    if (_requestArray.count == 0) {
        UILabel * label = [[UILabel alloc] initWithFrame:aView.frame];
        //label.text = @"  您还没有建收货地址呀!";
        label.tag = 1000;
        label.textColor = [UIColor redColor];
        label.font = [UIFont systemFontOfSize:22.0];
        [self.view addSubview:label];
        return;
    }
    NSDictionary * dic = [_requestArray objectAtIndex:0];
    _addressDic = dic;
    _nameLabel.text = [[NSString stringWithFormat:@"姓名:%@", [dic objectForKey:@"name"]] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    _phoneLabel.text = [NSString stringWithFormat:@"手机:%@", [dic objectForKey:@"phone"]];
    _addressLabel.text = [NSString stringWithFormat:@"地址:%@", [dic objectForKey:@"areaName"]];
}
- (void)sumPrice
{
    for (NSDictionary *dic in _receiveArray) {
        _sumPrice += [[dic objectForKey:@"price"] floatValue];
    }
    _sumLabel.text = [NSString stringWithFormat:@"应付金额:%.2f", _sumPrice];
}
- (void)initWithControl
{
    aView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, 320, 110)];
    aView.layer.borderWidth = 1.0;
    [self.view addSubview:aView];
    
    _message = [[UILabel alloc] initWithFrame:CGRectMake(10, -25, 120, 25)];
    [aView addSubview:_message];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_message.frame.origin.x, _message.frame.origin.y + _message.bounds.size.height, 240, 20)];
    _nameLabel.font = [UIFont systemFontOfSize:14.0];
    [aView addSubview:_nameLabel];
    
    _phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(_nameLabel.frame.origin.x, _nameLabel.frame.origin.y + _nameLabel.bounds.size.height, 240, 20)];
    _phoneLabel.font = [UIFont systemFontOfSize:14.0];
    [aView addSubview:_phoneLabel];
    
    _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(_phoneLabel.frame.origin.x, _phoneLabel.frame.origin.y + _phoneLabel.bounds.size.height, 240, 40)];
    _addressLabel.font = [UIFont systemFontOfSize:14.0];
    _addressLabel.numberOfLines = 0;
    [aView addSubview:_addressLabel];
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(_addressLabel.frame.origin.x + _addressLabel.bounds.size.width, _message.frame.origin.y, 100, 160)];
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeAddress)];
    [aView addGestureRecognizer:tap];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(_message.frame.origin.x, _addressLabel.frame.origin.y + _addressLabel.bounds.size.height, 240, 30)];
    label.text = @"订单详情:";
    label.textColor = [UIColor orangeColor];
    [aView addSubview:label];
}
- (void)changeAddress
{
    if (_requestArray.count == 0 && [[NSUserDefaults standardUserDefaults] objectForKey:@"address"] == NULL) {
        [self.navigationController pushViewController:[[NewAddressViewController alloc] init] animated:YES];
        return;
    }
    ReceivingInformationViewController * receiviVC = [[ReceivingInformationViewController alloc] init];
    [self.navigationController pushViewController:receiviVC animated:YES];
}
- (void)initWithTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(aView.frame.origin.x, aView.bounds.size.height + 64, 320, self.view.bounds.size.height - aView.bounds.size.height - 64 - 49) style:UITableViewStylePlain];
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    _barView = [[UIView alloc] initWithFrame:CGRectMake(0, _tableView.frame.origin.y + _tableView.bounds.size.height, 320, 49)];
    _barView.layer.borderWidth = 1.0;
    _barView.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addSubview:_barView];
    
    _sumLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 9, 200, 30)];

    _sumLabel.textAlignment = NSTextAlignmentCenter;
    _sumLabel.text = self.sendSumPrice;
    [_barView addSubview: _sumLabel];
    
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(_sumLabel.frame.origin.x + _sumLabel.bounds.size.width, _sumLabel.frame.origin.y, 120, 30);
    [button setTitle:@"提交订单" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(submitOrders) forControlEvents:UIControlEventTouchUpInside];
    [_barView addSubview:button];
}

- (void)submitOrders
{
    if ([_nameLabel.text isEqualToString:@""]) {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您还没有建立收货地址呀!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.tag = 200;
        [alertView show];
        return;
    }

//    NSString * payMethodName = [@"支付宝" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSString * deliveryMethodName = [@"物流" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSDictionary * dic = @{@"memberId":@"257716650676060160",@"goodsTotalQuantity":[NSNumber numberWithInt:2],@"goodsTotalPrice":[NSNumber numberWithInt:20000],@"deliveryFee":[NSNumber numberWithInt:130],@"totalAmount":[NSNumber numberWithInt:1000], @"paymentMethodId":@"000", @"payMethodName":@"zhengzhou", @"deliveryMethodId":@"123456",@"deliveryMethodName":@"wuliu",@"shipName":@"zhangying",@"shipAreaId":@"55555", @"shipAreaPath":@"anhuadasa",@"shipAddress":@"dasa",@"shopZipCode":@"23425243", @"shipPhone":@"0000000"};
//    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
//    NSString * json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSLog(@"json = %@", json);
//    NSArray * array = @[@{@"goodsId": @"257234193564565504",@"quantity":[NSNumber numberWithInt:2]}];
//    NSData * jsonData1 = [NSJSONSerialization dataWithJSONObject:array options:0 error:nil];
//    NSString * json1 = [[NSString alloc] initWithData:jsonData1 encoding:NSUTF8StringEncoding];
//    
//    NSString * order = @"{\"memberId\":\"257716650676060160\",\"goodsTotalQuantity\":1,\"goodsTotalPrice\":23.5,\"deliveryFee\":\"10\",\"totalAmount\":33.5,\"paymentMethodId\":\"00\",\"paymentMethodName\":\"在线支付\",\"deliveryMethodId\":\"1\",\"deliveryMethodName\":\"快递\",\"shipName\":\"蓝血人1\",\"shipAreaId\":\"0371\",\"shipAreaPath\":\"河南省郑州市金水区\",\"shipAddress\":\"河南省郑州市二七区小关镇\",\"shopZipCode\":\"100000\",\"shipPhone\":\"\",\"shipMobile\":\"13526899839\"}";
//    NSString * orderItemArray = @"[{\"goodsId\":\"268565150884167680\",\"quantity\":1}]";
//    
//    
//    
//    CGFloat time = [Encrypt timeInterval];
//    NSString * keyValues = [NSString stringWithFormat:@"appKey=00001&method=wop.product.order.add&v=1.0&format=json&locale=zh_CN&timestamp=%.0f&client=iPhone&order=%@&orderItemArray=%@", time, json, json1];
//    NSString * sign = [Encrypt generate:keyValues];
//    NSLog(@"sign = %@", sign);
//    NSString * urlStr = [NSString stringWithFormat:@"http://zzbaoyuan.f3322.org:8081/web-open/api?%@&sign=%@", keyValues, sign];
//    NSLog(@"%@", urlStr);
//    [NetWorking NetWorkingURL:urlStr target:nil action:nil identifier:orderItem];

//    NSDictionary * order = @{@"memberId": @"257716650676060160",@"goodsTotalQuantity":@1,@"goodsTotalPrice":@(23.5),@"deliveryFee":@10,@"totalAmount":@(33.5),@"paymentMethodId":@"00",@"payMethodName":@"zaixianzifu",@"deliveryMethodId":@"1",@"deliveryMethodName":@"kuaidi",@"shipName":@"lanxieren",@"shipAreaId":@"0371",@"shipAreaPath":@"henansheng",@"shipAddress":@"zhengzhou",@"shopZipCode":@"100000",@"shipMobile":@"13526899839"};
//    NSLog(@"%@", order);
//    NSData * dataOrder = [NSJSONSerialization dataWithJSONObject:order options:0 error:nil];
//    NSString * jsonOrder = [[NSString alloc] initWithData:dataOrder encoding:NSUTF8StringEncoding];
//    NSLog(@"jsonOrder = %@", jsonOrder);
//    NSArray * orderItemArray = @[@{@"goodsId": @"267439505030512640",@"quantity":@2}];
//    NSData * dataOrderItemArray = [NSJSONSerialization dataWithJSONObject:orderItemArray options:0 error:nil];
//    NSString * jsonOrderItemArray = [[NSString alloc] initWithData:dataOrderItemArray encoding:NSUTF8StringEncoding];
//    NSLog(@"%@", jsonOrderItemArray);

    
    
    

//   NSDictionary * dic = @{@"memberID": MEMBERID, @"goodsTotalQuantity":[NSNumber numberWithInteger: _receiveArray.count], @"goodsTotalPrice":[NSNumber numberWithFloat:price], }

    
        //会员编码
//    NSString * memberId = MEMBERID;
//        //商品总数
//    NSString * total = [self.sendSumPrice substringWithRange:NSMakeRange(0, 1)];
        //商品总价格
        //float price = [[[self.sendSumPrice componentsSeparatedByString:@"￥"] lastObject] floatValue];
        //配送费用
        //订单总额
        //支付方式编码
        //支付方式
        //配送方式编码
        //配送方式名称
        //收货人姓名
        //收货地区路径
        //收货地址
        //收货邮编
        //收货电话
        //收货手机
//    NSString * orderItemArray = @"[{\"quantity\":1,\"goodsId\":\"268565150884167680\"}, {\"quantity\":1,\"goodsId\":\"268565150884167680\"}]";
    
    
    NSMutableArray *orderItemArray = [NSMutableArray array];
    for (NSDictionary * dic in _receiveArray) {
        NSString * quantity = [NSString stringWithFormat:@"%@", [dic objectForKey:@"quantity"]];
        
        NSString * goodID = [NSString stringWithFormat:@"%@", [dic objectForKey:@"gid"]];
        NSDictionary * shopDic = @{@"quantity": quantity, @"goodsId":goodID};
        [orderItemArray addObject:shopDic];
    }
    
    NSData *orderItemData = [NSJSONSerialization dataWithJSONObject:orderItemArray options:0 error:nil];
    NSString *jsonOrderItem = [[NSString alloc] initWithData:orderItemData encoding:NSUTF8StringEncoding];
        //NSLog(@"%@", jsonOrderItem);
        //NSString * order = @"{\"goodsTotalQuantity\":1,\"goodsTotalPrice\":23.5,\"totalAmount\":33.5,\"deliveryFee\":\"10\",\"paymentMethodId\":\"00\",\"paymentMethodName\":\"zaixianzifu\",\"deliveryMethodId\":\"1\",\"deliveryMethodName\":\"di\",\"shipName\":\"lanxueren\",\"shipAreaId\":\"0371\",\"shipAreaPath\":\"henanseng\",\"shipAddress\":\"zhengzhoushi\",\"shopZipCode\":\"100000\",\"shipPhone\":\"\",\"shipMobile\":\"13526899839\",\"memberId\":\"264120311794892800\"}";
        //NSString * order = @"{\"deliveryMethodId\":\"1\",\"shipAddress\":\"Sdafadsf\",\"paymentMethodId\":\"255766094097152022\",\"shipName\":\"lanxueren\",\"totalAmount\":33.5,\"shopZipCode\":\"sdfsdf\",\"deliveryFee\":0,\"goodsTotalPrice\":23.5,\"shipAreaId\":\"0371\",\"shipAreaPath\":\"150000,150500,150525\",\"memberId\":\"257716650676060160\",\"shipPhone\":\"13526899839\",\"goodsTotalQuantity\":1,\"paymentMethodName\":\"在线支付\",,\"deliveryMethodName\":\"di\"}";
    int quantity = 0;
    float price = 0.0;
    for (NSDictionary * dic in _receiveArray) {
        quantity += [[dic objectForKey:@"quantity"] integerValue];
        price += [[dic objectForKey:@"price"] floatValue] * [[dic objectForKey:@"quantity"] integerValue];
    }

    NSString * payCode = [[_payCodeArray firstObject] objectForKey:@"paymentMethodID"];
        //NSLog(@"payName = %@", [[_payCodeArray firstObject] objectForKey:@"paymentMethodName"]);
    NSString * payName = [[ChineseToPinyin pinyinFromChiniseString:[[_payCodeArray firstObject] objectForKey:@"paymentMethodName"]] lowercaseString];
        //问题一
    NSString * shopName = [[ChineseToPinyin pinyinFromChiniseString:_nameLabel.text] lowercaseString];
        //NSLog(@"shopName = %@", shopName);
    NSString * shipAreaId = [NSString stringWithFormat:@"%@", [_addressDic objectForKey:@"areaId"]];
    NSString * areaPath = [NSString stringWithFormat:@"%@", [_addressDic objectForKey:@"areaPath"]];
    NSString * address =[[ChineseToPinyin pinyinFromChiniseString:[[_addressDic objectForKey:@"address"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] lowercaseString];
    NSString * zipCode = [NSString stringWithFormat:@"%@", [_addressDic objectForKey:@"zipCode"]];
    NSString * phone = [NSString stringWithFormat:@"%@", [_addressDic objectForKey:@"phone"]];
    NSDictionary *orderDic = @{@"payType":@"online",@"memberId": MEMBERID, @"goodsTotalQuantity":[NSNumber numberWithInteger:quantity], @"goodsTotalPrice":[NSNumber numberWithFloat:price], @"totalAmount":[NSNumber numberWithFloat:price], @"deliveryFee":[NSNumber numberWithFloat:0.0], @"paymentMethodId":payCode, @"paymentMethodName":payName, @"deliveryMethodId":@"1", @"deliveryMethodName":@"de",@"shipName":shopName, @"shipAreaId":shipAreaId, @"shipAreaPath":areaPath, @"shipAddress":address, @"shopZipCode":zipCode, @"shipPhone":phone};
    NSData * orderData = [NSJSONSerialization dataWithJSONObject:orderDic options:0 error:nil];
    NSString * jsonOrder = [[NSString alloc] initWithData:orderData encoding:NSUTF8StringEncoding];
    

    CGFloat time = [Encrypt timeInterval];
    NSString * keyValues = [NSString stringWithFormat:@"appKey=00001&method=wop.product.order.add&v=1.0&format=json&locale=zh_CN&timestamp=%.0f&client=iPhone&order=%@&orderItemArray=%@",time, jsonOrder, jsonOrderItem];

    NSString * sign = [Encrypt generate:keyValues];

    NSString * body = [NSString stringWithFormat:@"%@&sign=%@", keyValues, sign];
    NSArray * array = [NSArray arrayWithObjects:HTTP, body, nil];
    
    _shopInformation = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:quantity], @"quantity", [NSNumber numberWithFloat:price], @"price", nil];
    
    [NetWorking NetWorkingURLArray:array target:nil action:nil identifier:orderItem];

}
- (void)submittedSuccessfully:(NSNotification *)notification
{
    NSData * data = notification.object;
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"orderSn"] forKey:@"orderSn"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [_shopInformation setObject:[dic objectForKey:@"orderSn"] forKey:@"orderSn"];
    NSString * resultCode = [[[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] objectForKey:@"resultCode"] stringValue];
    if ([resultCode isEqualToString:@"0"]) {
        ((HYZAppDelegate *)[[UIApplication sharedApplication] delegate]).aPay = YES;
       self.alipay = [[BYAlipay alloc] init];
        [_alipay startPayMoney:_shopInformation];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _receiveArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIderfier = @"cell";
    ManMessageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIderfier];
    if (cell == nil) {
        cell = [[ManMessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIderfier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.manMessageDic = [_receiveArray objectAtIndex:indexPath.row];
    return cell;
}
#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
     if (buttonIndex == 1){
         [self changeAddress];
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [[self.view viewWithTag:1000] removeFromSuperview];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
