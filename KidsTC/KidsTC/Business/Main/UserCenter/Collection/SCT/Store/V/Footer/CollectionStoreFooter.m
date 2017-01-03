//
//  CollectionStoreFooter.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectionStoreFooter.h"
#import "Colours.h"

@interface CollectionStoreFooter ()
@property (weak, nonatomic) IBOutlet UIImageView *arrowIcon;
@property (weak, nonatomic) IBOutlet UILabel *numL;
@property (weak, nonatomic) IBOutlet UILabel *preL;
@property (weak, nonatomic) IBOutlet UILabel *subL;
@property (weak, nonatomic) IBOutlet UIView *marginView;

@end

@implementation CollectionStoreFooter

- (void)awakeFromNib {
    [super awakeFromNib];
    self.numL.textColor = COLOR_PINK;
    self.preL.textColor = [UIColor colorFromHexString:@"999999"];
    self.subL.textColor = [UIColor colorFromHexString:@"999999"];
    self.marginView.backgroundColor = [UIColor colorFromHexString:@"EEEEEE"];
}

- (IBAction)action:(UIButton *)sender {
    if (self.actionBlock) {
        self.actionBlock(_item);
    }
}

- (void)setItem:(CollectionStoreItem *)item {
    _item = item;
    self.numL.text = [NSString stringWithFormat:@"%zd",item.newsCount];
}

@end
