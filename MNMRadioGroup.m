/*
 * Copyright (c) 2012 Mario Negro Martín
 * 
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 * 
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. 
 */

#import "MNMRadioGroup.h"
#import "MNMRadioGroupValue.h"
#import <QuartzCore/QuartzCore.h>

/**
 * Font size of each button
 */
#define FONT_SIZE                                                   14.0f

/**
 * Height of button
 */
#define BUTTON_HEIGHT                                               30.0f

/**
 * Gap between buttons
 */
#define GAP_BETWEEN_BUTTONS                                         5.0f

/**
 * Defines the top margin of the buttons
 */
#define TOP_MARGIN                                                  10.0f

/**
 * Defines the left margin of the buttons
 */
#define LEFT_MARGIN                                                 10.0f

/**
 * Approx size of radio image to calculate control
 * and button heights
 */
#define APPROX_SIZE_OF_RADIO_IMAGE                                  22.0f

/**
 * Defines images for selected and unselected states
 */
#define SELECTED_IMAGE                                              @"MNMRadioGroupSelected.png"
#define UNSELECTED_IMAGE                                            @"MNMRadioGroupUnselected.png"

@interface MNMRadioGroup()

/**
 * A value has been pressed
 *
 * @private
 */
- (void)valuePressed:(UIButton *)button;

/**
 * Creates the buttons of each radio option
 *
 * @private
 */
- (void)createButtons;

@end

@implementation MNMRadioGroup

@synthesize selectedIndex = selectedIndex_;
@synthesize delegate = delegate_;

#pragma mark -
#pragma mark Static methods

/*
 * Returns the height of the given value and width
 */
+ (CGFloat)heightForValue:(NSString *)value andWidth:(CGFloat)width {
    
    width = width - (LEFT_MARGIN * 2) - APPROX_SIZE_OF_RADIO_IMAGE - 10.0f; // This value is the gap between left edge of button and the image plus image and right edge of text
    
    CGSize size = [value sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:CGSizeMake(width, 999.0f) lineBreakMode:NSLineBreakByCharWrapping];
    
    CGFloat result = (size.height < BUTTON_HEIGHT ? BUTTON_HEIGHT : size.height + 6.0f);
    
    return result;
}

/*
 * Returns the final height of this component depending on the given array values 
 * and the width that it will get
 */
+ (CGFloat)heightForValues:(NSArray *)values andWidth:(CGFloat)width {
    
    CGFloat result = TOP_MARGIN;
    
    for (MNMRadioGroupValue *value in values) {
                
        result += [MNMRadioGroup heightForValue:value.text andWidth:width] + GAP_BETWEEN_BUTTONS;
    }
    
    result += (TOP_MARGIN - GAP_BETWEEN_BUTTONS);
    
    return result;
}

#pragma mark -
#pragma mark Memory management

/**
 * Deallocates the memory occupied by the receiver.
 */
- (void)dealloc {
    [buttons_ release];
    buttons_ = nil;
    
    [values_ release];
    values_ = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark Instance initialization

/*
 * Initializes and returns a newly allocated view object with the specified width and values
 */
- (id)initWithFrame:(CGRect)frame andValues:(NSArray *)values {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithWhite:0.8f alpha:1.0f];
        self.layer.cornerRadius = 10;
        self.layer.borderWidth = 1.0f;
        self.layer.borderColor = [UIColor colorWithWhite:0.9f alpha:1.0f].CGColor;
                
        values_ = [[NSArray alloc] initWithArray:values];
        
        buttons_ = [[NSMutableArray alloc] initWithCapacity:values_.count];
        
        selectedIndex_ = RADIO_GROUP_NO_SELECTED_OPTION;
        
        [self createButtons];
    }
    
    return self;
}

#pragma mark -
#pragma mark Radio management

/*
 * Creates the buttons of each radio option
 */
- (void)createButtons {
       
    CGFloat radioWidth = self.frame.size.width - LEFT_MARGIN * 2;
    CGFloat y = TOP_MARGIN;
    
    for (int i = 0; i < values_.count; i++) {
        
        MNMRadioGroupValue *value = [values_ objectAtIndex:i];
        
        NSString *string = value.text;
        
        CGFloat height = [MNMRadioGroup heightForValue:string andWidth:self.frame.size.width];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.frame = CGRectMake(LEFT_MARGIN, y, radioWidth, height);
        button.titleLabel.numberOfLines = 0;
        button.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
        button.titleLabel.font = [UIFont systemFontOfSize:FONT_SIZE];
        
        [button setImage:[UIImage imageNamed:UNSELECTED_IMAGE] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:SELECTED_IMAGE] forState:UIControlStateSelected];
        [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [button setTitle:string forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0.0f, 10.0f, 0.0f, 0.0f)];
        [button addTarget:self action:@selector(valuePressed:) forControlEvents:UIControlEventTouchUpInside];
        
        y += height + GAP_BETWEEN_BUTTONS;
        
        [self addSubview:button];
        
        [buttons_ addObject:button];
    }
}

/*
 * A value has been pressed
 */
- (void)valuePressed:(UIButton *)button {
      
    NSInteger index = [buttons_ indexOfObject:button];
    
    if (selectedIndex_ != index && index >= 0 && index < buttons_.count) {
        
        if (selectedIndex_ != RADIO_GROUP_NO_SELECTED_OPTION) {
            
            UIButton *previousButton = [buttons_ objectAtIndex:selectedIndex_];
            previousButton.selected = NO;
        }
        
        selectedIndex_ = index;
        
        button.selected = YES;
        
        [delegate_ MNMRadioGroupValueSelected:[values_ objectAtIndex:index]];
    }    
}

#pragma mark -
#pragma mark Properties

/**
 * Sets the selected index
 *
 * @param selectedIndex Index to ser
 */
- (void)setSelectedIndex:(NSInteger)selectedIndex {
    
    selectedIndex_ = selectedIndex;
    
    for (UIButton *button in buttons_) {
        
        NSInteger index = [buttons_ indexOfObject:button];
        
        if (index == selectedIndex_) {
            
            button.selected = YES;
            
        } else {
            
            button.selected = NO;
        }
    }
}

@end