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

#import <Foundation/Foundation.h>

/**
 * No selected index
 */
#define RADIO_GROUP_NO_SELECTED_OPTION              -1

@class MNMRadioGroupValue;

@protocol MNMRadioGroupDelegate

/**
 * Tells delegate that a value has been selected
 *
 * @param value The MNMRadioGroupValue object selected
 */
- (void)MNMRadioGroupValueSelected:(MNMRadioGroupValue *)value;

@end

/**
 * View that imitates an usual/web page radio group.
 * It has a series of buttons and manages the logic of selection and deselection.
 * Calls delegate for each selected value with the selected MNMRadioGroupValue
 *
 * @author <a href="mailto:info@movilok.com">Movilok Interactividad Movil S.L.</a>
 */
@interface MNMRadioGroup : UIView {
@private
    /**
     * Array of buttons
     */
    NSMutableArray *buttons_;
    
    /**
     * Array of MNMRadioGroupValue
     */
    NSArray *values_;
    
    /**
     * Selected index
     */
    NSInteger selectedIndex_;
    
    /**
     * Delegate
     */
    id<MNMRadioGroupDelegate> delegate_;
}

/**
 * Provides readwrite access to the selectedIndex_
 */
@property(nonatomic, readwrite, assign) NSInteger selectedIndex;

/**
 * Provides readwrite access to the delegate_
 */
@property(nonatomic, readwrite, assign) id<MNMRadioGroupDelegate> delegate;

/**
 * Initializes and returns a newly allocated view object with the specified frame rectangle.
 * It receives an array of MNMRadioGroupValue to conform the group
 *
 * @param aRect: The frame rectangle for the view, measured in points.
 * @param values An array of MNMRadioGroupValue objects
 * @return An initialized view object or nil if the object couldn't be created.
 */
- (id)initWithFrame:(CGRect)frame andValues:(NSArray *)values;

/**
 * Returns the final height of this component depending on the given array values 
 * and the width that it will get
 *
 * @param values Array of strings
 * @param width Width of the control
 * @return The expected height
 */
+ (CGFloat)heightForValues:(NSArray *)values andWidth:(CGFloat)width;

/**
 * Returns the height of the given value and width
 *
 * @param value A string
 * @param width Width of the control
 * @return The expected height
 */
+ (CGFloat)heightForValue:(NSString *)value andWidth:(CGFloat)width;

@end
