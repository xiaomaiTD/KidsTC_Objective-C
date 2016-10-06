//
//  FDServeDetailCell.h
//  KidsTC
//
//  Created by zhanping on 5/19/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDServeDetailCell : UITableViewCell
@property (nonatomic, strong) NSString *urlString;
@property (nonatomic, copy) void (^didFinishLoadingBlock) (CGFloat webHight);
@end
