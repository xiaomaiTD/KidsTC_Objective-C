//
//  ArticleWriteAlertSuccessResultViewController.h
//  KidsTC
//
//  Created by zhanping on 2016/9/13.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ViewController.h"

typedef enum : NSUInteger {
    ArticleWriteAlertSuccessResultBtnTypeWriteMore=1,
    ArticleWriteAlertSuccessResultBtnTypeShare,
    ArticleWriteAlertSuccessResultBtnTypeMakeSure,
} ArticleWriteAlertSuccessResultBtnType;

@class ArticleWriteAlertSuccessResultViewController;
@protocol ArticleWriteAlertSuccessResultViewControllerDelegate <NSObject>
- (void)articleWriteAlertSuccessResultViewController:(ArticleWriteAlertSuccessResultViewController *)controller actionType:(ArticleWriteAlertSuccessResultBtnType)type;
@end

@interface ArticleWriteAlertSuccessResultViewController : ViewController
@property (nonatomic, weak) id<ArticleWriteAlertSuccessResultViewControllerDelegate> delegate;
@end
