//
//  HomeTitleCellModel.h
//  KidsTC
//
//  Created by 钱烨 on 8/13/15.
//  Copyright (c) 2015 KidsTC. All rights reserved.
//

#import "HomeCellModel.h"
#import "SegueModel.h"

//typedef enum {
//    HomeTitleCellTypeNormalTitle = 1,
//    HomeTitleCellTypeMoreTitle,
//    HomeTitleCellTypeCountDownTitle,
//    HomeTitleCellTypeCountDownMoreTitle
//}HomeTitleCellType;

@interface HomeTitleCellModel : HomeCellModel

//@property (nonatomic, assign) HomeTitleCellType type;

@property (nonatomic, copy) NSString *mainTitle;

@property (nonatomic, strong) SegueModel *segueModel;

- (instancetype)initWithRawData:(NSDictionary *)data;

- (void)parseRawData:(NSDictionary *)data;

@end
