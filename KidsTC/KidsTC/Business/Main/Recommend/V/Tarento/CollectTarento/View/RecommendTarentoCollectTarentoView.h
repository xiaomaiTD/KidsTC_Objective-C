//
//  RecommendTarentoCollectTarentoView.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/22.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendTarento.h"

@interface RecommendTarentoCollectTarentoView : UIView
@property (nonatomic, strong) NSArray<RecommendTarento *> *tarentos;
- (void)reloadData;
- (CGFloat)contentHeight;
- (void)nilData;
@end
