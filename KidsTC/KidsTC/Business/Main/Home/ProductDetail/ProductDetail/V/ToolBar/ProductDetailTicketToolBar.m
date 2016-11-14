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

@interface ProductDetailTicketToolBar ()
@property (weak, nonatomic) IBOutlet ProductDetailToolBarButton *commentBtn;
@property (weak, nonatomic) IBOutlet ProductDetailToolBarButton *starBtn;
@property (weak, nonatomic) IBOutlet UIButton *selectSeatBtn;
@end

@implementation ProductDetailTicketToolBar

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectSeatBtn.backgroundColor = COLOR_PINK;
    self.commentBtn.tag = ProductDetailBaseToolBarActionTypeTicketToolBarComment;
    self.starBtn.tag = ProductDetailBaseToolBarActionTypeTicketToolBarStar;
    self.selectSeatBtn.tag = ProductDetailBaseToolBarActionTypeTicketToolBarSelectSeat;
}

- (void)setData:(ProductDetailData *)data {
    [super setData:data];
    self.starBtn.selected = data.isFavor;
}

- (IBAction)action:(UIButton *)sender {
    ProductDetailBaseToolBarActionType type = (ProductDetailBaseToolBarActionType)sender.tag;
    if ([self.delegate respondsToSelector:@selector(productDetailBaseToolBar:actionType:value:)]) {
        [self.delegate productDetailBaseToolBar:self actionType:type value:self.data];
        if (type == ProductDetailBaseToolBarActionTypeTicketToolBarStar) {
            [[User shareUser] checkLoginWithTarget:nil resultBlock:^(NSString *uid, NSError *error) {
                self.data.isFavor = !self.data.isFavor;
                self.starBtn.selected = self.data.isFavor;
            }];
        }
    }
}

@end
