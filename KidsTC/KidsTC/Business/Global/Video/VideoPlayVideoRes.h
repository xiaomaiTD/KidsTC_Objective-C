//
//  VideoPlayVideoRes.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/17.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideoPlayVideo.h"
@interface VideoPlayVideoRes : NSObject
@property (nonatomic, strong) NSString *productVideoTitle;
@property (nonatomic, strong) NSArray<VideoPlayVideo *> *productVideos;
@end
