//
//  NearbyTableViewHeaderItemView.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/1.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NearbyTableViewHeaderItemView.h"

@interface NearbyTableViewHeaderItemView ()
@property (nonatomic, weak) IBOutlet UIView *titleBGView;
@property (nonatomic, weak) IBOutlet UILabel *mainTitleL;
@property (nonatomic, weak) IBOutlet UILabel *subTitleL;
@property (nonatomic, weak) IBOutlet UIImageView *icon;
@property (nonatomic, weak) IBOutlet UIButton *btn;
@end

@implementation NearbyTableViewHeaderItemView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.cornerRadius = 4;
    self.layer.masksToBounds = YES;
}

- (IBAction)action:(UIButton *)sender{
    
}

@end
