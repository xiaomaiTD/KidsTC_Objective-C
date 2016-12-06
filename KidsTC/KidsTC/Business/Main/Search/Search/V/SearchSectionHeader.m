//
//  SearchSectionHeader.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/6.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchSectionHeader.h"

@interface SearchSectionHeader ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@end

@implementation SearchSectionHeader

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleL.text = title;
}

@end
