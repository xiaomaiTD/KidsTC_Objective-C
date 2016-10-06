//
//  TCProgressHUD.m
//  KidsTC
//
//  Created by zhanping on 8/20/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "TCProgressHUD.h"
#import "SVProgressHUD.h"

@interface TCProgressHUD ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, assign) BOOL isShowing;
@end

static TCProgressHUD *_progressHUD;
@implementation TCProgressHUD

+(TCProgressHUD *)shareProgressHUD {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _progressHUD = [[NSBundle mainBundle] loadNibNamed:@"TCProgressHUD" owner:self options:nil].firstObject;
        NSMutableArray<UIImage *> *images = [NSMutableArray array];
        NSUInteger count = 3;
        for (int i = 1; i<=count; i++) {
            NSString *imageName = [NSString stringWithFormat:@"loading_0%zd",i];
            UIImage *image = [UIImage imageNamed:imageName];
            [images addObject:image];
        }
        _progressHUD.imageView.animationImages = images;
        _progressHUD.imageView.animationDuration = count*0.2;
    });
    return _progressHUD;
}

+ (void)show {
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    if ([window isKeyWindow] == NO)
    {
        [window makeKeyWindow];
        [window makeKeyAndVisible];
    }
    [self showInView:window];
}

+(void)showInView:(UIView *)view{
    if ([TCProgressHUD shareProgressHUD].isShowing) return;
    [view layoutIfNeeded];
    [TCProgressHUD shareProgressHUD].frame = view.bounds;
    [view addSubview:[TCProgressHUD shareProgressHUD]];
    [TCProgressHUD shareProgressHUD].imageView.animationDuration = 3*0.2;
    [[TCProgressHUD shareProgressHUD].imageView startAnimating];
    [TCProgressHUD shareProgressHUD].isShowing = YES;
}

+ (void)dismiss {
    [[TCProgressHUD shareProgressHUD].imageView stopAnimating];
    [[TCProgressHUD shareProgressHUD] removeFromSuperview];
    [TCProgressHUD shareProgressHUD].isShowing = NO;
}

+ (void)showSVP {
    [SVProgressHUD setCornerRadius:8];
    [SVProgressHUD setRingThickness:1];
    [SVProgressHUD setRingRadius:20];
    [SVProgressHUD setRingNoTextRadius:20];
    [SVProgressHUD setMinimumSize:CGSizeMake(41, 41)];
    [SVProgressHUD show];
}

+ (void)dismissSVP {
    [SVProgressHUD dismiss];
}

@end
