//
//  OrderListViewCell.m
//  KidsTC
//
//  Created by 钱烨 on 7/8/15.
//  Copyright (c) 2015 KidsTC. All rights reserved.
//

#import "OrderListViewCell.h"
#import "UIButton+Category.h"
#import "ToolBox.h"
#import "UIImage+Category.h"
#import "UIImageView+WebCache.h"

@interface OrderListViewCell ()
@property (weak, nonatomic) IBOutlet UIView *headerBGView;
@property (weak, nonatomic) IBOutlet UIView *infoBGView;
@property (weak, nonatomic) IBOutlet UIView *buttonBGView;

@property (weak, nonatomic) IBOutlet UIImageView *orderImageView;
@property (weak, nonatomic) IBOutlet UILabel *orderIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderDateLabel;
@property (weak, nonatomic) IBOutlet RichPriceView *priceView;
@property (weak, nonatomic) IBOutlet UILabel *payTypeDescriptionLabel;

@property (weak, nonatomic) IBOutlet UIView *headerGap;
@property (weak, nonatomic) IBOutlet UIView *gapView;

@property (weak, nonatomic) IBOutlet UIButton *rightButton;

- (IBAction)didClickedRightButton:(id)sender;

@end

@implementation OrderListViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    
    self.orderImageView.layer.cornerRadius = 4;
    self.orderImageView.layer.masksToBounds = YES;
    
    [self.headerBGView setBackgroundColor:COLOR_BG_CEll];
    [self.infoBGView setBackgroundColor:COLOR_BG_CEll];
    [self.buttonBGView setBackgroundColor:COLOR_BG_CEll];
    
    [self.rightButton setBackgroundColor:COLOR_PINK forState:UIControlStateNormal];
    [self.rightButton setBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [self.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //price view
    [self.priceView setContentColor:COLOR_PINK];
    [self.priceView setUnitFont:[UIFont systemFontOfSize:15] priceFont:[UIFont systemFontOfSize:15]];
    [self.priceView setPrice:69.9];
    [self.priceView sizeToFitParameters];
    
    [ToolBox resetLineView:self.gapView withLayoutAttribute:NSLayoutAttributeHeight];
    [ToolBox resetLineView:self.headerGap withLayoutAttribute:NSLayoutAttributeHeight];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)configWithOrderListModel:(OrderListModel *)model atIndexPath:(NSIndexPath *)indexPath {
    if (model) {
        [self.orderImageView sd_setImageWithURL:model.imageUrl placeholderImage:PLACEHOLDERIMAGE_SMALL];
        [self.orderIdLabel setText:model.orderId];
        [self.orderStatusLabel setText:model.statusDescription];
        [self.orderNameLabel setText:model.orderName];
        [self.priceView setPrice:model.price];
        if ([model.pamentType.name length] > 0) {
            [self.payTypeDescriptionLabel setText:[NSString stringWithFormat:@"(%@)", model.pamentType.name]];
        }
        [self.orderDateLabel setText:model.orderDate];
        self.orderStatus = model.status;
        self.indexPath = indexPath;
        
        switch (model.status) {
            case OrderStatusWaitingPayment:
            {
                [self.rightButton setHidden:NO];
                [self.rightButton setTitle:@"付款" forState:UIControlStateNormal];
            }
                break;
            case OrderStatusAllUsed:
            {
                [self.rightButton setHidden:NO];
                [self.rightButton setTitle:@"评价" forState:UIControlStateNormal];
            }
                break;
            default:
            {
                [self.rightButton setHidden:YES];
            }
                break;
        }
    }
}

- (IBAction)didClickedRightButton:(id)sender {
    
    switch (self.orderStatus) {
        case OrderStatusWaitingPayment:
        {
            if (self.delegate && [self.delegate respondsToSelector:@selector(didClickedPayButtonOnOrderListViewCell:)]) {
                [self.delegate didClickedPayButtonOnOrderListViewCell:self];
            }
        }
            break;
        case OrderStatusHasPayed:
        {
            if (self.delegate && [self.delegate respondsToSelector:@selector(didClickedReturnButtonOnOrderListViewCell:)]) {
                [self.delegate didClickedReturnButtonOnOrderListViewCell:self];
            }
        }
            break;
        case OrderStatusAllUsed:
        {
            if (self.delegate && [self.delegate respondsToSelector:@selector(didClickedCommentButtonOnOrderListViewCell:)]) {
                [self.delegate didClickedCommentButtonOnOrderListViewCell:self];
            }
        }
            break;
        default:
            break;
    }
}

@end
