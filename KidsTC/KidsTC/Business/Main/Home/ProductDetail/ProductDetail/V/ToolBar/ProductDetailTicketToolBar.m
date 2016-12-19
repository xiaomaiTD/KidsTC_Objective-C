//
//  ProductDetailTicketToolBar.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/7.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailTicketToolBar.h"
#import "ProductDetailToolBarButton.h"
#import "User.h"
#import "UIButton+Category.h"

@interface ProductDetailTicketToolBar ()
@property (weak, nonatomic) IBOutlet ProductDetailToolBarButton *commentBtn;
@property (weak, nonatomic) IBOutlet ProductDetailToolBarButton *starBtn;
@property (weak, nonatomic) IBOutlet UIButton *selectSeatBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *VLineH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@end

@implementation ProductDetailTicketToolBar

- (void)awakeFromNib {
    [super awakeFromNib];
    self.VLineH.constant = LINE_H;
    self.HLineH.constant = LINE_H;
    [self.selectSeatBtn setBackgroundColor:COLOR_PINK forState:UIControlStateNormal];
    [self.selectSeatBtn setBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    self.commentBtn.tag = ProductDetailBaseToolBarActionTypeTicketToolBarComment;
    self.starBtn.tag = ProductDetailBaseToolBarActionTypeTicketToolBarStar;
    self.selectSeatBtn.tag = ProductDetailBaseToolBarActionTypeTicketToolBarSelectSeat;
    [self layoutIfNeeded];
    [NotificationCenter addObserver:self selector:@selector(ticketLike) name:kProductDetaiTicketLike object:nil];
}

- (void)setData:(ProductDetailData *)data {
    [super setData:data];
    self.starBtn.selected = data.isFavor;
    self.selectSeatBtn.enabled = data.isCanBuy;
    [self.selectSeatBtn setTitle:data.statusDesc forState:UIControlStateNormal];
}

- (IBAction)action:(UIButton *)sender {
    ProductDetailBaseToolBarActionType type = (ProductDetailBaseToolBarActionType)sender.tag;
    if ([self.delegate respondsToSelector:@selector(productDetailBaseToolBar:actionType:value:)]) {
        [self.delegate productDetailBaseToolBar:self actionType:type value:self.data];
        if (type == ProductDetailBaseToolBarActionTypeTicketToolBarStar) {
            [[User shareUser] checkLoginWithTarget:nil resultBlock:^(NSString *uid, NSError *error) {
                self.data.isFavor = !self.data.isFavor;
                [NotificationCenter postNotificationName:kProductDetaiTicketLike object:nil];
            }];
        }
    }
}

- (void)ticketLike {
    self.starBtn.selected = self.data.isFavor;
}

- (void)dealloc {
    [NotificationCenter removeObserver:self name:kProductDetaiTicketLike object:nil];
}

@end
