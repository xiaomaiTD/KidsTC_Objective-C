//
//  HomeBaseCell.h
//  KidsTC
//
//  Created by ling on 16/7/19.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeFloorsItem;
@interface HomeBaseCell : UITableViewCell

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) HomeFloorsItem *floorsItem;
@property (nonatomic, weak) id delegate;

@property (nonatomic, assign) NSUInteger sectionNo;
@end
