//
//  SearchTableViewCell.m
//  KidsTC
//
//  Created by zhanping on 6/28/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "SearchTableViewCell.h"

@implementation SearchTableViewCell

- (IBAction)deleteActon:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(searchTableViewCell:didClickOnDelegateBtn:)]) {
        [self.delegate searchTableViewCell:self didClickOnDelegateBtn:sender.tag];
    }
    
}


@end
