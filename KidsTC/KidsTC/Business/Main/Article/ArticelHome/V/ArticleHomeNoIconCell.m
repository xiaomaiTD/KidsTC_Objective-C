//
//  ArticleHomeNoIconCell.m
//  KidsTC
//
//  Created by zhanping on 9/1/16.
//  Copyright © 2016 zhanping. All rights reserved.
//

#import "ArticleHomeNoIconCell.h"

#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"
#import "ArticleHomeBottomView.h"

@interface ArticleHomeNoIconCell ()
@property (weak, nonatomic) IBOutlet ArticleHomeBottomView *bottomView;
@property (weak, nonatomic) IBOutlet UILabel *coulmnLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *brefContentLabel;
@property (weak, nonatomic) IBOutlet UIView *infoContentView;
@end

@implementation ArticleHomeNoIconCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.coulmnLabel.textColor = COLOR_PINK;
}

- (void)setItem:(ArticleHomeItem *)item {
    [super setItem:item];
    self.coulmnLabel.text = item.columnTitle;
    self.titleLabel.attributedText = item.titleAttributeStr;
    self.brefContentLabel.attributedText = item.brifContentAttributeStr;
    self.bottomView.item = item;
}

@end
