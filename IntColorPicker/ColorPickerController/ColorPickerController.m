/*
 
 The MIT License (MIT)
 
 Copyright (c) 2018 INTUZ
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
 */

#import "ColorPickerController.h"

@interface ColorPickerController ()

@property (nonatomic, retain) UIColor *selectedColor;
@property (nonatomic, assign) CGFloat selectedAlpha;

@property (nonatomic, retain) NSString *strTitle;
@property (nonatomic, retain) UIColor *previousColor;

@property (nonatomic, assign) BOOL isPushColorPicker;

@end

@implementation ColorPickerController

// To Present Color Picker View Controller
+ (ColorPickerController *) presentColorPickerController:(UIViewController *)controller defaultColor:(UIColor *)color colorTitle:(NSString *)title completion:(CompleteColorPicker)complete {
    ColorPickerController *colorPickerController = [[ColorPickerController alloc] initWithNibName:@"ColorPickerController" bundle:nil];
    colorPickerController.strTitle = title;
    colorPickerController.previousColor = color;
    colorPickerController.completionBlock = complete;
    colorPickerController.isPushColorPicker = false;
    colorPickerController.selectedAlpha = 1;
    colorPickerController.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.3];
    [controller presentViewController:colorPickerController animated:true completion:nil];
    
    return colorPickerController;
}

// To Push Color Picker View Controller
+ (ColorPickerController *) pushColorPickerController:(UIViewController *)controller defaultColor:(UIColor *)color colorTitle:(NSString *)title completion:(CompleteColorPicker)complete {
    ColorPickerController *colorPickerController = [[ColorPickerController alloc] initWithNibName:@"ColorPickerController" bundle:nil];
    colorPickerController.strTitle = title;
    colorPickerController.previousColor = color;
    colorPickerController.completionBlock = complete;
    colorPickerController.isPushColorPicker = true;
    colorPickerController.selectedAlpha = 1;
    colorPickerController.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.3];
    [controller.navigationController pushViewController:colorPickerController animated:true];
    
    return colorPickerController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    lblTitle.text = _strTitle;
    
    alphaSlider = [[ColorPickerAlphaSlider alloc] initWithFrame:viewColorSliderContainer.bounds];
    [alphaSlider addTarget:self action:@selector(alphaSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [viewColorSliderContainer addSubview:alphaSlider];
    [alphaSlider setValue:1];
    
    UIColor *color = [UIColor colorWithRed:(154)/255.0f green:(154)/255.0f blue:(154)/255.0f alpha:1];
    [self createBorder:imgViewColorPicker size:3.0 color:color radius:imgViewColorPicker.frame.size.width/2];
    [imgViewColorPicker setPickedColorDelegate:self];
    [imgViewColorPicker getPixelColorAtLocation:CGPointMake(imgViewColorPicker.frame.size.width/2, imgViewColorPicker.frame.size.height/2)];
    [self createBorder:viewSelectedColor size:1.0 color:color radius:8.0];
    
    // To set current color.
    if (_previousColor) {
        [self pickedColor:_previousColor];
    }
}

- (void)createBorder:(UIView *)view size:(CGFloat) width color:(UIColor *)color radius:(CGFloat) radius
{
    [view.layer setBorderWidth:width];
    [view.layer setBorderColor:color.CGColor];
    [view.layer setCornerRadius:radius];
    [view setClipsToBounds:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Methods

- (IBAction)btnCancelTapped:(id)sender {
    _selectedColor = _previousColor;
    
    if (_completionBlock) {
        _completionBlock(false, _selectedColor, _selectedAlpha);
    }
    
    [self dismissColorPicker];
}

- (IBAction)btnUploadTapped:(id)sender {
    if (_completionBlock) {
        _completionBlock(true, _selectedColor, _selectedAlpha);
    }
    
    [self dismissColorPicker];
}

// Perform close video trimer view action.
- (void) dismissColorPicker {
    if (self.isPushColorPicker == true) {
        [self.navigationController popViewControllerAnimated:true];
    }
    else {
        [self dismissViewControllerAnimated:true completion:nil];
    }
}

#pragma mark - ColorPickerImageView Delegate

- (void)pickedColor:(UIColor*)color {
    _selectedColor = color;
    [viewSelectedColor setBackgroundColor:color];
    [alphaSlider setKeyColor:color];
    [alphaSlider setValue:1];
    
    if (_didChangeBlock) {
        _didChangeBlock(true, color, _selectedAlpha);
    }
}

- (void)alphaSliderValueChanged:(ColorPickerAlphaSlider *)sender {
    UIColor *color = [viewSelectedColor.backgroundColor colorWithAlphaComponent:sender.value];
    _selectedColor = color;
    _selectedAlpha=sender.value;

    if (_didChangeBlock) {
        _didChangeBlock(true, color, _selectedAlpha);
    }
    [viewSelectedColor setBackgroundColor:color];
}


@end
