//
//  ArticleWriteBottomView.m
//  KidsTC
//
//  Created by zhanping on 9/8/16.
//  Copyright © 2016 zhanping. All rights reserved.
//

#import "ArticleWriteBottomView.h"

@interface ArticleWriteBottomView ()
@property (weak, nonatomic) IBOutlet UIButton *pictureBtn;
@property (weak, nonatomic) IBOutlet UIButton *previewBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstraintHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *VLineConstraintHeight;
@end

@implementation ArticleWriteBottomView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.pictureBtn.tag = ArticleWriteBottomViewActionTypePicture;
    self.previewBtn.tag = ArticleWriteBottomViewActionTypePreview;
    
    self.HLineConstraintHeight.constant = LINE_H;
    self.VLineConstraintHeight.constant = LINE_H;
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(articleWriteBottomView:actionType:)]) {
        [self.delegate articleWriteBottomView:self actionType:(ArticleWriteBottomViewActionType)sender.tag];
    }
}


@end
