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
    self.backgroundColor = [UIColor colorWithRed:0.953 green:0.961 blue:0.969 alpha:1];
    _iconIv.layer.cornerRadius = 4;
    _iconIv.layer.masksToBounds = YES;
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
