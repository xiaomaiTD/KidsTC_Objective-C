//
//  NormalProductDetailCommentCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NormalProductDetailCommentCell.h"
#import "FiveStarsView.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"
#import "NormalProductDetailCommentCollectionCell.h"

static NSString *const ID = @"NormalProductDetailCommentCollectionCell";

@interface NormalProductDetailCommentCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet FiveStarsView *starsView;
@property (weak, nonatomic) IBOutlet UIImageView *headerImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *contentL;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UILabel *commentCountL;
@property (weak, nonatomic) IBOutlet UILabel *likeCountL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewConstraintH;
@property (nonatomic, strong) NormalProductDetialCommentItem *comment;
@end

@implementation NormalProductDetailCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    self.headerImgView.layer.cornerRadius = CGRectGetWidth(self.headerImgView.bounds) * 0.5;
    self.headerImgView.layer.masksToBounds = YES;
    self.headerImgView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.headerImgView.layer.borderWidth = LINE_H;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"NormalProductDetailCommentCollectionCell" bundle:nil] forCellWithReuseIdentifier:ID];
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tapGR];
}

- (void)setData:(NormalProductDetailData *)data {
    [super setData:data];
    if (_index<data.commentList.count) {
        NormalProductDetialCommentItem *comment = data.commentList[_index];
        [self.headerImgView sd_setImageWithURL:[NSURL URLWithString:comment.userImgUrl] placeholderImage:PLACEHOLDERIMAGE_SMALL_LOG];
        self.nameL.text = comment.userName;
        self.contentL.attributedText = comment.attContent;
        self.timeL.text = comment.time;
        self.commentCountL.text = [NSString stringWithFormat:@"(%zd)",comment.replyCount];
        self.likeCountL.text = [NSString stringWithFormat:@"(%zd)",comment.praiseCount];
        [self.starsView setStarNumber:comment.score.OverallScore];
        
        self.comment = comment;
        
        CGFloat constant = 0;
        if (comment.imageUrl.count>0) {
            constant = (SCREEN_WIDTH - 4*12 - 2*15)/4.5;
        }
        self.collectionViewConstraintH.constant = constant;
        [self.collectionView reloadData];
    }
    [self layoutIfNeeded];
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    if ([self.delegate respondsToSelector:@selector(normalProductDetailBaseCell:actionType:value:)]) {
        [self.delegate normalProductDetailBaseCell:self actionType:NormalProductDetailBaseCellActionTypeComment value:@(_index)];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat size = CGRectGetHeight(collectionView.bounds);
    return CGSizeMake(size, size);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 12;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.comment.imageUrl.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NormalProductDetailCommentCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.imgUrl = self.comment.imageUrl[indexPath.row].firstObject;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(normalProductDetailBaseCell:actionType:value:)]) {
        [self.delegate normalProductDetailBaseCell:self actionType:NormalProductDetailBaseCellActionTypeComment value:@(_index)];
    }
}


@end
