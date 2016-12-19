//
//  CollectionTarentoHeader.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectionTarentoHeader.h"
#import "Colours.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"
#import "NSString+Category.h"

@interface CollectionTarentoHeader ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *signL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UILabel *articleNumL;
@property (weak, nonatomic) IBOutlet UILabel *seeNumL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineH;
@end

@implementation CollectionTarentoHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    
    self.icon.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.icon.layer.borderWidth = LINE_H;
    self.icon.layer.cornerRadius = CGRectGetWidth(self.icon.bounds) * 0.5;
    self.icon.layer.masksToBounds = YES;
    
    self.nameL.textColor = [UIColor colorFromHexString:@"333333"];
    self.signL.textColor = [UIColor colorFromHexString:@"888888"];
    self.articleNumL.textColor = [UIColor colorFromHexString:@"A9A9A9"];
    self.seeNumL.textColor = [UIColor colorFromHexString:@"A9A9A9"];
    self.timeL.textColor = [UIColor colorFromHexString:@"A9A9A9"];
}
- (IBAction)action:(UIButton *)sender {
    if (self.actionBlock) {
        self.actionBlock(_item);
    }
}

- (IBAction)deleteActioin:(UIButton *)sender {
    if (self.deleteBlock) {
        self.deleteBlock(_item);
    }
}

- (void)setItem:(CollectionTarentoItem *)item {
    _item = item;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:_item.headSculpture] placeholderImage:PLACEHOLDERIMAGE_SMALL_LOG];
    self.nameL.text = _item.authorName;
    self.timeL.text = _item.collectedTimeDesc;
    self.signL.text = _item.authorSign;
    self.articleNumL.text = _item.publishArticleNum;
    self.seeNumL.text = _item.viewSumNum;
}

@end
