    //
    //  HYZShoppingCarViewController.m
    //  WeiPeng
    //
    //  Created by 韩亚周 on 13-12-23.
    //  Copyright (c) 2013年 apple. All rights reserved.
    //

#import "HYZShoppingCarViewController.h"

#import "mysql.h"

#import "HYZShoppingCarModel.h"

#import "HYZShoppingCarViewController.h"

#import "WebViewController.h"

@interface HYZShoppingCarViewController ()

@property (nonatomic, strong) ZBarReaderViewController *reader;

@property (nonatomic, strong) NSArray                  *messageArray;

@end

@implementation HYZShoppingCarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @"快购";
        self.navigationItem.title = @"快购";
        self.tabBarItem.image = [UIImage imageNamed:@"icon_3_n.png"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUND_COLOR;
    _messageArray = [[NSArray alloc] init];
    [self creatSubViews];
}

- (void)creatSubViews
{
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(20, NAVIGATION_HEIGHT +20, WIDTH - 20 -20, 260)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backgroundView];
    
    UIImageView *upImageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 10, 180, 180)];
    upImageView.image = [UIImage imageNamed:@"cart_icon_null.png"];
    [backgroundView addSubview:upImageView];
    UIImageView *downImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 210, 280, 30)];
    downImageView.image = [UIImage imageNamed:@"cart_icon_font_null.png"];
    [backgroundView addSubview:downImageView];
    
    
    UIButton *scanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    scanButton.frame = CGRectMake(20, NAVIGATION_HEIGHT + 300, WIDTH - 20 -20, 40);
    [scanButton setTitle:@"扫码购物" forState:UIControlStateNormal];
    [scanButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [scanButton addTarget:self action:@selector(scanButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [scanButton setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:scanButton];
    
    _messageArray =(NSMutableArray *)[[mysql shareMysql] show:[NSString stringWithFormat:@"select * from ShoppingCarTableView"]];
}

- (void)scanButtonClicked
{
    if (_reader == NULL) {
        _reader = [[ZBarReaderViewController alloc] init];
        _reader.readerDelegate = self;
        _reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    }
        //非全屏
        //    reader.wantsFullScreenLayout = NO;
    
        //隐藏底部控制按钮
        //    reader.showsZBarControls = NO;
    
        //设置自己定义的界面
    [self setOverlayPickerView:_reader];
    
    ZBarImageScanner *scanner = _reader.scanner;
    
    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    
    _reader.cameraViewTransform = CGAffineTransformMakeScale(1.5, 1.5);
    
    [self presentViewController:_reader animated:YES completion:nil];
}
    //自己定义的界面
- (void)setOverlayPickerView:(ZBarReaderViewController *)reader
{
        //清除原有控件
    for (UIView *temp in [reader.view subviews]) {
        for (UIButton *button in [temp subviews]){
            if ([button isKindOfClass:[UIButton class]]) {
                [button removeFromSuperview];
            }
        }
        for (UIToolbar *toolbar in [temp subviews]) {
            if ([toolbar isKindOfClass:[UIToolbar class]]) {
                [toolbar setHidden:YES];
                [toolbar removeFromSuperview];
            }
        }
    }
    
    
        //画中间的基准线
    UIView* line = [[UIView alloc] initWithFrame:CGRectMake(40, 220, 240, 1)];
    
    line.backgroundColor = [UIColor redColor];
    
    [reader.view addSubview:line];
    
    
        //最上部view
    UIView* upView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
    
    upView.alpha = 0.9;
    
    upView.backgroundColor = [UIColor blackColor];
    
    [reader.view addSubview:upView];
    
    
        //用于说明的label
    UILabel * labIntroudction= [[UILabel alloc] init];
    
    labIntroudction.backgroundColor = [UIColor clearColor];
    
    labIntroudction.frame=CGRectMake(15, 20, 290, 50);
    
    labIntroudction.numberOfLines=2;
    
    labIntroudction.textColor=[UIColor whiteColor];
    
    labIntroudction.text=@"将二维码或条形码图像置于矩形方框内，离手机摄像头10CM左右，系统会自动识别。";
    labIntroudction.font = [UIFont systemFontOfSize:13.0];
    [upView addSubview:labIntroudction];
    
    
        //左侧的view
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 80, 20, 280)];
    
    leftView.alpha = 0.9;
    
    leftView.backgroundColor = [UIColor blackColor];
    
    [reader.view addSubview:leftView];
    
    
        //右侧的view
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(300, 80, 20, 280)];
    
    rightView.alpha = 0.9;
    
    rightView.backgroundColor = [UIColor blackColor];
    
    [reader.view addSubview:rightView];
    
    
        //底部view
    UIView * downView = [[UIView alloc] initWithFrame:CGRectMake(0, 360, 320, 150)];
    
    downView.alpha = 0.9;
    
    downView.backgroundColor = [UIColor blackColor];
    
    [reader.view addSubview:downView];
    
        //用于取消操作的button
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    cancelButton.alpha = 0.4;
    
    [cancelButton setFrame:CGRectMake(20, 390, 280, 40)];
    
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    
    [cancelButton.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    
    [cancelButton addTarget:self action:@selector(dismissOverlayView:)forControlEvents:UIControlEventTouchUpInside];
    
    [reader.view addSubview:cancelButton];
}

    //取消button方法

- (void)dismissOverlayView:(id)sender{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    id<NSFastEnumeration> results =[info objectForKey: ZBarReaderControllerResults];
    
    ZBarSymbol *symbol = nil;
    
    for(symbol in results)break;
    
    if (symbol.data) {
//---- 此处加入判断?链接:商品
        if([symbol.data rangeOfString:@"http:"].location != NSNotFound ||[symbol.data rangeOfString:@"https:"].location != NSNotFound)
        {
           
           
          WebViewController *webVC = [[WebViewController alloc]init];
            webVC.urls = symbol.data;
            
       
         [reader dismissViewControllerAnimated:YES completion:nil];
            
            [self.navigationController pushViewController:webVC animated:YES];
           
        }
        else{
        
        HYZCarViewController *carViewController = [[HYZCarViewController alloc] init];
        
        carViewController.barCodeString = symbol.data;
        
        [reader dismissViewControllerAnimated:YES completion:nil];
        
        [self.navigationController pushViewController:carViewController animated:YES];
        }
    }
    else{[reader dismissViewControllerAnimated:YES completion:nil];}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
