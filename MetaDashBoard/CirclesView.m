//
//  CirclesView.m
//  MetaDashBoard
//
//  Created by  on 9/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CirclesView.h"

@interface CirclesView()



@end

@implementation CirclesView
@synthesize myPoint = _myPoint;

- (void)setMyPoint:(CGPoint)myPoint
{
	_myPoint = myPoint;
	
	[self setNeedsDisplay];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}



- (void) drawRect:(CGRect) rect
{
	NSLog(@"drawRect was called ----------------");
	
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	
	CGContextSetLineWidth(ctx, 2.0);
	
	CGContextSetRGBFillColor(ctx, 0, 0, 1.0, 1.0);
	
	CGContextSetRGBStrokeColor(ctx, 0, 0, 1.0, 1.0);
	
	
	
	CGRect circlePoint = CGRectMake(self.myPoint.x, self.myPoint.y, 50.0, 50.0);
	
	CGContextFillEllipseInRect(ctx, circlePoint);
	
	
}

@end
