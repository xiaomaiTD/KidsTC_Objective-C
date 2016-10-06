//
//  ColumnCell.m
//  KidsTC
//
//  Created by zhanping on 4/14/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "ColumnCell.h"
#import "UIImage+Category.h"
#import "UIImageView+WebCache.h"
#define margin 8 //Cell的内边距
//#define textLabelH 30 //栏目标题

@implementation ColumnCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.imageView = [[UIImageView alloc]init];
        [self addSubview:self.imageView];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(margin, margin, self.frame.size.width-margin*2, self.frame.size.height-margin*2);
    self.imageView.layer.cornerRadius = 8;
    self.imageView.layer.masksToBounds = YES;
}

- (void)setItem:(CDataItem *)item{
    _item = item;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:_item.imgUrl] placeholderImage:PLACEHOLDERIMAGE_SMALL];
}


@end
