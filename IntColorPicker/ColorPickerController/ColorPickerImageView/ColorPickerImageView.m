/*
 
 The MIT License (MIT)
 
 Copyright (c) 2018 INTUZ
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
 */

#import "ColorPickerImageView.h"
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/CoreAnimation.h>

@implementation ColorPickerImageView

@synthesize lastColor;
@synthesize pickedColorDelegate;

- (void)awakeFromNib {
    [super awakeFromNib];
    [self addImageIndicator];
}

- (void)addImageIndicator {
    if(!imgViewIndicator) {
        imgViewIndicator = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        [imgViewIndicator setImage:[UIImage imageNamed:@"color_picker.png"]];
        [self addSubview:imgViewIndicator];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    [self handleTouches:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    [self handleTouches:touches withEvent:event];
}

- (void)handleTouches:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    if(touches.count > 1)
        return;
    if (self.hidden==YES) {
        //color wheel is hidden, so don't handle  this as a color wheel event.
        [[self nextResponder] touchesEnded:touches withEvent:event];
        return;
    }
    
    UITouch* touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.superview]; //where image was tapped
    
    CGPoint center = self.center;
    CGFloat distance = DistanceBetweenTwoPoints(point, center);
    CGFloat radius = self.bounds.size.width * 0.5;
    if(distance <= radius- 5) {
        [self getPixelColorAtLocation:[touch locationInView:self]];
    }
    else {
        
    }
}

CGFloat DistanceBetweenTwoPoints(CGPoint point1,CGPoint point2)
{
    
    CGFloat dx = point2.x - point1.x;
    CGFloat dy = point2.y - point1.y;
    return sqrtf(dx*dx + dy*dy);

};

CGContextRef cgctx;
unsigned char* data;

- (UIColor*)getPixelColorAtLocation:(CGPoint)point {
    [imgViewIndicator setCenter:point];
    
	UIColor* color = nil;
	CGImageRef inImage = self.image.CGImage;
	// Create off screen bitmap context to draw the image into. Format ARGB is 4 bytes for each pixel: Alpa, Red, Green, Blue
    if (cgctx == NULL) {
        cgctx = [self createARGBBitmapContextFromImage:inImage];
    }
	if (cgctx == NULL) { return nil; /* error */ }
	
    CGFloat scale = [UIScreen mainScreen].scale;
    
    size_t w = CGImageGetWidth(inImage) / scale;
	size_t h = CGImageGetHeight(inImage) / scale;
	CGRect rect = {{0,0},{w,h}}; 
	
	// Draw the image to the bitmap context. Once we draw, the memory 
	// allocated for the context for rendering will then contain the 
	// raw image data in the specified color space.
	CGContextDrawImage(cgctx, rect, inImage); 
	
	// Now we can get a pointer to the image data associated with the bitmap
	// context.
    if(data == NULL) {
        data = CGBitmapContextGetData (cgctx);
    }
	if (data != NULL) {
		//offset locates the pixel in the data from x,y. 
		//4 for 4 bytes of data per pixel, w is width of one row of data.
		int offset = 4*((w*round(point.y))+round(point.x));
		int alpha =  data[offset]; 
		int red = data[offset+1]; 
		int green = data[offset+2]; 
		int blue = data[offset+3]; 
//		NSLog(@"offset: %i colors: RGB A %i %i %i  %i",offset,red,green,blue,alpha);
		color = [UIColor colorWithRed:(red/255.0f) green:(green/255.0f) blue:(blue/255.0f) alpha:(alpha/255.0f)];
	}
	
	// When finished, release the context
//	CGContextRelease(cgctx); 
	// Free image data memory for the context
//	if (data) { free(data); }
    self.lastColor = color;
    [pickedColorDelegate pickedColor:(UIColor*)self.lastColor];
	return color;
}

- (void)dealloc {
    CGContextRelease(cgctx);
    if (data) { free(data); }
}

- (CGContextRef)createARGBBitmapContextFromImage:(CGImageRef) inImage {
	
	CGContextRef    context = NULL;
	CGColorSpaceRef colorSpace;
	void *          bitmapData;
	int             bitmapByteCount;
	int             bitmapBytesPerRow;
	
	// Get image width, height. We'll use the entire image.
    
    CGFloat scale = [UIScreen mainScreen].scale;

	size_t pixelsWide = CGImageGetWidth(inImage) / scale;
	size_t pixelsHigh = CGImageGetHeight(inImage) / scale;
	
	// Declare the number of bytes per row. Each pixel in the bitmap in this
	// example is represented by 4 bytes; 8 bits each of red, green, blue, and
	// alpha.
	bitmapBytesPerRow   = (int)(pixelsWide * 4);
	bitmapByteCount     = (int)(bitmapBytesPerRow * pixelsHigh);
	
	// Use the generic RGB color space.
	colorSpace = CGColorSpaceCreateDeviceRGB();

	if (colorSpace == NULL)
	{
		fprintf(stderr, "Error allocating color space\n");
		return NULL;
	}
	
	// Allocate memory for image data. This is the destination in memory
	// where any drawing to the bitmap context will be rendered.
	bitmapData = malloc( bitmapByteCount );
	if (bitmapData == NULL) 
	{
		fprintf (stderr, "Memory not allocated!");
		CGColorSpaceRelease( colorSpace );
		return NULL;
	}
	
	// Create the bitmap context. We want pre-multiplied ARGB, 8-bits 
	// per component. Regardless of what the source image format is 
	// (CMYK, Grayscale, and so on) it will be converted over to the format
	// specified here by CGBitmapContextCreate.
	context = CGBitmapContextCreate (bitmapData,
									 pixelsWide,
									 pixelsHigh,
									 8,      // bits per component
									 bitmapBytesPerRow,
									 colorSpace,
									 (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
	if (context == NULL)
	{
		free (bitmapData);
		fprintf (stderr, "Context not created!");
	}
	
	// Make sure and release colorspace before returning
	CGColorSpaceRelease( colorSpace );
	
	return context;
}



@end
