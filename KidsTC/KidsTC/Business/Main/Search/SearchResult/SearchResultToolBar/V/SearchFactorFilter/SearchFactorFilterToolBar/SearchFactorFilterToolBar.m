
//
//  SearchFactorFilterToolBar.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/7.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchFactorFilterToolBar.h"
#import "Colours.h"

CGFloat const kSearchFactorFilterToolBarH = 56;
@interface SearchFactorFilterToolBar ()
@property (weak, nonatomic) IBOutlet UIButton *cleanBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@end

@implementation SearchFactorFilterToolBar

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.cleanBtn.layer.cornerRadius = 4;
    self.cleanBtn.layer.masksToBounds = YES;
    self.cleanBtn.layer.borderColor = [UIColor colorFromHexString:@"dedede"].CGColor;
    self.cleanBtn.layer.borderWidth = LINE_H;
    self.cleanBtn.tag = SearchFactorFilterToolBarActionTypeClean;
    
    self.sureBtn.layer.cornerRadius = 4;
    self.sureBtn.layer.masksToBounds = YES;
    self.sureBtn.tag = SearchFactorFilterToolBarActionTypeSure;
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(searchFactorFilterToolBar:actionType:value:)]) {
        [self.delegate searchFactorFilterToolBar:self actionType:(SearchFactorFilterToolBarActionType)sender.tag value:nil];
    }
}
@end
