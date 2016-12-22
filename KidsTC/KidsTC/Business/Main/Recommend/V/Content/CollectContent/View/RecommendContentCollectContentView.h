//
//  RecommendContentCollectContentView.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/22.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleHomeModel.h"

@interface RecommendContentCollectContentView : UIView
@property (nonatomic, strong) NSArray<ArticleHomeItem *> *contents;
- (void)reloadData;
- (CGFloat)contentHeight;
- (void)nilData;
@end
