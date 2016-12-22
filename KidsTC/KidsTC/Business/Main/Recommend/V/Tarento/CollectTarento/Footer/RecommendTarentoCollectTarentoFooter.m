//
//  RecommendTarentoCollectTarentoFooter.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/22.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RecommendTarentoCollectTarentoFooter.h"

@interface RecommendTarentoCollectTarentoFooter ()
@property (weak, nonatomic) IBOutlet UIImageView *arrowIcon;
@property (weak, nonatomic) IBOutlet UILabel *numL;
@property (weak, nonatomic) IBOutlet UILabel *preL;
@property (weak, nonatomic) IBOutlet UILabel *subL;
@property (weak, nonatomic) IBOutlet UIView *marginView;
@end

@implementation RecommendTarentoCollectTarentoFooter

- (void)awakeFromNib {
    [super awakeFromNib];
    self.numL.textColor = COLOR_PINK;
    self.preL.textColor = [UIColor colorFromHexString:@"999999"];
    self.subL.textColor = [UIColor colorFromHexString:@"999999"];
    self.marginView.backgroundColor = [UIColor colorFromHexString:@"EEEEEE"];
}

- (IBAction)action:(UIButton *)sender {
    
}

@end
