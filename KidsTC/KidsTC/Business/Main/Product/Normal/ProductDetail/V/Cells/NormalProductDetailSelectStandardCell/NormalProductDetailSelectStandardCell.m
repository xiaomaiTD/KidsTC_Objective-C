//
//  NormalProductDetailSelectStandardCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/19.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NormalProductDetailSelectStandardCell.h"

@interface NormalProductDetailSelectStandardCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@end

@implementation NormalProductDetailSelectStandardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tapGR];
}
- (void)setData:(NormalProductDetailData *)data {
    [super setData:data];
    self.nameL.text = data.standardName;
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    if ([self.delegate respondsToSelector:@selector(normalProductDetailBaseCell:actionType:value:)]) {
        [self.delegate normalProductDetailBaseCell:self actionType:NormalProductDetailBaseCellActionTypeSelectStandard value:nil];
    }
}
@end
