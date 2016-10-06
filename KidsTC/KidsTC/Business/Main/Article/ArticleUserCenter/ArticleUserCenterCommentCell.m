//
//  ArticleUserCenterCommentCell.m
//  KidsTC
//
//  Created by zhanping on 2016/9/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ArticleUserCenterCommentCell.h"
#import "ArticleUserCenterCommentCollectionViewCell.h"

/**
 @property (nonatomic, strong) NSString *articleSysNo;
 @property (nonatomic, strong) NSString *articleTitle;
 @property (nonatomic, assign) SegueDestination linkType;
 @property (nonatomic, strong) NSDictionary *params;
 @property (nonatomic, strong) NSString *reply;
 @property (nonatomic, strong) NSString *commentSysNo;
 @property (nonatomic, strong) NSString *userId;
 @property (nonatomic, strong) NSString *userName;
 @property (nonatomic, strong) NSString *userHeadImg;
 @property (nonatomic, strong) NSString *content;
 @property (nonatomic, strong) NSArray *imgUrls;
 @property (nonatomic, assign) BOOL isReplyed;
 @property (nonatomic, assign) BOOL isPraised;
 @property (nonatomic, assign) NSUInteger praiseCount;
 */

static int kCollectionViewCellHeight = 80;

static NSString *const ArticleUserCenterCommentCollectionViewCellID = @"ArticleUserCenterCommentCollectionViewCellID";

@interface ArticleUserCenterCommentCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *contentBGView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *praiseCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *praiseBtn;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewConstraintHeight;

@property (weak, nonatomic) IBOutlet UIView *titleBGView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@property (weak, nonatomic) IBOutlet UIView *HLine;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstraintHeight;

@end

@implementation ArticleUserCenterCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _HLine.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
    _HLineConstraintHeight.constant = LINE_H;
    
    UIView *selectedBackgroundView = [[UIView alloc]init];
    selectedBackgroundView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4];
    self.selectedBackgroundView = selectedBackgroundView;

    [_collectionView registerNib:[UINib nibWithNibName:@"ArticleUserCenterCommentCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ArticleUserCenterCommentCollectionViewCellID];
}

- (void)setItem:(ArticleUserCenterCommentItem *)item {
    _item = item;
    
    _contentLabel.attributedText = item.contentAttStr;
    _praiseCountLabel.text = [NSString stringWithFormat:@"%zd",item.praiseCount];
    _praiseBtn.selected = item.isPraised;
    
    _collectionViewConstraintHeight.constant = item.imgUrls.count>0?kCollectionViewCellHeight:0;
    [_collectionView reloadData];
    
    _titleLabel.text = [NSString stringWithFormat:@"[原文]%@",item.articleTitle];
    
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _item.imgUrls.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ArticleUserCenterCommentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ArticleUserCenterCommentCollectionViewCellID forIndexPath:indexPath];
    NSArray<NSString *> *ary = _item.imgUrls[indexPath.row];
    NSString *imgUrl = ary.count>0?ary[0]:@"";
    cell.imgUrl = imgUrl;
    return cell;
}



- (IBAction)action:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    _item.isPraised = sender.selected;
    sender.selected?_item.praiseCount++:_item.praiseCount--;
    _praiseCountLabel.text = [NSString stringWithFormat:@"%zd",_item.praiseCount];
    
    if ([self.delegate respondsToSelector:@selector(articleUserCenterCommentCell:actionType:value:)]) {
        [self.delegate articleUserCenterCommentCell:self actionType:ArticleUserCenterCommentCellActionTypePrise value:_item];
    }
    
}

@end
