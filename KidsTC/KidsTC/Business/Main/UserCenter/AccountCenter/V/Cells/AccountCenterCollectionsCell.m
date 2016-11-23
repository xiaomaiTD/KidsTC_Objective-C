//
//  AccountCenterCollectionsCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/7.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "AccountCenterCollectionsCell.h"
#import "Colours.h"

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
    
    [self setBtnColor:self.productBtn];
    [self setBtnColor:self.storeBtn];
    [self setBtnColor:self.contentBtn];
    [self setBtnColor:self.peopleBtn];
    
    [self setLabelColor:self.productNumL];
    [self setLabelColor:self.storeNumL];
    [self setLabelColor:self.contentNumL];
    [self setLabelColor:self.peopleNumL];
}

- (void)setBtnColor:(UIButton *)btn {
    [btn setTitleColor:[UIColor colorFromHexString:@"444444"] forState:UIControlStateNormal];
}

- (void)setLabelColor:(UILabel *)label {
    label.textColor = [UIColor colorFromHexString:@"222222"];
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(accountCenterBaseCell:actionType:value:)]) {
        [self.delegate accountCenterBaseCell:self actionType:sender.tag value:nil];
    }
}

- (void)setModel:(AccountCenterModel *)model {
    [super setModel:model];
    AccountCenterUserCount *userCount = model.data.userCount;
    self.productNumL.text = [NSString stringWithFormat:@"%zd",userCount.product_collect_num];
    self.storeNumL.text = [NSString stringWithFormat:@"%zd",userCount.store_collect_num];
    self.contentNumL.text = [NSString stringWithFormat:@"%zd",userCount.like_content_num];
    self.peopleNumL.text = [NSString stringWithFormat:@"%zd",userCount.like_author_num];
}


@end
