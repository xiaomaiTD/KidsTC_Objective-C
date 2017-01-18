//
//  ProductDetailVideoCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/16.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ProductDetailVideoCell.h"
#import "VideoPlayViewController.h"

@interface ProductDetailVideoCell ()<VideoPlayViewControllerDelegate>
@property (weak,   nonatomic) IBOutlet UIView *playContentView;
@property (weak,   nonatomic) IBOutlet UILabel *tipL;
@property (nonatomic, strong) VideoPlayViewController *playVC;
@end

@implementation ProductDetailVideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.playVC = [[VideoPlayViewController alloc] initWithNibName:@"VideoPlayViewController" bundle:nil];
    self.playVC.targetView = self;
    [self addPlayViewWith:self.playVC];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (!self.playVC.isFullScreen) {
        self.playVC.view.frame = self.playContentView.bounds;
    }
}

- (void)setData:(ProductDetailData *)data {
    [super setData:data];
    VideoPlayVideoRes *productVideoRes = data.productVideoRes;
    NSInteger index = self.tag;
    if (index<productVideoRes.productVideos.count) {
        if (!self.playVC.video) {
            VideoPlayVideo *video = productVideoRes.productVideos[index];
            self.playVC.video = video;
            self.tipL.text = video.videoDesc;
        }
    }
}

- (void)addPlayViewWith:(VideoPlayViewController *)controller {
    [self.playContentView addSubview:self.playVC.view];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)dealloc {
    self.playVC = nil;
}

@end
