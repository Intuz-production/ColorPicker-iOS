/*
 
 The MIT License (MIT)
 
 Copyright (c) 2018 INTUZ
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
 */

#import "ColorSlider.h"

@interface ColorSlider()
@property (nonatomic, retain) UIImageView *sliderKnobView;
@end

@implementation ColorSlider
@synthesize sliderKnobView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        // Initialization code
        // Initialization code
        horizontal = frame.size.width > frame.size.height;
		
		UIImageView *knob = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"color_slider.png"]];
		[self addSubview:knob];		
		self.sliderKnobView = knob;
		
		self.backgroundColor = [UIColor clearColor];
		self.userInteractionEnabled = YES;
		self.value = 0.0;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (CGFloat) value
{
	return value;
}

- (void) setValue:(CGFloat)val
{	
	value = MAX(MIN(val, 1.0), 0.0);
	
	CGFloat x = horizontal ? 
    roundf((1 - value) * (self.frame.size.width - 40) - self.sliderKnobView.bounds.size.width * 0.5) + self.sliderKnobView.bounds.size.width * 0.5:
    roundf((self.bounds.size.width - self.sliderKnobView.bounds.size.width) * 0.5) + self.sliderKnobView.bounds.size.width * 0.5;
    
	CGFloat y = horizontal ?
    roundf((self.bounds.size.height - self.sliderKnobView.bounds.size.height) * 0.5) + self.sliderKnobView.bounds.size.height * 0.5:
    roundf((1 - value) * (self.frame.size.height - 40) - self.sliderKnobView.bounds.size.height * 0.5) + self.sliderKnobView.bounds.size.height * 0.5;
	
    if(horizontal)
        x += 20;
    else
        y += 20;
    
	self.sliderKnobView.center = CGPointMake(x, y);
}

- (void) mapPointToValue:(CGPoint)point
{
	CGFloat val = horizontal ? 1 - ((point.x - 20) / (self.frame.size.width - 40)) : 1 - ((point.y - 20) / (self.frame.size.height - 40)); 
	self.value = val;
	
	[self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
	[self mapPointToValue:[touch locationInView:self]];
	return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
	[self mapPointToValue:[touch locationInView:self]];
	return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
	[self continueTrackingWithTouch:touch withEvent:event];
}

- (void)didAddSubview:(UIView *)subview
{
    [self bringSubviewToFront:sliderKnobView];
}
@end
