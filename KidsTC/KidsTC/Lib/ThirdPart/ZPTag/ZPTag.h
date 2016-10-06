//
//  ZPTag.h
//  ImageLabel
//
//  Created by 詹平 on 16/4/2.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZPTagDirectionByInput) {//标签箭头方向(用户手动设置的标签方向),如果为Unknown则根据位置自动判断箭头的方向
    ZPTagDirectionByInputUnkonwn,                  //未知
    ZPTagDirectionByInputRight,                    //向右
    ZPTagDirectionByInputLeft                      //向左
    
};
typedef NS_ENUM(NSInteger, ZPTagUserInteractionMode) {//标签用户交互模式
    ZPTagUserInteractionModeClick,                    //点击模式，只能响应用户的点击，不能拖动、删除。(默认开启)
    ZPTagUserInteractionModeEdit,                     //编辑模式，可以响应用户的拖动、删除、点击，第一次添加时若没设置文字或文字为空自动触发点击事件。
    ZPTagUserInteractionModeClose                     //关闭模式，关闭与用户的交互。
};
@class ZPTag;
@protocol ZPTagDelegate <NSObject>
@required
- (void)didClickTag:(ZPTag *)tag;
@end
extern NSString *const kZPTagViewWillAppearNotification;//当显示的时候通知

@interface ZPTag : UIView
@property (nonatomic, copy) NSString *title;//标签标题
@property (nonatomic, assign, readonly) CGPoint targetPointLocationInSuperview;//动画园中心点在父视图中的坐标
@property (nonatomic, assign) ZPTagDirectionByInput tagDirectionByInput;//标签箭头方向 (用户手动设置的标签方向)
@property (nonatomic, assign) ZPTagUserInteractionMode tagUserInteractionMode;//标签编辑模式状态 (默认开启)
@property (nonatomic, weak) id<ZPTagDelegate> delegate;

/**
 *  创建标签
 *
 *  @param originPoint 在父视图中点击的位置
 *
 */
+(instancetype)CreatTagWithOriginPoint:(CGPoint)originPoint;

@end
