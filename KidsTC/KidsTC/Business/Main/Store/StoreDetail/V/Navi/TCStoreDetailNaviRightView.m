//
//  TCStoreDetailNaviRightView.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/23.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "TCStoreDetailNaviRightView.h"

@interface TCStoreDetailNaviRightView ()
@property (weak, nonatomic) IBOutlet UIButton *historyBtn;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@end

@implementation TCStoreDetailNaviRightView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.historyBtn.tag = TCStoreDetailNaviRightViewActionTypeHistory;
    self.moreBtn.tag = TCStoreDetailNaviRightViewActionTypeMore;
}
- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(tcStoreDetailNaviRightView:actionType:value:)]) {
        [self.delegate tcStoreDetailNaviRightView:self actionType:sender.tag value:nil];
    }
}

@end
