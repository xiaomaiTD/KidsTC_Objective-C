//
//  ProductDetailCommentCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailCommentCell.h"
#import "FiveStarsView.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"
#import "ProductDetailCommentCellCollectionViewCell.h"

static NSString *const ID = @"ProductDetailCommentCellCollectionViewCell";

@interface ProductDetailCommentCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet FiveStarsView *starsView;
@property (weak, nonatomic) IBOutlet UIImageView *headerImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *contentL;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UILabel *commentCountL;
@property (weak, nonatomic) IBOutlet UILabel *likeCountL;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewConstraintH;
@property (nonatomic, strong) ProduceDetialCommentItem *comment;
@end

@implementation ProductDetailCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    self.headerImgView.layer.cornerRadius = 25;
    self.headerImgView.layer.masksToBounds = YES;
    self.headerImgView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.headerImgView.layer.borderWidth = LINE_H;
    [self.collectionView registerNib:[UINib nibWithNibName:@"ProductDetailCommentCellCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ID];
}

- (void)setData:(ProductDetailData *)data {
    [super setData:data];
    if (_index<data.commentList.count) {
        ProduceDetialCommentItem *comment = data.commentList[_index];
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
            constant = (SCREEN_WIDTH - 6*12)/4.5;
        }
        self.collectionViewConstraintH.constant = constant;
        [self.collectionView reloadData];
    }
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    
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
    ProductDetailCommentCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.imgUrl = self.comment.imageUrl[indexPath.row].firstObject;
    return cell;
}



@end
