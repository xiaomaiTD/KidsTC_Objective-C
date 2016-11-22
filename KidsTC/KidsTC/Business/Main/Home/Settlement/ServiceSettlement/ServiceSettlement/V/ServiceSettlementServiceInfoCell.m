//
//  ServiceSettlementServiceInfoCell.m
//  KidsTC
//
//  Created by zhanping on 8/11/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ServiceSettlementServiceInfoCell.h"
#import "UIImageView+WebCache.h"

@interface ServiceSettlementServiceInfoCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *serveDescLabel;
@end

@implementation ServiceSettlementServiceInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.iconImageView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.iconImageView.layer.borderWidth = LINE_H;
}

- (void)setItem:(ServiceSettlementDataItem *)item{
    [super setItem:item];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:item.imgUrl] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
    self.serveDescLabel.attributedText = item.attServiceInfo;
}

@end
