//
//  VideoPlayViewController.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/16.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ViewController.h"
#import "VideoPlayVideo.h"

@class VideoPlayViewController;
@protocol VideoPlayViewControllerDelegate <NSObject>
- (void)addPlayViewWith:(VideoPlayViewController *)controller;
@end

@interface VideoPlayViewController : ViewController
@property (nonatomic, strong) VideoPlayVideo *video;;
@property (nonatomic, assign) BOOL isFullScreen;
@property (nonatomic, weak) UIView<VideoPlayViewControllerDelegate> *targetView;
@end
