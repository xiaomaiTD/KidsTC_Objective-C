//
//  SettlementResultNewCollectionHeader.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SettlementResultNewCollectionHeader.h"
#import "NSString+Category.h"

@interface SettlementResultNewCollectionHeader ()
@property (weak, nonatomic) IBOutlet UIButton *goHomeBtn;
@property (weak, nonatomic) IBOutlet UIButton *showDetailBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UILabel *tipL;
@end

@implementation SettlementResultNewCollectionHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    [self addCorner:self.goHomeBtn.layer];
    [self addCorner:self.showDetailBtn.layer];
}

- (void)addCorner:(CALayer *)layer {
    layer.cornerRadius = 4;
    layer.masksToBounds = YES;
    layer.borderColor = [UIColor lightGrayColor].CGColor;
    layer.borderWidth = 1;
}

- (void)setData:(ProductDetailData *)data {
    _data = data;
    NSString *name = data.serveName;
    if ([name isNotNull]) {
        name = [NSString stringWithFormat:@"活动名称：%@",name];
    }else{
        name = nil;
    }
    self.nameL.text = name;
    
    NSString *timeDesc = data.time.desc;
    if ([timeDesc isNotNull]) {
        timeDesc = [NSString stringWithFormat:@"活动时间：%@",timeDesc];
    }else{
        timeDesc = nil;
    }
    self.timeL.text = timeDesc;
    
    NSString *advance = data.onlineBespeak.advanceDayDesc;
    if ([advance isNotNull]) {
        advance = [NSString stringWithFormat:@"温馨提示：%@",advance];
    }else{
        advance = nil;
    }
    self.tipL.text = advance;
}

- (IBAction)goHome:(id)sender {
    if ([self.delegate respondsToSelector:@selector(settlementResultNewCollectionHeader:actionType:value:)]) {
        [self.delegate settlementResultNewCollectionHeader:self actionType:SettlementResultNewCollectionHeaderActionTypeHome value:nil];
    }
}
- (IBAction)showDetail:(id)sender {
    if ([self.delegate respondsToSelector:@selector(settlementResultNewCollectionHeader:actionType:value:)]) {
        [self.delegate settlementResultNewCollectionHeader:self actionType:SettlementResultNewCollectionHeaderActionTypeDetail value:nil];
    }
}

@end
