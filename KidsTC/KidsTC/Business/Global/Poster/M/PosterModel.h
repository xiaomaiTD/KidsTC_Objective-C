//
//  PosterModel.h
//  KidsTC
//
//  Created by zhanping on 7/25/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "Model.h"

@interface PosterAdsItem : Model
@property (nonatomic, strong) NSString *img;
@property (nonatomic, assign) NSInteger linkType;
@property (nonatomic, strong) NSString *params;

@property (nonatomic, strong) NSData *imageData;//根据img下载下来的图片数据
@end

@interface PosterData : Model
@property (nonatomic, assign) NSTimeInterval expireTime;
@property (nonatomic, strong) NSArray<PosterAdsItem *> *ads;
@end

@interface PosterModel : Model
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) PosterData *data;
@property (nonatomic, strong) NSString *md5;
@end
