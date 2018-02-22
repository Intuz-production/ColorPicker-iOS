/*
 
 The MIT License (MIT)
 
 Copyright (c) 2018 INTUZ
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
 */

#import "ColorPickerAlphaSlider.h"


@implementation ColorPickerAlphaSlider

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        // Initialization code
        gradientLayer = [[CAGradientLayer alloc] init];
        gradientLayer.bounds = CGRectMake(horizontal ? 18 : 6,
                                          horizontal ? 6 : 18,
                                          frame.size.width - (horizontal ? 36 : 12),
                                          frame.size.height - (horizontal ? 12 : 36));
        
        gradientLayer.position = CGPointMake(frame.size.width * 0.5, frame.size.height * 0.5);
		gradientLayer.cornerRadius = 4.0;
		gradientLayer.borderWidth = 1.0;
		gradientLayer.borderColor = [[UIColor lightGrayColor] CGColor];
        
		if ([self respondsToSelector:@selector(contentScaleFactor)])
			self.contentScaleFactor = [[UIScreen mainScreen] scale];
        
        if (horizontal) 
        {
            gradientLayer.startPoint = CGPointMake(0.0, 0.5);
            gradientLayer.endPoint = CGPointMake(1.0, 0.5);
        }
        [self.layer insertSublayer:gradientLayer atIndex:0];
		[self setKeyColor:[UIColor whiteColor]];
    }
    return self;
}

- (void) setKeyColor:(UIColor *)c
{
	[CATransaction begin];
	[CATransaction setValue:(id)kCFBooleanTrue
					 forKey:kCATransactionDisableActions];
	gradientLayer.colors =  [NSArray arrayWithObjects:	 
							 (id)c.CGColor,
							 (id)[UIColor whiteColor].CGColor,
							 nil];
	[CATransaction commit];
}

- (void) setFrame:(CGRect)frame
{
    [super setFrame:frame];
    gradientLayer.bounds = CGRectMake(horizontal ? 18 : 6,
                                      horizontal ? 6 : 18,
                                      frame.size.width - (horizontal ? 36 : 12),
                                      frame.size.height - (horizontal ? 12 : 36));
    
    gradientLayer.position = CGPointMake(frame.size.width * 0.5, frame.size.height * 0.5);
    self.value = self.value;
}
@end
