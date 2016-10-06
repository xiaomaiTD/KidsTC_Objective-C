//
//  AlbumCollectionViewCell.m
//  KidsTC
//
//  Created by zhanping on 6/3/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "AlbumCollectionViewCell.h"
#import "ZPProgress.h"
#import "UIImage+Category.h"
#import "UIImageView+WebCache.h"
@interface AlbumCollectionViewCell ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet ZPProgress *progressView;
@end

@implementation AlbumCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    tapGR.numberOfTapsRequired = 2;
    [self.scrollView addGestureRecognizer:tapGR];
}

- (void)tapAction:(UITapGestureRecognizer *)tagGR {
    CGFloat scale = self.scrollView.zoomScale;
    if (scale == 1) {
        scale = 2;
    }else{
        scale = 1;
    }
    [self.scrollView setZoomScale:scale animated:YES];
    
}

-(void)setImageUrl:(NSString *)imageUrl{
    _imageUrl = imageUrl;
    self.scrollView.zoomScale = 1;
    self.progressView.hidden = NO;
    
    __weak typeof(self) weakSelf = self;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:_imageUrl] placeholderImage:nil options:kNilOptions progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        AlbumCollectionViewCell *strongSelf = weakSelf;
        strongSelf.progressView.progress = receivedSize*0.1/expectedSize;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        AlbumCollectionViewCell *strongSelf = weakSelf;
        
        strongSelf.progressView.hidden = YES;
    }];
}

//返回要缩放的视图
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}


@end
