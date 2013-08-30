//
//  PhotoAlbumViewController.m
//  MetaDashBoard
//
//  Created by  on 8/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PhotoAlbumViewController.h"
#import "AlbumPageViewController.h"

@interface PhotoAlbumViewController ()

@property (nonatomic, strong) NSMutableArray *pictureViews;

@end

@implementation PhotoAlbumViewController

@synthesize pageViewController = _pageViewController;

@synthesize picturesArray = _picturesArray;

@synthesize picturesArrayDictionary = _picturesArrayDictionary;

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
	
	
	 NSDictionary *picturesDictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"MorePhotos" ofType:@"plist"] ];
	 
	self.picturesArrayDictionary = [picturesDictionary objectForKey:@"MorePhotosArray"];
	
	self.picturesArray = [self.picturesArrayDictionary allValues];
	
	/*  self.picturesArray = [picturesDictionary objectForKey:@"MorePhotosArray"]; */
	 
	NSLog(@"How many pictures %d", self.picturesArray.count);
	
	 /* self.picturesArray =  [NSArray arrayWithObjects:   
						   [UIImage imageNamed:@"photo001.jpg"],
						   [UIImage imageNamed:@"photo002.jpg"],
						   [UIImage imageNamed:@"photo003.jpg"],
						   [UIImage imageNamed:@"photo004.jpg"],
						   nil] ;    
	
	  */

	/* 
	self.picturesArray =  [NSArray arrayWithObjects:   
						   @"photo001.jpg",
						   @"photo002.jpg",
						   @"photo003.jpg",
						   @"photo004.jpg",
						   nil] ;   
	*/
	
	
	/* 
	NSArray *mypictures = [NSArray arrayWithObjects:@"photo001.jpg", 
													@"photo002.jpg", 
													@"photo003.jpg",
													@"photo004.jpg",
						   nil];
	
	NSDictionary *mypicturesDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:mypictures, @"PhotosArray", nil];
	
	self.picturesArray = [mypicturesDictionary objectForKey:@"PhotosArray"];
	
	 */
	// pass in options for the pageViewController
	
	//pass in the spine location option, but because it is from an enum, we can only put objects inside a dictionary
	
	
	NSDictionary *pageViewOptions = [NSDictionary dictionaryWithObjectsAndKeys:UIPageViewControllerOptionSpineLocationKey, [NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin], nil];
	
	
	// create the page view controller and save that instance in our pageViewController property
	// in the initializer, we pass in the transition style
	// a navigation orientation of forward and the options dictionary (or nil in case you don't want to set up any)
	
	self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:pageViewOptions];
	
	// pass the initial view controller for our page view controller, 
	AlbumPageViewController *albumPageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AlbumPageViewController"];
	
	albumPageViewController.index = 0;
	
	// code 
	if ([self.picturesArray count] > 0)
	{
		NSRange picturesRange;
		if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
		{
			picturesRange.location = 0;
			if (self.picturesArray.count >= 4)
			{
				picturesRange.length = 4;
			}
			else 
			{
				picturesRange.length = self.picturesArray.count;
			}
		}
		else 
		{
			picturesRange.location = 0;
			if (self.picturesArray.count >= 2)
			{
				picturesRange.length = 2;
			}
			else 
			{
				picturesRange.length = self.picturesArray.count;
			}
		}
		albumPageViewController.picturesArray = [self.picturesArray subarrayWithRange:picturesRange];
	}
	
	// end of code
	
	self.pageViewController.delegate = self;
	
	self.pageViewController.dataSource = self;
	
	[self.pageViewController setViewControllers:[NSArray arrayWithObject:albumPageViewController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
	
	// add the pageViewController as a child of the root view controller
	[self addChildViewController:self.pageViewController];
	
	
	// add the pageViewController's view as a subview of the PhotoAlbumViewController's view
	[self.view addSubview:self.pageViewController.view];
	
	// add gesture recognizers
	
	self.view.gestureRecognizers = self.pageViewController.view.gestureRecognizers;
	
	
	[self.pageViewController didMoveToParentViewController:self];
	
	self.pageViewController.view.frame = self.view.bounds;
	
}

- (void)viewDidUnload
{
	self.pageViewController = nil;
	self.picturesArray = nil;
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

#pragma mark UIPageViewControllerDelegate

- (UIPageViewControllerSpineLocation) pageViewController : (UIPageViewController *) pageViewController
					 spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation
{
	
	// 1
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad && UIInterfaceOrientationIsLandscape(orientation))
	{
		//2 
		
		AlbumPageViewController *currentViewController = [self.pageViewController.viewControllers objectAtIndex:0];
		
		NSArray *viewControllers = nil;
		
		NSUInteger indexOfCurrentViewController = currentViewController.index;
		
		//3
		if (indexOfCurrentViewController == 0 || indexOfCurrentViewController % 2 ==0)
		{
			UIViewController *nextViewController = [self pageViewController:self.pageViewController viewControllerAfterViewController:currentViewController];
			
			viewControllers = [NSArray arrayWithObjects:currentViewController, nextViewController, nil];
			
		}
		else 
		{
			UIViewController *previousViewController = [self pageViewController:self.pageViewController viewControllerBeforeViewController:currentViewController];
			
			viewControllers = [NSArray arrayWithObjects:previousViewController, currentViewController, nil];
		}
		
		
		// 4
		
		[self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
		
		return UIPageViewControllerSpineLocationMid;
		
	}
	
	// 5
	
	AlbumPageViewController *currentViewController = [self.pageViewController.viewControllers objectAtIndex:0];
	
	NSArray *viewControllers = [NSArray arrayWithObject:currentViewController];
	
	[self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
	
	self.pageViewController.doubleSided = NO;
	
	
	
	/* 	AlbumPageViewController *pageOne = [self.storyboard instantiateViewControllerWithIdentifier:@"AlbumPageViewController"];
	 
	 AlbumPageViewController *pageTwo = [self.storyboard instantiateViewControllerWithIdentifier:@"AlbumPageViewController"];
	 
	 NSArray *viewControllers = [NSArray arrayWithObjects:pageOne, pageTwo, nil];
	 
	 [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
	 
	 
	 
	 }
	 */
	
	return UIPageViewControllerSpineLocationMin;	
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
	NSLog(@"Transition completed");
}
#pragma mark UIPageViewControllerDataSource


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
	/* return [self.storyboard instantiateViewControllerWithIdentifier:@"AlbumPageViewController"]; */
	
	/* 
	 
	 AlbumPageViewController *previousViewController = (AlbumPageViewController *)viewController;
	 
	 if (previousViewController.index == 0)
	 {
	 return nil;
	 }
	 
	 AlbumPageViewController *albumPageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AlbumPageViewController"];
	 
	 albumPageViewController.index = previousViewController.index -1;
	 
	 return albumPageViewController;
	 
	 */
	
	AlbumPageViewController *previousViewController = (AlbumPageViewController *) viewController;
	
	if (previousViewController.index == 0)
	{
		return nil;
	}
	
	AlbumPageViewController *albumPageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AlbumPageViewController"];
	
	albumPageViewController.index = previousViewController.index -1;
	
	NSRange picturesRange;
	
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
	{
		NSUInteger startingIndex = ((albumPageViewController.index) * 4);
		
		picturesRange.location = startingIndex;
		
		picturesRange.length = 4;
		
		if ((picturesRange.location + picturesRange.length) >= self.picturesArray.count)
		{
			picturesRange.length = self.picturesArray.count - picturesRange.location - 1;
		}
	}
	else 
	{
		NSUInteger startingIndex = ((albumPageViewController.index) *2 );
		picturesRange.location = startingIndex;
		picturesRange.length = 2;
		
		if ((picturesRange.location + picturesRange.length) >= self.picturesArray.count)
		{
			picturesRange.length = self.picturesArray.count - picturesRange.location - 1;
		}
	}
	
	albumPageViewController.picturesArray = [self.picturesArray subarrayWithRange:picturesRange]; 
	
	/* albumPageViewController.picturesArray = self.picturesArray; */
	
	return albumPageViewController;
	
}


- (UIViewController *) pageViewController:(UIPageViewController *)pageViewController
		viewControllerAfterViewController:(UIViewController *)viewController
{
	/* return [self.storyboard instantiateViewControllerWithIdentifier:@"AlbumPageViewController"]; */
	
	/* 
	 
	 AlbumPageViewController *previousViewController = (AlbumPageViewController *)viewController;
	 
	 if (previousViewController.index == 9)
	 {
	 return nil;
	 }
	 
	 AlbumPageViewController *albumPageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AlbumPageViewController"];
	 
	 albumPageViewController.index = previousViewController.index + 1;
	 
	 return albumPageViewController;
	 */
	
	AlbumPageViewController *previousViewController = (AlbumPageViewController *) viewController;
	
	NSUInteger pagesCount;
	
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
	{
		pagesCount = (NSUInteger) ceilf(self.picturesArray.count * 0.25);
	}
	else 
	{
		pagesCount = (NSUInteger) ceilf(self.picturesArray.count * 0.5);
	}
	pagesCount--;
	
	if (previousViewController.index == pagesCount)
	{
		return nil;
	}
	
	AlbumPageViewController *albumPageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AlbumPageViewController"];
	
	albumPageViewController.index = previousViewController.index + 1;
	
	NSRange picturesRange;
	
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
	{
		NSUInteger startindeIndex = ((albumPageViewController.index) *4);
		picturesRange.location = startindeIndex;
		picturesRange.length = 4;
		if ((picturesRange.location + picturesRange.length) >= self.picturesArray.count)
		{
			picturesRange.length = self.picturesArray.count - picturesRange.location - 1;
			
		}
	}
	else 
	{
		NSUInteger startingIndex = ((albumPageViewController.index) * 2);
		
		picturesRange.location = startingIndex;
		
		picturesRange.length = 2;
		
		if ((picturesRange.location + picturesRange.length) >= self.picturesArray.count)
		{
			picturesRange.length = self.picturesArray.count - picturesRange.location - 1;
		}
	}
	albumPageViewController.picturesArray = [self.picturesArray subarrayWithRange:picturesRange]; 
	
	/* albumPageViewController.picturesArray = self.picturesArray; */
	
	return albumPageViewController;
}




@end

















