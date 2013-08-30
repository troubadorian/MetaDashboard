//
//  PhotoAlbumViewController.h
//  MetaDashBoard
//
//  Created by  on 8/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoAlbumViewController : UIViewController<UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property (nonatomic, strong) UIPageViewController *pageViewController;

@property (nonatomic, strong) NSArray *picturesArray;

@property (nonatomic, strong) NSDictionary *picturesArrayDictionary;

@end
