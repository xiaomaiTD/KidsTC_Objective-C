//
//  ScoreEarnCommentCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/10.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ScoreEarnCommentCell.h"
#import "UIImageView+WebCache.h"
#import "NSString+Category.h"

@interface ScoreEarnCommentCell ()

@property (weak, nonatomic) IBOutlet UIView *storeBGView;
@property (weak, nonatomic) IBOutlet UIImageView *storeIcon;
@property (weak, nonatomic) IBOutlet UILabel *storeNameL;
@property (weak, nonatomic) IBOutlet UILabel *statusNameL;
@property (weak, nonatomic) IBOutlet UIImageView *imageIcon;

@property (weak, nonatomic) IBOutlet UILabel *realPriceTipL;
@property (weak, nonatomic) IBOutlet UILabel *realPriceL;

@property (weak, nonatomic) IBOutlet UILabel *productNameL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UILabel *countL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;

@property (weak, nonatomic) IBOutlet UIButton *contactBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;

@property (weak, nonatomic) IBOutlet UIView *fightBGView;
@property (weak, nonatomic) IBOutlet UIImageView *fightImg;
@property (weak, nonatomic) IBOutlet UIImageView *fightArrowImg;
@property (weak, nonatomic) IBOutlet UILabel *fightNameL;
@property (weak, nonatomic) IBOutlet UIView *radishBGView;
@property (weak, nonatomic) IBOutlet UILabel *radishCountL;


@property (nonatomic,strong) ScoreOrderItem *order;

@end

@implementation ScoreEarnCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    
    _imageIcon.layer.cornerRadius = 4;
    _imageIcon.layer.masksToBounds = YES;
    _imageIcon.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    _imageIcon.layer.borderWidth = LINE_H;
    self.HLineH.constant = LINE_H;
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.contentView addGestureRecognizer:tapGR];
    
    self.contactBtn.layer.cornerRadius = 2;
    self.contactBtn.layer.masksToBounds = YES;
    self.contactBtn.layer.borderWidth = 1;
    self.contactBtn.layer.borderColor = [UIColor colorFromHexString:@"444444"].CGColor;
    self.contactBtn.tag = ScoreEarnBaseCellActionTypeContact;
    
    self.commentBtn.layer.cornerRadius = 2;
    self.commentBtn.layer.masksToBounds = YES;
    self.commentBtn.layer.borderWidth = 1;
    self.commentBtn.layer.borderColor = [UIColor colorFromHexString:@"FF8888"].CGColor;
    self.commentBtn.tag = ScoreEarnBaseCellActionTypeComment;
    
    self.fightImg.layer.cornerRadius = CGRectGetWidth(self.fightImg.frame) * 0.5;
    self.fightImg.layer.masksToBounds = YES;
    self.fightImg.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.fightImg.layer.borderWidth = LINE_H;
    
}

- (void)setItem:(ScoreEarnShowItem *)item {
    [super setItem:item];
    
    NSUInteger index = item.index;
    NSArray<ScoreOrderItem *> *orderItems = self.orderItems;
    if (index>=orderItems.count) return;
    ScoreOrderItem *order = orderItems[index];
    self.order = order;
    
    self.storeNameL.text = order.storeName;
    self.statusNameL.text = order.statusName;
    [self.imageIcon sd_setImageWithURL:[NSURL URLWithString:order.imgUrl] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
    self.realPriceTipL.text = order.payDesc;
    self.realPriceL.text = [NSString stringWithFormat:@"¥%@",order.payPrice];
    
    switch (order.orderKind) {
        case OrderKindFight:
        {
            self.storeBGView.hidden = YES;
            self.fightBGView.hidden = NO;
            [self.fightImg sd_setImageWithURL:[NSURL URLWithString:order.openGroupHeader] placeholderImage:PLACEHOLDERIMAGE_SMALL_LOG];
            self.fightNameL.text = order.openGroupUserName;
        }
            break;
            
        default:
        {
            self.fightBGView.hidden = YES;
            switch (order.placeType) {
                case PlaceTypeStore:
                {
                    self.storeBGView.hidden = NO;
                }
                    break;
                case PlaceTypeNone:
                {
                    self.storeBGView.hidden = YES;
                }
                    break;
                default:
                {
                    self.storeBGView.hidden = NO;
                }
                    break;
            }
        }
            break;
    }
    
    if (order.orderKind == OrderKindRadish) {
        self.radishBGView.hidden = NO;
        self.radishCountL.text = [NSString stringWithFormat:@"%@",order.radishCount];
    }else{
        self.radishBGView.hidden = YES;
    }
    
    self.productNameL.text = order.productName;
    self.countL.text = [NSString stringWithFormat:@"x%@",order.payNum];
    self.priceL.text = [NSString stringWithFormat:@"¥%@",order.unitPrice];
    self.timeL.text = order.createTime;
    self.contactBtn.hidden = order.phones.count<1;
}

- (void)tapAction {
    if ([self.delegate respondsToSelector:@selector(scoreEarnBaseCell:actionType:value:)]) {
        [self.delegate scoreEarnBaseCell:self actionType:ScoreEarnBaseCellActionTypeOrderDetail value:_order];
    }
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(scoreEarnBaseCell:actionType:value:)]) {
        [self.delegate scoreEarnBaseCell:self actionType:(ScoreEarnBaseCellActionType)sender.tag value:_order];
    }
}


@end
