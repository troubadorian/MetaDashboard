//
//  SecondTabViewController.m
//  MetaDashBoard
//
//  Created by  on 8/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SecondTabViewController.h"
#import "AskerViewController.h"
#import "MobileCoreServices/MobileCoreServices.h"

@interface SecondTabViewController ()<AskerViewControllerDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet UIView *secondTabView;
@property (nonatomic, weak) NSTimer *drainTimer;
@property (nonatomic, weak) UIActionSheet *actionSheet;

@end

@implementation SecondTabViewController

@synthesize secondTabView = _secondTabView;
@synthesize drainTimer = _drainTimer;
@synthesize actionSheet = _actionSheet;

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier hasPrefix:@"CreateLabel"])
	{
		AskerViewController *asker = (AskerViewController *) segue.destinationViewController;
		
		asker.question  = @"What do you want your label to say?";
		
		asker.answer = @"Label Text";
		
		asker.delegate = self;
	}
}

- (void) setRandomLocationForView:(UIView *) view
{
	[view sizeToFit];
	
	NSLog(@"view.frame.size.width/2 %f", view.frame.size.width/2);
	
	CGRect sinkBounds = CGRectInset(self.secondTabView.bounds, view.frame.size.width/2, view.frame.size.height/2);
	
	NSLog(@"sinkBounds.size.width %f", sinkBounds.size.width);
	
	CGFloat x = arc4random() % (int)sinkBounds.size.width + view.frame.size.width/2;
	
	CGFloat y = arc4random() % (int)sinkBounds.size.height + view.frame.size.height/2;
	
	NSLog(@"The x coordinate is %f", x);
	
	NSLog(@"The y coordinate is %f", y);
	
	view.center = CGPointMake(x, y);
	
}

- (void) setRandomLocationForImageView:(UIView *) view
{
	/* [view sizeToFit]; */
	
	NSLog(@"view.frame.size.width/2 %f", view.frame.size.width/2);
	
	CGRect sinkBounds = CGRectInset(self.secondTabView.bounds, view.frame.size.width/2, view.frame.size.height/2);
	
	NSLog(@"sinkBounds.size.width %f", sinkBounds.size.width);
	
	CGFloat x = arc4random() % (int)sinkBounds.size.width + view.frame.size.width/2;
	
	CGFloat y = arc4random() % (int)sinkBounds.size.height + view.frame.size.height/2;
	
	NSLog(@"The x coordinate is %f", x);
	
	NSLog(@"The y coordinate is %f", y);
	
	view.center = CGPointMake(x, y);
	
}







- (void) askerViewController:(AskerViewController *)sender didAskQuestion:(NSString *)question andGotAnswer:(NSString *)answer
{
	[self addLabel:answer];
	[self dismissModalViewControllerAnimated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) tapGestureCapturedOld:(UITapGestureRecognizer *) gesture
{
	NSLog(@"Tap was located");
	CGPoint tapLocation = [gesture locationInView:self.secondTabView];
	
	for (UIView *view in self.secondTabView.subviews)
	{
		if (CGRectContainsPoint(view.frame, tapLocation))
		{
			[UIView animateWithDuration:4.0 animations:^{
				[self setRandomLocationForView:view];
			}];
		}
	}
}

- (void) tapGestureCaptured:(UITapGestureRecognizer *) gesture
{
	NSLog(@"Tap was located");
	CGPoint tapLocation = [gesture locationInView:self.secondTabView];
	
	for (UIView *view in self.secondTabView.subviews)
	{
		if (CGRectContainsPoint(view.frame, tapLocation))
		{
			[UIView animateWithDuration:4.0 delay:0  options:UIViewAnimationOptionBeginFromCurrentState animations:^{
				[self setRandomLocationForView:view];
				view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.99, 0.99);
			} completion:^(BOOL finished) {
				view.transform = CGAffineTransformIdentity;
			}];
		}
	}
}



#define DRAIN_DURATION 3.0

- (void) drain
{
	for (UIView *view in self.secondTabView.subviews)
	{
		CGAffineTransform transform = view.transform;
		
		if (CGAffineTransformIsIdentity(transform))
		{
			UIViewAnimationOptions options = UIViewAnimationCurveLinear;
			
			[UIView animateWithDuration:DRAIN_DURATION/3 delay:0 options:options animations:^{
				view.transform = CGAffineTransformRotate(CGAffineTransformScale(transform, 0.7, 0.7), 2*M_PI/3);
				
			} completion:^(BOOL finished) {
				if (finished)
				{
					[UIView animateWithDuration:DRAIN_DURATION/3 delay:0 options:options animations:^{
						view.transform = CGAffineTransformRotate(CGAffineTransformScale(transform, 0.4, 0.4), -2*M_PI/3);
																 
					} completion:^(BOOL finished) {
						if (finished)
						{
							[UIView animateWithDuration:DRAIN_DURATION/3 delay:0 options:options animations:^{
								view.transform = CGAffineTransformScale(transform, 0.1, 0.1);
							} completion:^(BOOL finished) {
								if (finished)
								{
									[view removeFromSuperview];
								}
							}];
						}
					}];
				}
			}];
		}
	}
}

- (void) drain:(NSTimer *)timer
{
	[self drain];
}


- (void) startDraining
{
	
	self.drainTimer = [NSTimer scheduledTimerWithTimeInterval:DRAIN_DURATION target:self selector:@selector(drain:) userInfo:nil repeats:YES];
	
}


- (void) stopDraining
{
	[self.drainTimer invalidate];
}

- (void) addLabel:(NSString *) text
{
	UILabel *label = [[UILabel alloc] init];
	static NSDictionary *colors = nil;
	
	if (!colors) colors = [NSDictionary dictionaryWithObjectsAndKeys:
						   [UIColor blueColor], @"Blue",
						   [UIColor greenColor], @"Green",
						   [UIColor orangeColor], @"Orange",
						   [UIColor redColor], @"Red",
						   [UIColor purpleColor], @"Purple",
						   [UIColor brownColor], @"Brown",
						   nil];
	
	if (![text length])
	{
		NSString *color = [[colors allKeys] objectAtIndex:arc4random()%[colors count]];
		text = color;
		label.textColor = [colors objectForKey:color];
	}
	

	label.text = text;
	label.font = [UIFont systemFontOfSize:48.0];
	label.backgroundColor = [UIColor clearColor];
	[self setRandomLocationForView:label];
	[self.secondTabView addSubview:label];
	
}

#define FAUCET_INTERVAL 2.0
- (void) drip
{
	if (self.secondTabView.window)
	{
		[self addLabel:nil];
		[self performSelector:@selector(drip) withObject:nil afterDelay:FAUCET_INTERVAL];
	}
}

#define STOP_DRAIN @"Stopper Drain"
#define UNSTOP_DRAIN @"Unstopper Drain"

- (IBAction)buttonControlSink:(UIBarButtonItem *)sender 
{
	if (self.actionSheet)
	{
		// do nothing
	}
	else 
	{
		NSString *drainButton = self.drainTimer ? STOP_DRAIN : UNSTOP_DRAIN;
		
		UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Sink Controls" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Empty Sink" otherButtonTitles:drainButton, nil];
		
		[actionSheet showFromBarButtonItem:sender animated:YES];
		
		self.actionSheet = actionSheet;
	}

	
	
}

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	NSString *choice = [actionSheet buttonTitleAtIndex:buttonIndex];
	if (buttonIndex == [actionSheet destructiveButtonIndex])
	{
		[self.secondTabView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
		
	}
	else if ([choice isEqualToString:STOP_DRAIN])
	{
		[self stopDraining];
	}
	else if ([choice isEqualToString:UNSTOP_DRAIN])
	{
		[self startDraining];
	}
}




#pragma mark ViewLifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureCaptured:)];
	
	[self.secondTabView addGestureRecognizer:tap];
	
	
	
}

- (void) viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	[self startDraining];
	[self drip];
	
}

- (void)viewDidUnload
{
	[self setSecondTabView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
	[self stopDraining];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}



#pragma mark ImagePicker


- (IBAction)addImage:(UIBarButtonItem *)sender 
{
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
	{
		NSArray * mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
		
		if ([mediaTypes containsObject:(NSString *)kUTTypeImage])
		{
			UIImagePickerController *picker = [[UIImagePickerController alloc] init];
			picker.delegate = self;
			picker.sourceType = UIImagePickerControllerSourceTypeCamera;
			picker.mediaTypes = [NSArray arrayWithObject:(NSString *)kUTTypeImage];
			picker.allowsEditing = YES;
			[self presentModalViewController:picker animated:YES];
		}
	}
}


#pragma mark ImagePickerDelegate methods

#define MAX_IMAGE_WIDTH 200
- (void) dismissImagePicker
{
	[self dismissModalViewControllerAnimated:YES];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
	if (!image) image = [info objectForKey:UIImagePickerControllerOriginalImage];
	if (image)
	{
		UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
		CGRect frame = imageView.frame;
		while (frame.size.width > MAX_IMAGE_WIDTH)
		{
			frame.size.width /= 2;
			frame.size.height /= 2;
		}
		imageView.frame = frame;
		
		NSLog(@"The frame size width is %f", imageView.frame.size.width);
		
		NSLog(@"The frame size height is %f", imageView.frame.size.height);
		
		[self setRandomLocationForImageView:imageView];
		[self.secondTabView addSubview:imageView];
		
	}

	[self dismissImagePicker];
}


- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[self dismissImagePicker];
}


@end




















