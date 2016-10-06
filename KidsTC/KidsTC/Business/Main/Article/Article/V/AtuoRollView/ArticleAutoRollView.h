//
//  AutoRollView.h
//  AutoRollViewController
//
//  Created by 平 on 15/12/12.
//  Copyright © 2015年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ArticleAutoRollCell.h"
@protocol ArticleAutoRollViewDelegate<NSObject>
-(void)didSelectPageAtIndex:(NSUInteger)index;
@end
@interface ArticleAutoRollView : UIView
@property (nonatomic,strong)NSArray *items;
@property (nonatomic,weak)id<ArticleAutoRollViewDelegate> delegate;
@property (nonatomic, assign) BOOL isBannerHaveInset; //Banner是否有内边距
-(instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items delegate:(id<ArticleAutoRollViewDelegate>)delegate isBannerHaveInset:(BOOL)isBannerHaveInset;
-(void)setCollectionViewFrame:(CGRect)frame;
@end
