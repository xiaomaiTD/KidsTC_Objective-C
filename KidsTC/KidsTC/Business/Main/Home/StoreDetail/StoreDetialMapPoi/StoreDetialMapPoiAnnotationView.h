//
//  StoreDetialMapPoiAnnotationView.h
//  KidsTC
//
//  Created by zhanping on 8/3/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTCLocation.h"
@class StoreDetialMapPoiAnnotationView;
@protocol StoreDetialMapPoiAnnotationViewDelegate <NSObject>
- (void)storeDetialMapPoiAnnotationViewDidClickGotoBtn:(StoreDetialMapPoiAnnotationView *)view ;
@end
@protocol BMKAnnotation;
@interface StoreDetialMapPoiAnnotationView : UITableViewCell
@property (nonatomic, strong) KTCLocation *item;
@property (nonatomic, weak) id<StoreDetialMapPoiAnnotationViewDelegate> delegate;
@property (nonatomic, assign) id<BMKAnnotation> annotation;
@end
