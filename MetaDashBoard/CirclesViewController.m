//
//  CirclesViewController.m
//  MetaDashBoard
//
//  Created by  on 9/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CirclesViewController.h"

@interface CirclesViewController ()



@end

@implementation CirclesViewController
@synthesize viewCirclesView = _viewCirclesView;




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
	[self setViewCirclesView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark Detect

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	// get all the touches on the screen
	NSSet *allTouches = [event allTouches];
	
	// compare the number of touches on the screen
	switch ([allTouches count]) 
	{
		case 1:
		{
			// get info of the touch
			
			
			UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
			
			CGPoint point = [touch locationInView:self.viewCirclesView];
			
			NSLog(@"x=%f", point.x);
			
			NSLog(@"y=%f", point.y);
			
			self.viewCirclesView.myPoint = point;
			
	
			
			
			// compare the touches
			
			switch ([touch tapCount]) 
			{
				case 1:
				{
					NSLog(@"Single tap");
					
					break;
				}
				case 2:
				{
					NSLog(@"Double tap");
				}
				default:
					break;
			}
			
			
			break;
		}
			
		default:
			break;
	}
}



@end
