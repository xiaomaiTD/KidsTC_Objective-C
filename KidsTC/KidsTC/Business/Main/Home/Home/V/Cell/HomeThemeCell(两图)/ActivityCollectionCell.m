//
//  ActivityCollectionCell.m
//  KidsTC
//
//  Created by 潘灵 on 16/7/21.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "ActivityCollectionCell.h"
#import "Masonry.h"

@implementation ActivityCollectionCell

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self.contentView addSubview:self.iv_activity];
        self.backgroundColor = [UIColor whiteColor];
        
        [self.iv_activity mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return self;
}

-(UIImageView *)iv_activity{
    if (!_iv_activity) {
        _iv_activity = [[UIImageView alloc] init];
    }
    return _iv_activity;
}
@end
