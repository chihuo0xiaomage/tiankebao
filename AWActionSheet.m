//
//  AWActionSheet.m
//  AWIconSheet
//
//  Created by Narcissus on 10/26/12.
//  Copyright (c) 2012 Narcissus. All rights reserved.
//

#import "AWActionSheet.h"
#import <QuartzCore/QuartzCore.h>
#define itemPerPage 12

@interface AWActionSheet()<UIScrollViewDelegate>
@property (nonatomic, retain)UIScrollView* scrollView;
@property (nonatomic, retain)UIPageControl* pageControl;
@property (nonatomic, retain)NSMutableArray* items;
@property (nonatomic, assign)id<AWActionSheetDelegate> IconDelegate;
@end
@implementation AWActionSheet
@synthesize scrollView;

@synthesize pageControl;
@synthesize items;
@synthesize IconDelegate;
-(void)dealloc
{
    IconDelegate= nil;
    [scrollView release];
    [pageControl release];
    [items release];
    [super dealloc];
}


-(id)initwithIconSheetDelegate:(id<AWActionSheetDelegate>)delegate ItemCount:(int)cout
{
    //  rowCount 几行  默认三行 如果图标个数小于等于三个为一行，小于等于六个为两行
    int rowCount = 3;
    if (cout <=4)
    {
        rowCount = 1;
    } else if (cout <=8)
    {
        rowCount = 2;
    }

    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        NSString* titleBlank = @"\n\n\n\n\n\n";
        for (int i = 1 ; i<rowCount; i++) {
            titleBlank = [NSString stringWithFormat:@"%@%@",titleBlank,@"\n\n\n\n\n\n"];
        }
        self = [super initWithTitle:titleBlank
                           delegate:nil
                  cancelButtonTitle:@"取消"
             destructiveButtonTitle:nil
                  otherButtonTitles:nil];
    }
    else
    {
        NSString* titleBlank = @"\n\n\n\n\n\n\n\n\n";
        for (int i = 1 ; i<rowCount; i++)
        {
            titleBlank = [NSString stringWithFormat:@"%@%@",titleBlank,@"\n\n\n\n\n\n"];
        }
        self = [super initWithTitle:titleBlank
                           delegate:nil
                  cancelButtonTitle:nil
             destructiveButtonTitle:nil
                  otherButtonTitles:nil];
        UIButton *PlayBtn = [[UIButton alloc] initWithFrame:CGRectMake(21, 120, 280, 46.5)];
        [PlayBtn setBackgroundColor:[UIColor clearColor]];
        [PlayBtn addTarget:self action:@selector(CancelButton) forControlEvents:UIControlEventTouchUpInside];
        [PlayBtn setImage:[UIImage imageNamed:@"按钮.png"] forState:UIControlStateNormal];
        [self addSubview:PlayBtn ];
    }

    if (self) {
        [self setActionSheetStyle:0];
        IconDelegate = delegate;
        self.scrollView = [[[UIScrollView alloc] initWithFrame:CGRectMake(0, 10, 320, 105*rowCount)] autorelease];
        [scrollView setPagingEnabled:YES];
        [scrollView setBackgroundColor:[UIColor clearColor]];
        [scrollView setShowsHorizontalScrollIndicator:NO];
        [scrollView setShowsVerticalScrollIndicator:NO];
        [scrollView setDelegate:self];
        [scrollView setScrollEnabled:YES];
        [scrollView setBounces:NO];
        
        [self addSubview:scrollView];
        
        if (cout > 12) {
            self.pageControl = [[[UIPageControl alloc] initWithFrame:CGRectMake(0, 105*rowCount, 0, 20)] autorelease];
            [pageControl setNumberOfPages:0];
            [pageControl setCurrentPage:0];
            [pageControl addTarget:self action:@selector(changePage:)forControlEvents:UIControlEventValueChanged];
            [self addSubview:pageControl];
        }
        
        
        self.items = [[[NSMutableArray alloc] initWithCapacity:cout] autorelease];
        
    }
    return self;
}

- (void)CancelButton
{
    [self dismissWithClickedButtonIndex:0 animated:YES];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)showInView:(UIView *)view
{
    [super showInView:view];
    [self reloadData];
}

- (void)reloadData
{
    for (AWActionSheetCell* cell in items) {
        [cell removeFromSuperview];
        [items removeObject:cell];
    }
    int count = [IconDelegate numberOfItemsInActionSheet];
    
    if (count <= 0) {
        return;
    }
    
    int rowCount = 3;
    
    if (count <= 4) {
        [self setTitle:@"\n\n\n\n\n\n"];
        [scrollView setFrame:CGRectMake(0, 10, 320, 105)];
        rowCount = 1;
    } else if (count <= 8) {
        [self setTitle:@"\n\n\n\n\n\n\n\n\n\n\n\n"];
        [scrollView setFrame:CGRectMake(0, 10, 320, 210)];
        rowCount = 2;
    }
    [scrollView setContentSize:CGSizeMake(320*(count/itemPerPage+1), scrollView.frame.size.height)];
    [pageControl setNumberOfPages:count/itemPerPage+1];
    [pageControl setCurrentPage:0];
    
    for (int i = 0; i< count; i++) {
        AWActionSheetCell* cell = [IconDelegate cellForActionAtIndex:i];
        int PageNo = i/itemPerPage;
        int index  = i%itemPerPage;
        
        if (itemPerPage == 12) {
            
            int row = index/4;
            int column = index%4;
            
            
            float centerY = (1+row*2)*self.scrollView.frame.size.height/(2*rowCount);
            float centerX = (1+column*1.5)*self.scrollView.frame.size.width/6.5;
            
            [cell setCenter:CGPointMake(centerX+320*PageNo, centerY)];
            [self.scrollView addSubview:cell];
            
            UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionForItem:)];
            [cell addGestureRecognizer:tap];
            [tap release];
        }
        
        [items addObject:cell];
    }
    
}

- (void)actionForItem:(UITapGestureRecognizer*)recongizer
{
    AWActionSheetCell* cell = (AWActionSheetCell*)[recongizer view];
    [IconDelegate DidTapOnItemAtIndex:cell.index];
    [self dismissWithClickedButtonIndex:0 animated:YES];
}

- (IBAction)changePage:(id)sender {
    int page = pageControl.currentPage;
    [scrollView setContentOffset:CGPointMake(320 * page, 0)];
}
#pragma mark -
#pragma scrollview delegate

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    int page = scrollView.contentOffset.x /320;
    pageControl.currentPage = page;
}


@end

#pragma mark - AWActionSheetCell
@interface AWActionSheetCell ()
@end
@implementation AWActionSheetCell
@synthesize iconView;
@synthesize titleLabel;

- (void)dealloc
{
    [iconView release];
    [titleLabel release];
    
    [super dealloc];
}

-(id)init
{
    self = [super initWithFrame:CGRectMake(0, 0, 70, 70)];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.iconView = [[[UIImageView alloc] initWithFrame:CGRectMake(6.5, 0, 57, 57)] autorelease];
        iconView.image = [UIImage imageNamed:@"Default"];
        [iconView setBackgroundColor:[UIColor clearColor]];
        [[iconView layer] setCornerRadius:8.0f];
        [[iconView layer] setMasksToBounds:YES];
        
        [self addSubview:iconView];
        
        self.titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 63, 70, 20)] autorelease];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [titleLabel setFont:[UIFont fontWithName:@"STHeitiSC-Light" size:14]];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
        {
            [titleLabel setTextColor:[UIColor colorWithRed:146/255.0 green:146/255.0 blue:146/255.0 alpha:1.0]];
        }
        else
        {
            titleLabel.textColor = [UIColor whiteColor];
        }
        [self addSubview:titleLabel];
    }
    return self;
}

@end


