//
//  RecommendStoreCollectStoreHeader.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/22.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RecommendStoreCollectStoreHeader.h"

#import "Colours.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"
#import "NSString+Category.h"
#import "User.h"

@interface RecommendStoreCollectStoreHeader ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *numL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineOneH;
@property (weak, nonatomic) IBOutlet UIButton *collectBtn;
@property (weak, nonatomic) IBOutlet UIView *toCollectBgView;

@end

@implementation RecommendStoreCollectStoreHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    self.icon.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.icon.layer.borderWidth = LINE_H;
    
    self.collectBtn.layer.borderColor = [UIColor colorFromHexString:@"FF8888"].CGColor;
    self.collectBtn.layer.borderWidth = 1;
    self.collectBtn.layer.cornerRadius = 4;
    self.collectBtn.layer.masksToBounds = YES;
    
    self.lineOneH.constant = LINE_H;
    
    self.nameL.textColor = [UIColor colorFromHexString:@"333333"];
    self.numL.textColor = [UIColor colorFromHexString:@"888888"];
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tapGR];
    
}

- (void)setStore:(RecommendStore *)store {
    _store = store;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:store.storeImg] placeholderImage:PLACEHOLDERIMAGE_SMALL_LOG];
    self.nameL.text = store.storeName;
    self.numL.text = [NSString stringWithFormat:@"销量 %@  收藏 %@",store.saleNum,store.interestNum];
    [self setupInterestStatus];
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    if ([self.delegate respondsToSelector:@selector(recommendStoreCollectStoreHeader:actionType:value:)]) {
        [self.delegate recommendStoreCollectStoreHeader:self actionType:RecommendStoreCollectStoreHeaderActionTypeSegue value:self.store.segueModel];
    }
}

- (IBAction)action:(UIButton *)sender {
    [[User shareUser] checkLoginWithTarget:nil resultBlock:^(NSString *uid, NSError *error) {
        if ([self.delegate respondsToSelector:@selector(recommendStoreCollectStoreHeader:actionType:value:)]) {
            [self.delegate recommendStoreCollectStoreHeader:self actionType:RecommendStoreCollectStoreHeaderActionTypeCollect value:self.store];
        }
        _store.isInterest = !_store.isInterest;
        [self setupInterestStatus];
    }];
}

- (void)setupInterestStatus {
    if (_store.isInterest) {
        self.toCollectBgView.hidden = YES;
        self.collectBtn.layer.borderColor = [UIColor colorFromHexString:@"BBBBBB"].CGColor;
    }else{
        self.toCollectBgView.hidden = NO;
        self.collectBtn.layer.borderColor = [UIColor colorFromHexString:@"FF8888"].CGColor;
    }
}



@end
