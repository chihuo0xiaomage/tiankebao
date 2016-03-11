//
//  HYZAboutViewController.m
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-31.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "HYZAboutViewController.h"

@interface HYZAboutViewController ()

@end

@implementation HYZAboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"关于微朋";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    if (IOS7)
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    NSString *nowVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    
    _messageArray = [[NSArray alloc] initWithObjects:@"开发公司: 郑州宝源科技有限公司",@"版本所有: 郑州宝源科技有限公司",@"联系方式: 0371-65748018", [NSString stringWithFormat:@"当前版本: %@",nowVersion], nil];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(15, 80, 290, 176) style:UITableViewStylePlain];
    
    tableView.delegate =self;
        
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
}

#pragma mark -
#pragma mark UITableViweDataSource -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_messageArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [_messageArray objectAtIndex:indexPath.row];
    
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
