//
//  ArticleHomeColumnTitleCollectionViewCell.m
//  KidsTC
//
//  Created by zhanping on 9/1/16.
//  Copyright © 2016 zhanping. All rights reserved.
//

#import "ArticleHomeColumnTitleCollectionViewCell.h"

@interface ArticleHomeColumnTitleCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation ArticleHomeColumnTitleCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

@end
