<h1>Introduction</h1>
INTUZ is presenting an interesting Color Picker to integrate inside your iOS based application. 
Please follow the below steps to integrate this control in your project.

<br/><br/>
<h1>Features</h1>

- Easy & fast ways to pick colors.
- You can able to change color alpha component.
- Fully customizable layout.

<br/><br/>

![Alt text](Screenshots/ColorPicker.gif?raw=true "Title")


<br/><br/>
<h1>Getting Started</h1>

> Steps to Integrate

1) Drag & drop "ColorPickerController" folder into from project and make sure you selected "Copy items if needed" option.

1) Add `#import "ColorPickerController.h"` at the required place in your code.

2) Add below code where you want to open color picker controller:

* To Present Color Picker View:
```
[ColorPickerController presentColorPickerController:self defaultColor:self.selectedColor colorTitle:@"Background Color" completion:^(BOOL success, UIColor *selectedColours, CGFloat alpha) {
    if (success) {
        // Do your stuff here..
    }
}];
```

* To Push Color Picker View:
```
[ColorPickerController pushColorPickerController:self defaultColor:self.selectedColor colorTitle:@"Background Color" completion:^(BOOL success, UIColor *selectedColours, CGFloat alpha) {
    if (success) {
        // Do your stuff here..
    }
}];
```

<br/><br/>
<h1>Bugs and Feedback</h1>
For bugs, questions and discussions please use the Github Issues.

<br/><br/>
<h1>License</h1>
The MIT License (MIT)
<br/><br/>
Copyright (c) 2018 INTUZ
<br/><br/>
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: 
<br/><br/>
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

<br/><br/>
<h1></h1>
<a href="https://www.intuz.com/" target="_blank"><img src="Screenshots/logo.jpg"></a>
