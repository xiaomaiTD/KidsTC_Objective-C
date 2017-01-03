//
//  RecommendStoreCollectStoreFooter.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/22.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RecommendStoreCollectStoreFooter.h"

@interface RecommendStoreCollectStoreFooter ()
@property (weak, nonatomic) IBOutlet UIImageView *arrowIcon;
@property (weak, nonatomic) IBOutlet UILabel *numL;
@property (weak, nonatomic) IBOutlet UILabel *preL;
@property (weak, nonatomic) IBOutlet UILabel *subL;
@property (weak, nonatomic) IBOutlet UIView *marginView;

@end

@implementation RecommendStoreCollectStoreFooter

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setNeedsLayout];
    [self layoutIfNeeded];
    self.numL.textColor = COLOR_PINK;
    self.preL.textColor = [UIColor colorFromHexString:@"999999"];
    self.subL.textColor = [UIColor colorFromHexString:@"999999"];
    self.marginView.backgroundColor = [UIColor colorFromHexString:@"EEEEEE"];
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(recommendStoreCollectStoreFooter:actionType:value:)]) {
        [self.delegate recommendStoreCollectStoreFooter:self actionType:RecommendStoreCollectStoreFooterActionTypeSegue value:_store.segueModel];
    }
}

- (void)setStore:(RecommendStore *)store {
    _store = store;
    self.numL.text = [NSString stringWithFormat:@"%zd",store.newsCount];
    [self layoutIfNeeded];
}

@end
