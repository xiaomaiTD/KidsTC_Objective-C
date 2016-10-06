//
//  ArticleWriteBaseCell.m
//  KidsTC
//
//  Created by zhanping on 9/8/16.
//  Copyright © 2016 zhanping. All rights reserved.
//

#import "ArticleWriteBaseCell.h"

int const kBottomHeight = 49;

@implementation ArticleWriteBaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //self.backgroundColor = RandomColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (void)setModel:(ArticleWriteModel *)model {
    _model = model;
    self.userInteractionEnabled = model.canEdit;
}


@end
