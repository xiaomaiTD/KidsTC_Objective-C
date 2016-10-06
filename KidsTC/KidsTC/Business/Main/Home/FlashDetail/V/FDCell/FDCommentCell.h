//
//  FDCommentCell.h
//  KidsTC
//
//  Created by zhanping on 5/19/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDCommentLayout.h"

@interface FDImageContainer : UIView
@end

@interface FDCommentCell : UITableViewCell
@property (nonatomic, weak) FDCommentLayout *layout;
@end
