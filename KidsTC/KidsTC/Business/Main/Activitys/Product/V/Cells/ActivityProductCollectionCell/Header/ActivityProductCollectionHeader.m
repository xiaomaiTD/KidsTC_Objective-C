//
//  ActivityProductCollectionHeader.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/13.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ActivityProductCollectionHeader.h"
#import "UIImageView+WebCache.h"

@interface ActivityProductCollectionHeader ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation ActivityProductCollectionHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setContent:(ActivityProductContent *)content {
    _content = content;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:content.floorTopPicUrl] placeholderImage:PLACEHOLDERIMAGE_BIG];
}

@end
