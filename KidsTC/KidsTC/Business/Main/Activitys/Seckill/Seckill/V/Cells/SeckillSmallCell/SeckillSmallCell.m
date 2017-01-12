//
//  SeckillSmallCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/10.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "SeckillSmallCell.h"
#import "SeckillProgressView.h"
#import "UIButton+Category.h"
#import "UIImageView+WebCache.h"
#import "NSString+Category.h"

@interface SeckillSmallCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UIView *discountBGView;
@property (weak, nonatomic) IBOutlet UILabel *discountL;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *tipL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UILabel *originalPriceL;
@property (weak, nonatomic) IBOutlet SeckillProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *attentionCountL;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
@end

@implementation SeckillSmallCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.icon.layer.cornerRadius = 4;
    self.icon.layer.masksToBounds = YES;
    self.icon.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.icon.layer.borderWidth = LINE_H;
    
    self.buyBtn.layer.cornerRadius = 4;
    self.buyBtn.layer.masksToBounds = YES;
}

- (void)setItem:(SeckillDataItem *)item {
    [super setItem:item];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:item.imageUrl] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
    self.nameL.text = item.productName;
    self.tipL.text = item.promotionText;
    self.priceL.text = [NSString stringWithFormat:@"¥ %@",item.price];
    self.originalPriceL.text = [NSString stringWithFormat:@"¥ %@",item.orignalPrice];
    self.attentionCountL.text = [NSString stringWithFormat:@"已有%@人关注",item.remindCount];
    self.discountL.text = item.productPlatformTagTypeDesc;
    self.discountBGView.hidden = ![item.productPlatformTagTypeDesc isNotNull];
    self.progressView.progress = item.buyPercent/100.0;
    
    BOOL btnHide = NO;
    BOOL enable = NO;
    UIColor *btnBGColor = nil;
    NSString *btnTitle = @"";
    UIColor *btnTitleColor = nil;
    switch (item.status) {
        case SeckillDataItemBtnStatusRemindMe:
        {
            btnHide = NO;
            enable = YES;
            btnBGColor = [UIColor colorFromHexString:@"51b946"];
            btnTitle = @"提醒我";
            btnTitleColor = [UIColor whiteColor];
        }
            break;
        case SeckillDataItemBtnStatusHasRemind:
        {
            btnHide = NO;
            enable = NO;
            btnBGColor = [UIColor colorFromHexString:@"d6fed6"];
            btnTitle = @"已提醒";
            btnTitleColor = [UIColor colorFromHexString:@"51b946"];
        }
            break;
        case SeckillDataItemBtnStatusBuyNow:
        {
            btnHide = NO;
            enable = NO;
            btnBGColor = [UIColor colorFromHexString:@"fe5f5c"];
            btnTitle = @"立即抢购";
            btnTitleColor = [UIColor whiteColor];
        }
            break;
        case SeckillDataItemBtnStatusHasSaleOut:
        {
            btnHide = NO;
            enable = NO;
            btnBGColor = [UIColor colorFromHexString:@"cccccc"];
            btnTitle = @"已抢完";
            btnTitleColor = [UIColor whiteColor];
        }
            break;
        case SeckillDataItemBtnStatusHasFinished:
        {
            btnHide = NO;
            enable = NO;
            btnBGColor = [UIColor colorFromHexString:@"cccccc"];
            btnTitle = @"已结束";
            btnTitleColor = [UIColor whiteColor];
        }
            break;
        case SeckillDataItemBtnStatusWaitOpen:
        {
            btnHide = NO;
            enable = NO;
            btnBGColor = [UIColor colorFromHexString:@"cccccc"];
            btnTitle = @"等待开抢";
            btnTitleColor = [UIColor whiteColor];
        }
            break;
        default:
        {
            btnHide = YES;
        }
            break;
    }
    self.buyBtn.hidden = btnHide;
    self.buyBtn.enabled = enable;
    self.buyBtn.backgroundColor = btnBGColor;
    [self.buyBtn setTitle:btnTitle forState:UIControlStateNormal];
    [self.buyBtn setTitleColor:btnTitleColor forState:UIControlStateNormal];
    
    
    switch (item.status) {
        case SeckillDataItemBtnStatusRemindMe:
        case SeckillDataItemBtnStatusHasRemind:
        case SeckillDataItemBtnStatusWaitOpen:
        {
            self.progressView.hidden = YES;
            self.attentionCountL.hidden = NO;
        }
            break;
        case SeckillDataItemBtnStatusBuyNow:
        case SeckillDataItemBtnStatusHasSaleOut:
        case SeckillDataItemBtnStatusHasFinished:
        {
            self.progressView.hidden = NO;
            self.attentionCountL.hidden = YES;
        }
            break;
        default:
        {
            self.progressView.hidden = YES;
            self.attentionCountL.hidden = YES;
        }
            break;
    }
}

- (IBAction)action:(UIButton *)sender {
    if (self.item.status == SeckillDataItemBtnStatusRemindMe) {
        if ([self.delegate respondsToSelector:@selector(seckillBaseCell:actionType:value:)]) {
            [self.delegate seckillBaseCell:self actionType:SeckillBaseCellActionTypeRemind value:self.item];
        }
    }
}

@end
