//
//  ProductDetailTicketInfoCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/7.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailTicketInfoCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"
#import "User.h"

@interface ProductDetailTicketInfoCell ()
@property (weak, nonatomic) IBOutlet UILabel *contentL;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UIImageView *bgIcon;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UIButton *starBtn;
@property (weak, nonatomic) IBOutlet UIImageView *loveImage;
@end

@implementation ProductDetailTicketInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.icon.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.icon.layer.borderWidth = 1;
    [self addCorner:self.likeBtn.layer];
    [self addCorner:self.starBtn.layer];
    self.likeBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.starBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.likeBtn.tag = ProductDetailBaseCellActionTypeTicketLike;
    self.starBtn.tag = ProductDetailBaseCellActionTypeTicketStar;
    
    [NotificationCenter addObserver:self selector:@selector(ticketLike) name:kProductDetaiTicketLike object:nil];
}

- (void)addCorner:(CALayer *)layer {
    layer.cornerRadius = 4;
    layer.masksToBounds = YES;
    layer.borderColor = [UIColor colorWithWhite:1 alpha:0.18].CGColor;
    layer.borderWidth = LINE_H;
}

- (IBAction)action:(UIButton *)sender {
    ProductDetailBaseCellActionType type = (ProductDetailBaseCellActionType)sender.tag;
    if ([self.delegate respondsToSelector:@selector(productDetailBaseCell:actionType:value:)]) {
        [self.delegate productDetailBaseCell:self actionType:type value:nil];
        if (type == ProductDetailBaseCellActionTypeTicketLike) {
            [[User shareUser] checkLoginWithTarget:nil resultBlock:^(NSString *uid, NSError *error) {
                self.data.isFavor = !self.data.isFavor;
                [NotificationCenter postNotificationName:kProductDetaiTicketLike object:nil];
            }];
        }
    }
}

- (void)setData:(ProductDetailData *)data {
    [super setData:data];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:data.img] placeholderImage:PLACEHOLDERIMAGE_BIG];
    [self.bgIcon sd_setImageWithURL:[NSURL URLWithString:data.img] placeholderImage:PLACEHOLDERIMAGE_BIG];
    self.contentL.attributedText = data.attTicketContent;
    [self setupLoveImg];
    [self layoutIfNeeded];
}

- (void)setupLoveImg {
    NSString *loveImgName = self.data.isFavor?@"ProductDetail_normalToolBar_love_y":@"ProductDetail_ticket_love_n";
    self.loveImage.image = [UIImage imageNamed:loveImgName];
}

- (void)ticketLike {
    [self setupLoveImg];
}

- (void)dealloc {
    [NotificationCenter removeObserver:self name:kProductDetaiTicketLike object:nil];
}

@end
