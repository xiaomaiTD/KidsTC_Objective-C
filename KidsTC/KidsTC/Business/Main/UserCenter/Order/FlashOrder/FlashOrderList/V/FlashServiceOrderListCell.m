//
//  FlashServiceOrderListCell.m
//  KidsTC
//
//  Created by zhanping on 8/18/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "FlashServiceOrderListCell.h"
#import "UIImageView+WebCache.h"
#import "FlashServiceOrderListViewController.h"

#define PROGRESSBGVIEW_HEIGHT 40

typedef enum : NSUInteger {
    FlashServiceOrderListCellBtnTypeProductDetail=1,
    FlashServiceOrderListCellBtnTypeLink,
} FlashServiceOrderListCellBtnType;

@interface FlashServiceOrderListCell ()
@property (weak, nonatomic) IBOutlet UILabel *orderIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderStatusDescLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HOneLingConstraintHeight;

@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UIView *progressBGView;
@property (weak, nonatomic) IBOutlet UILabel *progressPeopleNumLabel;
@property (weak, nonatomic) IBOutlet UIImageView *progressImageView;
@property (weak, nonatomic) IBOutlet UILabel *progressPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *countDownLabel;
@property (weak, nonatomic) IBOutlet UIButton *linkBtn;
@property (weak, nonatomic) IBOutlet UIButton *productDetailBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HTwoLineConstraintHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *productBtnTrailing;
@end

@implementation FlashServiceOrderListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.orderIdLabel.textColor = [UIColor lightGrayColor];
    self.orderStatusDescLabel.textColor = COLOR_PINK_FLASH;
    
    self.productImageView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.productImageView.layer.borderWidth = LINE_H;
    self.productNameLabel.textColor = [UIColor darkGrayColor];
    
    self.progressBGView.layer.cornerRadius = PROGRESSBGVIEW_HEIGHT*0.5;
    self.progressBGView.layer.masksToBounds = YES;
    self.progressPeopleNumLabel.layer.cornerRadius = (PROGRESSBGVIEW_HEIGHT-4)*0.5;
    self.progressPeopleNumLabel.layer.masksToBounds = YES;
    
    self.countDownLabel.textColor = COLOR_PINK_FLASH;
    self.linkBtn.backgroundColor = COLOR_PINK_FLASH;
    self.linkBtn.layer.cornerRadius = 2;
    self.linkBtn.layer.masksToBounds = YES;
    self.linkBtn.tag = FlashServiceOrderListCellBtnTypeLink;
    self.productDetailBtn.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.productDetailBtn.layer.cornerRadius = 2;
    self.productDetailBtn.layer.masksToBounds = YES;
    self.productDetailBtn.tag = FlashServiceOrderListCellBtnTypeProductDetail;
    self.HTwoLineConstraintHeight.constant = LINE_H;
    
    [NotificationCenter addObserver:self selector:@selector(countDown) name:FlashServiceOrderListCellCountDownNoti object:nil];
}

- (void)setItem:(FlashServiceOrderListItem *)item{
    _item = item;
    
    self.orderIdLabel.text = [NSString stringWithFormat:@"订单编号：%@",item.orderId];
    self.orderStatusDescLabel.text = item.orderStatusDesc;
    
    FlashServiceOrderDetailPriceConfig *config = item.currentPriceConfig;
    
    [self.productImageView sd_setImageWithURL:[NSURL URLWithString:item.productImg] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
    self.productNameLabel.text = item.productName;
    self.progressPeopleNumLabel.text = [NSString stringWithFormat:@"%zd人",item.prepaidNum];
    self.progressPriceLabel.text = [NSString stringWithFormat:@"成团价：%0.1f元",config.price];
    
    UIColor *themeColor = [UIColor lightGrayColor];
    NSString *rightImageName = @"order-right-0";
    if (config.priceStatus == FDPriceStatus_CurrentAchieved) {
        themeColor = COLOR_PINK_FLASH;
        rightImageName = @"order-right-1";
    }
    self.progressBGView.backgroundColor = themeColor;
    self.progressPeopleNumLabel.textColor = themeColor;
    self.progressImageView.image = [UIImage imageNamed:rightImageName];
    
    [self countDown];
    
    BOOL isCanBuy = item.isLink;
    self.linkBtn.hidden = !isCanBuy;
    if (!self.linkBtn.hidden) {
        [self.linkBtn setTitle:item.statusDesc forState:UIControlStateNormal];
        switch (item.status) {
            case FDDataStatus_WaitBuy://= 4,//等待开团，等待开团（已预付）:
            case FDDataStatus_HadPaid://= 12,//闪购成功，已购买:
            case FDDataStatus_Evaluted://= 16,//已评价，已评价 -在订单中:
            {
                self.linkBtn.backgroundColor = [COLOR_PINK_FLASH colorWithAlphaComponent:0.5];
            }
                break;
                
            default:
            {
                self.linkBtn.backgroundColor = COLOR_PINK_FLASH;
            }
                break;
        }
    }
    self.productBtnTrailing.constant = self.linkBtn.hidden?8:86;
}

- (void)countDown{
    
    _countDownLabel.text = (_item.countDownValue>=0 && _item.isShowCountDown)?_item.countDownValueString:@"";
    
    if (_item.countDownValue<0 && _item.countDownValueOriginal>0) {
        if ([self.delegate respondsToSelector:@selector(flashServiceOrderListCell:actionType:)]){
            [self.delegate flashServiceOrderListCell:self actionType:FlashServiceOrderListCellActionTypeReload];
        }
    }
}

- (IBAction)action:(UIButton *)sender {
    if (![self.delegate respondsToSelector:@selector(flashServiceOrderListCell:actionType:)]) return;
    FlashServiceOrderListCellActionType actionType = 0;
    FlashServiceOrderListCellBtnType btnType = (FlashServiceOrderListCellBtnType)sender.tag;
    switch (btnType) {
        case FlashServiceOrderListCellBtnTypeProductDetail:
        {
            actionType = FlashServiceOrderListCellActionTypeProductDetail;
        }
            break;
        case FlashServiceOrderListCellBtnTypeLink:
        {
            actionType = FlashServiceOrderListCellActionTypeLinkAction;
        }
            break;
    }
    [self.delegate flashServiceOrderListCell:self actionType:actionType];
}

- (void)dealloc{
    [NotificationCenter removeObserver:self name:FlashServiceOrderListCellCountDownNoti object:nil];
}

@end
