//
//  SearchHotKeyCollectionCell.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/6.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchHotKeywordsItem.h"

@interface SearchHotKeyCollectionCell : UICollectionViewCell
@property (nonatomic, strong) SearchHotKeywordsItem *item;
@property (nonatomic, copy) void (^actionBlock)(SearchHotKeywordsItem *item);
@end
