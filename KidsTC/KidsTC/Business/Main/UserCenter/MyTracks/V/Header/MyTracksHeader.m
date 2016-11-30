//
//  MyTracksHeader.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/15.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "MyTracksHeader.h"

@interface MyTracksHeader ()
@property (weak, nonatomic) IBOutlet UILabel *timeL;

@end

@implementation MyTracksHeader

- (void)setItem:(MyTracksDateItem *)item {
    _item = item;
    self.timeL.text = _item.timeDesc;
}

@end
