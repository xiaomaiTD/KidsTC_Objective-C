//
//  ProductDetailAddressCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailAddressCell.h"

@interface ProductDetailAddressCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *addressL;
@end

@implementation ProductDetailAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setData:(ProductDetailData *)data {
    [super setData:data];
    if (data.store.count>0) {
        ProductDetailStore *store = data.store.firstObject;
        self.nameL.text = store.storeName;
        self.addressL.text = store.address;
    }
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    
}

@end
