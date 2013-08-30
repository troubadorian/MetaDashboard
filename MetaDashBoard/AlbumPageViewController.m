//
//  AlbumPageViewController.m
//  MetaDashBoard
//
//  Created by  on 8/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AlbumPageViewController.h"

@interface AlbumPageViewController ()
@property (nonatomic, strong) NSMutableArray *pictureViews;
@end

@implementation AlbumPageViewController

@synthesize index = _index;
@synthesize picturesArray = _picturesArray;
@synthesize pictureViews = _pictureViews;

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
	
	/* self.picturesArray =  [NSArray arrayWithObjects:   
	 @"photo001.jpg",
	 @"photo002.jpg",
	 @"photo003.jpg",
	 @"photo004.jpg",
	 nil] ;    
	 */
	
	
	 
	for (NSString *pictureName in self.picturesArray)
	{
		if (!self.pictureViews)
		{
			self.pictureViews = [NSMutableArray array];
		}
		
		NSLog(@"pictureName : %@", pictureName);
		
		
		UIImageView *picture = [[UIImageView alloc] initWithImage:[UIImage imageNamed:pictureName]];
		
		NSLog(@"adding picture to pictureViews array %@", picture);
		
		[self.pictureViews addObject:picture];
	}
	
	
	 
	self.view.backgroundColor = [UIColor clearColor];
	
	/* 
	if (!self.pictureViews)
	{
		self.pictureViews = [NSMutableArray array];
		
		UIImageView *picture = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photo001.jpg"]];
		
		[self.pictureViews addObject:picture];
		
		picture = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photo002.jpg"]];
		
		[self.pictureViews addObject:picture];
		
		picture = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photo003.jpg"]];
		
		[self.pictureViews addObject:picture];
		
		picture = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photo004.jpg"]];
		
		[self.pictureViews addObject:picture];
	}
	 */
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	[self layoutPicturesAnimated:NO withDuration:0 forInterfaceOrientation:self.interfaceOrientation];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	[self layoutPicturesAnimated:YES withDuration:duration forInterfaceOrientation:toInterfaceOrientation];
}

- (void)viewDidUnload
{
	self.picturesArray = nil;
	self.pictureViews = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    /* return (interfaceOrientation == UIInterfaceOrientationPortrait); */
	
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
	{
		return interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
	}
	return YES;
}

- (void) setPictureAtIndex:(NSUInteger) index 
				   inFrame:(CGRect) frameForPicture
{
	UIImageView *picture = [self.pictureViews objectAtIndex:index];
	NSLog(@"---------------picture %@", picture);
	NSLog(@"---------------picture.image.size.width %f", picture.image.size.width);
	NSLog(@"-------------------picture.image.size.height %f", picture.image.size.height);
	
	CGFloat scale;
	if (picture.image.size.width >= picture.image.size.height)
	{

		scale = picture.image.size.height / picture.image.size.width;
		NSLog(@"----picture.image.size.height-------------------------------------------- %f", picture.image.size.height);
		NSLog(@"----picture.image.size.width-------------------------------------------- %f", picture.image.size.width);
		picture.frame = CGRectMake(0, 0, (frameForPicture.size.width * 0.80), (frameForPicture.size.width * 0.80) * scale);
		
		picture.center = CGPointMake(frameForPicture.origin.x + (frameForPicture.size.width * 0.5), frameForPicture.origin.y + (frameForPicture.size.height * 0.5));
				NSLog(@"------------------------------------------------ %@", picture);
	}
	else 
	{

		scale = picture.image.size.width / picture.image.size.height;
		picture.frame = CGRectMake(0, 0, (frameForPicture.size.height * 0.80) * scale, (frameForPicture.size.height * 0.80));
		
		picture.center = CGPointMake(frameForPicture.origin.x + (frameForPicture.size.width * 0.5), frameForPicture.origin.y + (frameForPicture.size.height * 0.5));
		
				NSLog(@"------------------------------------------------ %@", picture);
		
		
	}
	[self.view addSubview:picture];
}


- (void)layoutPicturesAnimated:(BOOL)animated 
				  withDuration:(NSTimeInterval)duration
	   forInterfaceOrientation:(UIInterfaceOrientation) interfaceOrientation
{
	if (animated)
	{
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:duration];
		[UIView setAnimationDelay:0];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	}
	CGRect orientationFrame;
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
	{
		if (UIInterfaceOrientationIsPortrait(interfaceOrientation))
		{
			orientationFrame = CGRectMake(0, 0, 768, 1024);
		}
		else
		{
			orientationFrame = CGRectMake(0, 0, 512, 768);
		}
	}
	
	else 
	{
		if (UIInterfaceOrientationIsPortrait(interfaceOrientation))
		{
			orientationFrame = CGRectMake(0, 0, 320, 480);
		}
		else 
		{
			orientationFrame = CGRectMake(0, 0, 480, 320);
		}
	}
	if (self.picturesArray.count > 0)
	{
		if (self.picturesArray.count == 1)
		{
			NSLog(@"___is execution here");
			
			[self setPictureAtIndex:0 inFrame:orientationFrame];
		}
		
		else if (self.picturesArray.count == 2)
		{
			NSLog(@"___is execution here2");
			CGRect frameOne;
			CGRect frameTwo;
			if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && UIInterfaceOrientationIsLandscape(interfaceOrientation))
			{
				frameOne = CGRectMake(0, 0, orientationFrame.size.width * 0.5, orientationFrame.size.height);
				frameTwo = CGRectMake(orientationFrame.size.width * 0.5, 0, orientationFrame.size.width * 0.5, orientationFrame.size.height);
				
				[self setPictureAtIndex:0 inFrame:frameOne];
				[self setPictureAtIndex:1 inFrame:frameTwo];
				
			}
			else 
			{
				frameOne = CGRectMake(0, 0, orientationFrame.size.width, orientationFrame.size.height * 0.5	);
				frameTwo = CGRectMake(0, orientationFrame.size.height * 0.5, orientationFrame.size.width, orientationFrame.size.height *0.5);
				[self setPictureAtIndex:0 inFrame:frameOne];
				[self setPictureAtIndex:1 inFrame:frameTwo];
				
			}
		}
		else 
		{
			CGRect frameOne;
			CGRect frameTwo;
			
			CGRect frameThree;
			CGRect frameFour;
			
			frameOne = CGRectMake(0, 0, orientationFrame.size.width * 0.5, orientationFrame.size.height * 0.5);
			frameTwo = CGRectMake(orientationFrame.size.width * 0.5, 0, orientationFrame.size.width * 0.5, orientationFrame.size.height * 0.5);
			frameThree = CGRectMake(0, orientationFrame.size.height * 0.5, orientationFrame.size.width * 0.5, orientationFrame.size.height * 0.5);
			frameFour = CGRectMake(orientationFrame.size.width * 0.5, orientationFrame.size.height * 0.5, orientationFrame.size.width * 0.5, orientationFrame.size.height * 0.5);
			
			NSLog(@"___is execution here3");
			[self setPictureAtIndex:0 inFrame:frameOne];
			[self setPictureAtIndex:1 inFrame:frameTwo];
			[self setPictureAtIndex:2 inFrame:frameThree];
			
			if (self.picturesArray.count == 4)
			{
				[self setPictureAtIndex:3 inFrame:frameFour];
			}
		}
	}
	if (animated)
	{
		[UIView commitAnimations];
	}
}
@end
