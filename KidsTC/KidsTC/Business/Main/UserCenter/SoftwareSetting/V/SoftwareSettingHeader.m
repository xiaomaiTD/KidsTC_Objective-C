//
//  SoftwareSettingHeader.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/7.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SoftwareSettingHeader.h"

@interface SoftwareSettingHeader ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation SoftwareSettingHeader

#ifdef DEBUG
#define DEBUGESTR @"-debug"
#else
#define DEBUGESTR @""
#endif

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    
    self.imageView.layer.cornerRadius = 8;
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.imageView.layer.borderWidth = LINE_H;
    
    self.imageView.image = [UIImage imageNamed:[self getAppIconName]];
    NSString *prodName = [[NSBundle mainBundle] infoDictionary][@"CFBundleDisplayName"];
    self.label.text = [NSString stringWithFormat:@"%@ v%@%@",prodName,APP_VERSION,DEBUGESTR];
}

- (NSString *)getAppIconName{
    
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    
    //获取app中所有icon名字数组
    NSArray *iconsArr = infoDict[@"CFBundleIcons"][@"CFBundlePrimaryIcon"][@"CFBundleIconFiles"];
    //取最后一个icon的名字
    NSString *iconLastName = nil;
    if (iconsArr.count>0) {
        iconLastName = [iconsArr lastObject];
    }
    return iconLastName;
}

@end
