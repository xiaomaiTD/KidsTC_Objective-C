//
//  CollectionTarentoFooter.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/15.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectionTarentoFooter.h"
#import "Colours.h"

@interface CollectionTarentoFooter ()
@property (weak, nonatomic) IBOutlet UIImageView *arrowIcon;
@property (weak, nonatomic) IBOutlet UILabel *numL;
@property (weak, nonatomic) IBOutlet UILabel *preL;
@property (weak, nonatomic) IBOutlet UILabel *subL;
@property (weak, nonatomic) IBOutlet UIView *marginView;
@end

@implementation CollectionTarentoFooter

- (void)awakeFromNib {
    [super awakeFromNib];
    self.numL.textColor = COLOR_PINK;
    self.preL.textColor = [UIColor colorFromHexString:@"999999"];
    self.subL.textColor = [UIColor colorFromHexString:@"999999"];
    self.marginView.backgroundColor = [UIColor colorFromHexString:@"F7F7F7"];
}

- (void)setItem:(CollectionTarentoItem *)item {
    _item = item;
    self.numL.text = _item.newsCount;
}

@end
