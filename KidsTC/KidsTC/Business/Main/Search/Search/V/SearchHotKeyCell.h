//
//  SearchHotKeyCell.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/6.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchRowItem.h"

@interface SearchHotKeyCell : UITableViewCell
@property (nonatomic, strong) SearchRowItem *rowItem;
@property (nonatomic, copy) void (^actionBlock)(SearchHotKeywordsItem *item);
@end
