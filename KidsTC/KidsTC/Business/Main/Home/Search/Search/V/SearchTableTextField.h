//
//  SearchTableTextField.h
//  KidsTC
//
//  Created by 詹平 on 16/6/29.
//  Copyright © 2016年 KidsTC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchTypeItem.h"
@interface SearchTableTextField : UITextField
@property (nonatomic, copy) void (^didClickOnSearchTypeBtn) ();
@property (nonatomic, strong) SearchTypeItem *searchTypeItem;
@end
