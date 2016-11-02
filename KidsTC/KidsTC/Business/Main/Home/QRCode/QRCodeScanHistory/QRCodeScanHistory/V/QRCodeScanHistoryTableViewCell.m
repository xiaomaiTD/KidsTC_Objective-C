//
//  QRCodeScanHistoryTableViewCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/20.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "QRCodeScanHistoryTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "NSString+ZP.h"
#import "ZPDateFormate.h"
#import "Colours.h"
@interface QRCodeScanHistoryTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconIv;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *subTitleL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstraintH;
@end

@implementation QRCodeScanHistoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = [UIColor whiteColor];
    _iconIv.layer.cornerRadius = 4;
    _iconIv.layer.masksToBounds = YES;
    _iconIv.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    _iconIv.layer.borderWidth = LINE_H;
    _subTitleL.textColor = [UIColor colorFromHexString:@"#666666"];
    _timeL.textColor = [UIColor colorFromHexString:@"#a9a9a9"];
    _line.backgroundColor = [UIColor colorWithRed:0.890 green:0.890 blue:0.890 alpha:1];
    _HLineConstraintH.constant = LINE_H;
    [self layoutIfNeeded];
}

- (void)setItem:(QRCodeScanHistoryItem *)item {
    _item = item;
    switch (item.type) {
        case QRCodeScanHistoryItemTypeQRCode:
        {
            self.iconIv.image = [UIImage imageNamed:@"newbarcode_history_qrcodeimage"];
        }
            break;
        case QRCodeScanHistoryItemTypeBarCode:
        {
            self.iconIv.image = [UIImage imageNamed:@"newbarcode_history_barcodeimage"];
        }
            break;
        case QRCodeScanHistoryItemTypeProduct:
        {
            [self.iconIv sd_setImageWithURL:[NSURL URLWithString:item.imgUrl] placeholderImage:[UIImage imageNamed:@"newbarcode_history_qrcodeimage"]];
        }
            break;
    }
    self.titleL.text = item.title;
    self.subTitleL.text = item.subTitle;
    self.timeL.text = [NSString zp_stringWithTimeInterval:item.time Format:DF_yMd];
    
}

@end
