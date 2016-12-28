//
//  WholesaleOrderDetailProgressCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WholesaleOrderDetailProgressCell.h"
#import "WholesaleOrderDetailProgressItemView.h"

@interface WholesaleOrderDetailProgressCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@property (strong, nonatomic) IBOutletCollection(WholesaleOrderDetailProgressItemView) NSArray *stepItems;

@end

@implementation WholesaleOrderDetailProgressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineH.constant = LINE_H;
}

- (void)setData:(WholesaleOrderDetailData *)data {
    [super setData:data];
    [self.stepItems enumerateObjectsUsingBlock:^(WholesaleOrderDetailProgressItemView *obj, NSUInteger idx, BOOL *stop) {
        obj.selected = (obj.tag == data.openGroupStep);
    }];
    
}

@end
