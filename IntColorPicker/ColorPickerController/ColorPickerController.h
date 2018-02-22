/*
 
 The MIT License (MIT)
 
 Copyright (c) 2018 INTUZ
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
 */

#import <UIKit/UIKit.h>

#import "ColorPickerImageView.h"
#import "ColorPickerAlphaSlider.h"


typedef void(^CompleteColorPicker)(BOOL success, UIColor *selectedColours, CGFloat alpha);

@interface ColorPickerController : UIViewController <PickedColorDelegate>
{
    IBOutlet UIView *viewContainer;
    IBOutlet UILabel *lblTitle;
    
    IBOutlet ColorPickerImageView *imgViewColorPicker;
    IBOutlet UIView *viewColorSliderContainer;
    IBOutlet UIView *viewSelectedColor;
    ColorPickerAlphaSlider *alphaSlider;
}

@property (copy, nonatomic) CompleteColorPicker completionBlock;
@property (copy, nonatomic) CompleteColorPicker didChangeBlock;

// To Present Color Picker View Controller
+ (ColorPickerController *) presentColorPickerController:(UIViewController *)controller defaultColor:(UIColor *)color colorTitle:(NSString *)title completion:(CompleteColorPicker)complete;

// To Push Color Picker View Controller
+ (ColorPickerController *) pushColorPickerController:(UIViewController *)controller defaultColor:(UIColor *)color colorTitle:(NSString *)title completion:(CompleteColorPicker)complete;


@end
