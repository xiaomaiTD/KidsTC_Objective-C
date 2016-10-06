//
//  AutoRollCell.m
//  AutoRollViewController
//
//  Created by 平 on 15/12/12.
//  Copyright © 2015年 ping. All rights reserved.
//

#import "FlashDetailAutoRollViewCell.h"
// 只要添加了这个宏，就不用带mas_前缀
#define MAS_SHORTHAND
// 只要添加了这个宏，equalTo就等价于mas_equalTo
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"

@interface FlashDetailAutoRollViewCell ()
@property (nonatomic, weak) UIImageView *imageView;
@end


@implementation FlashDetailAutoRollViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] init];
        
        [self.contentView addSubview:imageView];
        //imageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 100);
        self.imageView = imageView;
        
        [imageView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        
    }
    return self;
}

- (void)setImageUrl:(NSString *)imageUrl{
    _imageUrl = imageUrl;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:PLACEHOLDERIMAGE_SMALL];
}

@end
