//
//  SearchFactorFilterAgeView.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/6.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchFactorFilterAgeItem.h"
@interface SearchFactorFilterAgeView : UIView
@property (nonatomic, weak) SearchFactorFilterAgeItem *cellSelectedItem;
@property (nonatomic, weak) NSDictionary *insetParam;
- (CGFloat)contentHeight;
- (void)clean;
- (void)sure;
- (void)reset;
@end
