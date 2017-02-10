//
//  TCStoreDetailHeaderCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/8.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "TCStoreDetailHeaderCell.h"
#import "FiveStarsView.h"
#import "UIImageView+WebCache.h"
#import "User.h"
#import "NSString+Category.h"

@interface TCStoreDetailHeaderCell ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImg;
@property (weak, nonatomic) IBOutlet UIImageView *logImg;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet FiveStarsView *starsView;
@property (weak, nonatomic) IBOutlet UIView *verifyBGView;

@property (weak, nonatomic) IBOutlet UIView *VLine;
@property (weak, nonatomic) IBOutlet UIImageView *verifyImg;
@property (weak, nonatomic) IBOutlet UIImageView *loveImg;
@property (weak, nonatomic) IBOutlet UILabel *loveL;
@property (weak, nonatomic) IBOutlet UIButton *loveBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgHeight;
@end

@implementation TCStoreDetailHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.logImg.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.logImg.layer.borderWidth = LINE_H;
    [NotificationCenter addObserver:self selector:@selector(setupLove) name:kTCStoreDetailCollect object:nil];
}

- (void)setData:(TCStoreDetailData *)data {
    [super setData:data];
    TCStoreDetailStoreBase *storeBase = data.storeBase;
    NSArray<NSString *> *narrowImg = storeBase.narrowImg;
    if (narrowImg.count>0) {
        NSString *bgImg = narrowImg.firstObject;
        [self.bgImg sd_setImageWithURL:[NSURL URLWithString:bgImg] placeholderImage:PLACEHOLDERIMAGE_BIG];
    }
    [self.logImg sd_setImageWithURL:[NSURL URLWithString:storeBase.logoImg] placeholderImage:PLACEHOLDERIMAGE_SMALL_LOG];
    self.verifyBGView.hidden = ![storeBase.verifyImg isNotNull];
    [self.verifyImg sd_setImageWithURL:[NSURL URLWithString:storeBase.verifyImg]];
    self.starsView.starNumber = storeBase.level;
    self.nameL.text = storeBase.storeName;
    
    self.bgHeight.constant = storeBase.picRate * SCREEN_WIDTH;
    
    [self setupLove];
    
    [self layoutIfNeeded];
}

- (void)setupLove {
    NSString *loveImgName = self.data.isFavor?@"StoreDetail_love_y":@"StoreDetail_love_n";
    self.loveImg.image = [UIImage imageNamed:loveImgName];
    self.loveL.text = self.data.isFavor?@"已收藏":@"收藏";
}

- (IBAction)action:(UIButton *)sender {
    [[User shareUser] checkLoginWithTarget:nil resultBlock:^(NSString *uid, NSError *error) {
        if ([self.delegate respondsToSelector:@selector(tcStoreDetailBaseCell:actionType:value:)]) {
            [self.delegate tcStoreDetailBaseCell:self actionType:TCStoreDetailBaseCellActionTypeCollect value:nil];
            self.data.isFavor = !self.data.isFavor;
            [self setupLove];
            [NotificationCenter postNotificationName:kTCStoreDetailCollect object:nil];
        }
    }];
}

- (void)dealloc {
    [NotificationCenter removeObserver:self name:kTCStoreDetailCollect object:nil];
}
@end
