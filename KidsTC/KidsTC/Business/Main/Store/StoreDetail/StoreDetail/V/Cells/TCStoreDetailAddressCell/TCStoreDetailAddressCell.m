//
//  TCStoreDetailAddressCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/8.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "TCStoreDetailAddressCell.h"
#import "NSString+Category.h"

@interface TCStoreDetailAddressCell ()
@property (weak, nonatomic) IBOutlet UILabel *addressL;
@property (weak, nonatomic) IBOutlet UIView *VLine;
@property (weak, nonatomic) IBOutlet UIView *phoneBGView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addressLRightMargin;

@end

@implementation TCStoreDetailAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setData:(TCStoreDetailData *)data {
    [super setData:data];
    TCStoreDetailStoreBase *storeBase = data.storeBase;
    self.addressL.text = storeBase.address;
    
    if (storeBase.phones.count>0) {
        self.addressLRightMargin.constant = 69;
        self.VLine.hidden = NO;
        self.phoneBGView.hidden = NO;
        
    }else{
        self.addressLRightMargin.constant = 15;
        self.VLine.hidden = YES;
        self.phoneBGView.hidden = YES;
        
    }
    [self layoutIfNeeded];
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(tcStoreDetailBaseCell:actionType:value:)]) {
        [self.delegate tcStoreDetailBaseCell:self actionType:TCStoreDetailBaseCellActionTypePhone value:nil];
    }
}
@end
