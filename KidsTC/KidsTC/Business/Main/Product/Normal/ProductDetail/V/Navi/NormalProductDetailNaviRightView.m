//
//  NormalProductDetailNaviRightView.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/23.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "NormalProductDetailNaviRightView.h"

@interface NormalProductDetailNaviRightView ()
@property (weak, nonatomic) IBOutlet UIButton *historyBtn;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;

@end

@implementation NormalProductDetailNaviRightView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.historyBtn.tag = NormalProductDetailNaviRightViewActionTypeHistory;
    self.moreBtn.tag = NormalProductDetailNaviRightViewActionTypeMore;
}
- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(normalProductDetailNaviRightView:actionType:value:)]) {
        [self.delegate normalProductDetailNaviRightView:self actionType:sender.tag value:nil];
    }
}

@end
