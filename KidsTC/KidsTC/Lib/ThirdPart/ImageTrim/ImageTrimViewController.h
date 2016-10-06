//
//  ImageTrimViewController.h
//  KidsTC
//
//  Created by Altair on 11/13/15.
//  Copyright © 2015 KidsTC. All rights reserved.
//

#import "ViewController.h"

@class ImageTrimViewController;

@protocol ImageTrimViewControllerDelegate <NSObject>

- (void)imageTrimViewController:(ImageTrimViewController *)controller didFinishedTrimmingWithNewImage:(UIImage *)image;

@end

@interface ImageTrimViewController : ViewController

@property (nonatomic, weak) id<ImageTrimViewControllerDelegate> delegate;

- (instancetype)initWithImage:(UIImage *)image targetSize:(CGSize)size;

@end
