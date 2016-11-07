//
//  AccountCenterCollectionsCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/7.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "AccountCenterCollectionsCell.h"

@interface AccountCenterCollectionsCell ()
@property (weak, nonatomic) IBOutlet UIButton *productBtn;
@property (weak, nonatomic) IBOutlet UIButton *storeBtn;
@property (weak, nonatomic) IBOutlet UIButton *contentBtn;
@property (weak, nonatomic) IBOutlet UIButton *peopleBtn;

@property (weak, nonatomic) IBOutlet UILabel *productNumL;
@property (weak, nonatomic) IBOutlet UILabel *storeNumL;
@property (weak, nonatomic) IBOutlet UILabel *contentNumL;
@property (weak, nonatomic) IBOutlet UILabel *peopleNumL;

@end

@implementation AccountCenterCollectionsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.productBtn.tag = AccountCenterCellActionTypeCollectionProduct;
    self.storeBtn.tag = AccountCenterCellActionTypeCollectionStore;
    self.contentBtn.tag = AccountCenterCellActionTypeCollectionContent;
    self.peopleBtn.tag = AccountCenterCellActionTypeCollectionPeople;
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(accountCenterBaseCell:actionType:value:)]) {
        [self.delegate accountCenterBaseCell:self actionType:sender.tag value:nil];
    }
}


@end
