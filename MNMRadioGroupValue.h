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

/**
 * Models a value to set in the radio group. Stores the value itself and a text to show
 * in the control
 */
@interface MNMRadioGroupValue : NSObject {
@private
    /**
     * Value
     */
    NSObject *value_;
    
    /**
     * Text
     */
    NSString *text_;
}

/**
 * Provides readonly access to the value
 */
@property (nonatomic, readonly) NSObject *value;

/**
 * Provides readonly access to the text
 */
@property (nonatomic, readonly) NSString *text;

/**
 * Returns an initialized instance with the given value and text
 *
 * @param value The value of this GroupValue
 * @param text The text of this GroupValue
 * @return The instance initialized
 */
- (id)initWithValue:(NSObject *)value andText:(NSString *)text;

@end
