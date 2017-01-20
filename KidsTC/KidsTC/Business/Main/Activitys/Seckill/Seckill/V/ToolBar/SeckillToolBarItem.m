//
//  SeckillToolBarItem.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/10.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "SeckillToolBarItem.h"

@interface SeckillToolBarItem ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@end

@implementation SeckillToolBarItem

- (void)setItem:(SeckillTimeToolBarItem *)item {
    _item = item;
    self.icon.image = [UIImage imageNamed:item.img];
    self.titleL.text = item.title;
}
- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didClickSeckillToolBarItem:)]) {
        [self.delegate didClickSeckillToolBarItem:self];
    }
}

@end
