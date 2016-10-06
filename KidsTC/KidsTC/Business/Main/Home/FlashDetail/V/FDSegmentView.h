//
//  FDToolBarView.h
//  KidsTC
//
//  Created by zhanping on 5/18/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef enum : NSUInteger {
    FDSegmentViewBtnType_ServeDetail,//服务详情
    FDSegmentViewBtnType_Store,//门店
    FDSegmentViewBtnType_Comment,//评论
} FDSegmentViewBtnType;

@class FDSegmentView;
@protocol FDSegmentViewDelegate <NSObject>
- (void)segmentView:(FDSegmentView *)segmentView didClickBtnType:(FDSegmentViewBtnType)type;
@end
@interface FDSegmentView : UIView
@property (nonatomic, weak) UIButton *selectedBtn;
@property (nonatomic, weak) id<FDSegmentViewDelegate> delegate;
@end
