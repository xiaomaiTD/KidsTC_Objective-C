//
//  NormalProductDetailColumnConsultConsultCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NormalProductDetailColumnConsultConsultCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"
#import "Colours.h"

@interface NormalProductDetailColumnConsultConsultCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UILabel *contentL;

@end

@implementation NormalProductDetailColumnConsultConsultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.headImageView.layer.cornerRadius = CGRectGetWidth(self.headImageView.bounds) * 0.5;
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.headImageView.layer.borderWidth = LINE_H;
    
    self.nameL.textColor = [UIColor colorFromHexString:@"333333"];
    self.timeL.textColor = [UIColor colorFromHexString:@"AFAFAF"];
    self.contentL.textColor = [UIColor colorFromHexString:@"666666"];
    
}

- (void)setItem:(NormalProductDetailConsultItem *)item {
    _item = item;
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:item.headUrl] placeholderImage:PLACEHOLDERIMAGE_SMALL_LOG];
    self.nameL.text = item.name;
    self.nameL.textColor = item.isReply?COLOR_PINK:[UIColor darkGrayColor];
    self.contentL.text = item.content;
    self.timeL.text = item.time;
}


@end
