//
//  SearchFactorFilterCategoryView.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/7.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchFactorFilterCategoryItemLeft.h"

@interface SearchFactorFilterCategoryView : UIView
@property (nonatomic, weak) SearchFactorFilterCategoryItemLeft *cellSelectedItemLeft;
@property (nonatomic, weak) SearchFactorFilterCategoryItemRight *cellSelectedItemRight;
@property (nonatomic, weak) NSDictionary *insetParam;
- (CGFloat)contentHeight;
- (void)clean;
- (void)sure;
- (void)reset;
@end
