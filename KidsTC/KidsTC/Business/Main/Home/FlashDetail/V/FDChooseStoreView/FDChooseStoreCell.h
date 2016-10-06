//
//  FDChooseStoreCell.h
//  KidsTC
//
//  Created by zhanping on 5/21/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlashDetailModel.h"

@interface FDChooseStoreCell : UITableViewCell
- (void)configWithSotre:(FDStoreItem *)store isSelected:(BOOL)isSelected;
@end
