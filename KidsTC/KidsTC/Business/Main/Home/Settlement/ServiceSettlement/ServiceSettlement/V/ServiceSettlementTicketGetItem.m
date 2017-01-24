//
//  ServiceSettlementTicketGetItem.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/24.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ServiceSettlementTicketGetItem.h"

@interface ServiceSettlementTicketGetItem ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@property (nonatomic, strong) UIImage *norImage;
@property (nonatomic, strong) UIImage *selImage;
@property (nonatomic, strong) UIColor *norCorlor;
@property (nonatomic, strong) UIColor *selCorlor;
@property (nonatomic, copy) void(^actionBlock)(ServiceSettlementTicketGetItem *item);
@end

@implementation ServiceSettlementTicketGetItem

+ (instancetype)itemWithTitle:(NSString *)title
                     norImage:(NSString *)norImage
                     selImage:(NSString *)selImage
                    norCorlor:(NSString *)norCorlor
                    selCorlor:(NSString *)selCorlor
                takeTicketWay:(ServiceSettlementTakeTicketWay)takeTicketWay
                  actionBlock:(void(^)(ServiceSettlementTicketGetItem *item))actionBlock
{
    ServiceSettlementTicketGetItem *item = [[NSBundle mainBundle] loadNibNamed:@"ServiceSettlementTicketGetItem" owner:self options:nil].firstObject;
    item.titleL.text = title;
    item.norImage = [UIImage imageNamed:norImage];
    item.selImage = [UIImage imageNamed:selImage];;
    item.norCorlor = [UIColor colorFromHexString:norCorlor];
    item.selCorlor = [UIColor colorFromHexString:selCorlor];
    item.takeTicketWay = takeTicketWay;
    item.actionBlock = actionBlock;
    item.select = NO;
    return item;
}

- (void)setSelect:(BOOL)select {
    _select = select;
    if (select) {
        self.imageView.image = self.selImage;
        self.titleL.textColor = self.selCorlor;
    }else{
        self.imageView.image = self.norImage;
        self.titleL.textColor = self.norCorlor;
    }
}

- (IBAction)action:(UIButton *)sender {
    if (self.actionBlock) self.actionBlock(self);
}

@end
