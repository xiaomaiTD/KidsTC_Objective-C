//
//  ArticleUserCenterTableHeaderView.h
//  KidsTC
//
//  Created by zhanping on 2016/9/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleHomeUserInfoModel.h"

extern CGFloat const kArticleUserCenterTableHeaderViewRatio;

@interface ArticleUserCenterTableHeaderView : UIView
@property (nonatomic, strong) ArticleHomeUserInfoData *data;
@end
