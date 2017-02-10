//
//  TCStoreDetailCommentTitleCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/8.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "TCStoreDetailCommentTitleCell.h"

@interface TCStoreDetailCommentTitleCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@property (weak, nonatomic) IBOutlet UIView *countBGView;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImg;
@property (weak, nonatomic) IBOutlet UILabel *countL;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@end

@implementation TCStoreDetailCommentTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineH.constant = LINE_H;
}

- (void)setData:(TCStoreDetailData *)data {
    [super setData:data];
    self.countL.text = [NSString stringWithFormat:@"%zd",data.evaluate];
    if (data.evaluate<1) {
        self.countBGView.hidden = YES;
        self.arrowImg.hidden = YES;
        self.btn.enabled = NO;
    }else{
        self.countBGView.hidden = NO;
        self.arrowImg.hidden = NO;
        self.btn.enabled = YES;
    }
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(tcStoreDetailBaseCell:actionType:value:)]) {
        [self.delegate tcStoreDetailBaseCell:self actionType:TCStoreDetailBaseCellActionTypeCommentMore value:nil];
    }
}


@end
