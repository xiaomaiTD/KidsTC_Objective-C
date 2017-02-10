//
//  TCStoreDetailToolBar.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/8.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "TCStoreDetailToolBar.h"
#import "User.h"

CGFloat const kTCStoreDetailToolBarH = 49;

@interface TCStoreDetailToolBar ()
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UIButton *appoimentBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *VLineH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *VLineHTwo;

@property (weak, nonatomic) IBOutlet UIImageView *likeImg;
@property (weak, nonatomic) IBOutlet UILabel *likeL;

@property (weak, nonatomic) IBOutlet UIImageView *appoimentImg;
@property (weak, nonatomic) IBOutlet UILabel *appoimentL;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;

@end

@implementation TCStoreDetailToolBar

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.VLineH.constant = LINE_H;
    self.VLineHTwo.constant = LINE_H;
    self.HLineH.constant = LINE_H;

    self.likeBtn.tag = TCStoreDetailToolBarActionTypeLike;
    self.commentBtn.tag = TCStoreDetailToolBarActionTypeWrite;
    self.appoimentBtn.tag = TCStoreDetailToolBarActionTypeAppoiment;
    
    [NotificationCenter addObserver:self selector:@selector(setupLike) name:kTCStoreDetailCollect object:nil];
}

- (void)setData:(TCStoreDetailData *)data {
    _data = data;
    self.hidden = _data==nil;
    [self setupLike];
    [self setupStatus];
}

- (void)setupLike {
    NSString *likeImgName = nil;
    NSString *liekTitle = nil;
    NSString *liekTitleColor = nil;
    if (self.data.isFavor) {
        likeImgName = @"StoreDetail_like_y";
        liekTitle = @"已赞";
        liekTitleColor = @"ff8888";
    }else{
        likeImgName = @"StoreDetail_like_n";
        liekTitle = @"赞";
        liekTitleColor = @"666666";
    }
    self.likeImg.image = [UIImage imageNamed:likeImgName];
    self.likeL.text = liekTitle;
    self.likeL.textColor = [UIColor colorFromHexString:liekTitleColor];
}

- (void)setupStatus {
    
    NSString *appoimentImgName = nil;
    NSString *appoimentTitleColor = nil;
    BOOL btnEnable = NO;
    if (self.data.storeBase.status == 1) {
        appoimentImgName = @"StoreDetail_appoiment_y";
        appoimentTitleColor = @"666666";
        btnEnable = YES;
    }else{
        appoimentImgName = @"StoreDetail_appoiment_n";
        appoimentTitleColor = @"cccccc";
        btnEnable = NO;
    }
    self.appoimentImg.image = [UIImage imageNamed:appoimentImgName];
    self.appoimentL.textColor = [UIColor colorFromHexString:appoimentTitleColor];
    self.appoimentBtn.enabled = btnEnable;
}

- (IBAction)action:(UIButton *)sender {
    TCStoreDetailToolBarActionType type = (TCStoreDetailToolBarActionType)sender.tag;
    if ([self.delegate respondsToSelector:@selector(tcStoreDetailToolBar:actionType:value:)]) {
        if (type == TCStoreDetailToolBarActionTypeLike) {
            [[User shareUser] checkLoginWithTarget:nil resultBlock:^(NSString *uid, NSError *error) {
                [self.delegate tcStoreDetailToolBar:self actionType:type value:nil];
                self.data.isFavor = !self.data.isFavor;
                [self setupLike];
                [NotificationCenter postNotificationName:kTCStoreDetailCollect object:nil];
            }];
        }else{
            [self.delegate tcStoreDetailToolBar:self actionType:type value:nil];
        }
    }
}

- (void)dealloc {
    [NotificationCenter removeObserver:self name:kTCStoreDetailCollect object:nil];
}

@end
