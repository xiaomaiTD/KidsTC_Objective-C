//
//  SearchTableViewCell.h
//  KidsTC
//
//  Created by zhanping on 6/28/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SearchTableViewCell;
@protocol SearchTableViewCellDelegate <NSObject>
- (void)searchTableViewCell:(SearchTableViewCell *)searchTableViewCell didClickOnDelegateBtn:(NSUInteger)index;

@end

@interface SearchTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineLeadingConstraint;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UILabel *keywordsLabel;
@property (nonatomic, weak) id<SearchTableViewCellDelegate> delegate;
@end
