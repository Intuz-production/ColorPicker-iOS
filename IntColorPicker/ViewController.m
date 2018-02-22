/*
 
 The MIT License (MIT)
 
 Copyright (c) 2018 INTUZ
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
 */

#import "ViewController.h"
#import "ColorPickerController.h"

@interface ViewController ()

@property (nonatomic, retain) UIColor *selectedColor;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Color Picker";
    self.selectedColor = [UIColor redColor];
    self.view.backgroundColor = self.selectedColor;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Open Color Picker View Controller by using Presenting ViewController.
- (IBAction)btnPresentColorPicker:(id)sender {
    [ColorPickerController presentColorPickerController:self defaultColor:self.selectedColor colorTitle:@"Background Color" completion:^(BOOL success, UIColor *selectedColours, CGFloat alpha) {
        if (success) {
            self.selectedColor = [selectedColours colorWithAlphaComponent:alpha];
            self.view.backgroundColor = self.selectedColor;
        }
    }];
}

// Open Color Picker View Controller by Pushing in NavigationController.
- (IBAction)btnPushColorPicker:(id)sender {
    [ColorPickerController pushColorPickerController:self defaultColor:self.selectedColor colorTitle:@"Background Color" completion:^(BOOL success, UIColor *selectedColours, CGFloat alpha) {
        if (success) {
            self.selectedColor = [selectedColours colorWithAlphaComponent:alpha];
            self.view.backgroundColor = self.selectedColor;
        }
    }];

}

@end
