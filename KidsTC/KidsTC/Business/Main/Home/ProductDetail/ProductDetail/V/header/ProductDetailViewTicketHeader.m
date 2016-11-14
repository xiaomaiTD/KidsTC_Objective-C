//
//  ProductDetailViewTicketHeader.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/11.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailViewTicketHeader.h"
#import "User.h"

@interface ProductDetailViewTicketHeader ()
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *infoL;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UIImageView *bgIcon;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UIButton *starBtn;
@end

@implementation ProductDetailViewTicketHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.priceL.textColor = COLOR_PINK;
    [self addCorner:self.likeBtn.layer];
    [self addCorner:self.starBtn.layer];
    self.likeBtn.tag = ProductDetailViewBaseHeaderActionTypeTicketLike;
    self.starBtn.tag = ProductDetailViewBaseHeaderActionTypeTicketStar;
}

- (void)addCorner:(CALayer *)layer {
    layer.cornerRadius = 4;
    layer.masksToBounds = YES;
    layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    layer.borderWidth = LINE_H;
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(productDetailViewBaseHeader:actionType:value:)]) {
        [self.delegate productDetailViewBaseHeader:self actionType:sender.tag value:nil];
        if (sender.tag == ProductDetailViewBaseHeaderActionTypeTicketLike) {
            [[User shareUser] checkLoginWithTarget:nil resultBlock:^(NSString *uid, NSError *error) {
                self.data.isFavor = !self.data.isFavor;
                self.starBtn.selected = self.data.isFavor;
            }];
        }
    }
}

- (void)setData:(ProductDetailData *)data {
    [super setData:data];
    self.likeBtn.selected =  data.isFavor;
}

@end
