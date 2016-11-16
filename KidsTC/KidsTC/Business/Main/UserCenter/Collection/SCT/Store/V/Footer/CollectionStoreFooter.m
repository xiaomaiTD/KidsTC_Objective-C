//
//  CollectionStoreFooter.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectionStoreFooter.h"

@interface CollectionStoreFooter ()
@property (weak, nonatomic) IBOutlet UIImageView *arrowIcon;
@property (weak, nonatomic) IBOutlet UILabel *numL;

@end

@implementation CollectionStoreFooter

- (void)awakeFromNib {
    [super awakeFromNib];
    self.numL.textColor = COLOR_PINK;
}

@end
