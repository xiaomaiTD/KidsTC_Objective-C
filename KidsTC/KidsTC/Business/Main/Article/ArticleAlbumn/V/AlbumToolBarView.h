//
//  AlbumToolBarView.h
//  KidsTC
//
//  Created by zhanping on 6/2/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlbumnModel.h"

typedef enum : NSUInteger {
    AlbumToolBarViewBtnType_like=1,
    AlbumToolBarViewBtnType_comment
} AlbumToolBarViewBtnType;

@class AlbumToolBarView;
@protocol AlbumToolBarViewDelegate <NSObject>

- (void)albumToolBarView:(AlbumToolBarView *)toolBarView didClickOnBtnType:(AlbumToolBarViewBtnType)btnType;

@end

@interface AlbumToolBarView : UITableViewCell
@property (nonatomic, weak) ADArticleContent *articleContent;
@property (nonatomic, strong) NSAttributedString *content;
@property (nonatomic, weak) id<AlbumToolBarViewDelegate> delegate;
@end
