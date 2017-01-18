//
//  CommentUtilsToolBar.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/17.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "CommentUtilsToolBar.h"
#import "KTCMapService.h"
#import "NSString+Category.h"
#import "iToast.h"

#import "CommentUtilsCollectionCell.h"

static NSString *CellID = @"CommentUtilsCollectionCell";
static NSUInteger const maxCount = 500;
CGFloat const animationDuration = 0.2;
@interface CommentUtilsToolBar ()<UITextViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *toolbg;
@property (weak, nonatomic) IBOutlet UIButton *cameraBtn;
@property (weak, nonatomic) IBOutlet UIButton *photosBtn;
@property (weak, nonatomic) IBOutlet UIView *addressbg;
@property (weak, nonatomic) IBOutlet UIButton *addressBtn;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;

@property (weak, nonatomic) IBOutlet UIView *inputbg;

@property (weak, nonatomic) IBOutlet UILabel *tvPlaceHolderLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewH;
@end

@implementation CommentUtilsToolBar

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"CommentUtilsCollectionCell" bundle:nil] forCellWithReuseIdentifier:CellID];
    self.collectionViewH.constant = 0;
    [self layoutIfNeeded];
    
    self.inputbg.layer.cornerRadius = 4;
    self.inputbg.layer.masksToBounds = YES;
    self.inputbg.layer.borderColor = [UIColor colorFromHexString:@"dedede"].CGColor;
    self.inputbg.layer.borderWidth = 1;
    
    self.addressbg.layer.cornerRadius = CGRectGetHeight(self.addressbg.bounds) * 0.5;
    self.addressbg.layer.masksToBounds = YES;
    self.addressbg.layer.borderColor = [UIColor colorFromHexString:@"dedede"].CGColor;
    self.addressbg.layer.borderWidth = 1;
    
    self.sendBtn.layer.cornerRadius = 2;
    self.sendBtn.layer.masksToBounds = YES;
    
    self.cameraBtn.tag = CommentUtilsToolBarActionTypeCamera;
    self.photosBtn.tag = CommentUtilsToolBarActionTypePhotos;
    self.addressBtn.tag = CommentUtilsToolBarActionTypeAddress;
    self.sendBtn.tag = CommentUtilsToolBarActionTypeSend;
    
    [NotificationCenter addObserver:self selector:@selector(userLocation) name:kUserLocationHasChangedNotification object:nil];
    [self userLocation];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(animationDuration+0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.textView becomeFirstResponder];
    });;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {}

- (void)setSelectedPhotos:(NSArray *)selectedPhotos {
    _selectedPhotos = selectedPhotos;
    self.collectionViewH.constant = self.selectedPhotos.count>0?50:0;
    [self.collectionView reloadData];
    [self layoutIfNeeded];
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(commentUtilsToolBar:actionType:value:)]) {
        [self.delegate commentUtilsToolBar:self actionType:sender.tag value:nil];
    }
}

- (IBAction)address:(UIButton *)sender {
    [self userLocation];
    [self action:sender];
}

- (void)userLocation {
    NSString *locationString = [KTCMapService shareKTCMapService].currentLocation.locationDescription;
    NSString *address = [locationString isNotNull]?locationString:@"点击获取位置";
    self.addressLabel.text = address;
}

- (IBAction)send:(UIButton *)sender {
    
    NSString *text = self.textView.text;
    if (text.length<1) {
        [[iToast makeText:@"评论不能为空哦"] show];
        return;
    }
    if ([self.delegate respondsToSelector:@selector(commentUtilsToolBar:actionType:value:)]) {
        [self.delegate commentUtilsToolBar:self actionType:CommentUtilsToolBarActionTypeSend value:text];
    }
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView {
    self.tvPlaceHolderLabel.hidden = textView.text.length>0;
    if (textView.text.length>maxCount) {
        textView.text = [textView.text substringToIndex:maxCount];
        NSString *msg = [NSString stringWithFormat:@"最多只能输入%zd个字哦~",maxCount];
        [[iToast makeText:msg] show];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat size = 50;
    return CGSizeMake(size, size);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 4;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 4;
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.selectedPhotos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CommentUtilsCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    if (row<self.selectedPhotos.count) {
        id obj = self.selectedPhotos[row];
        if ([obj isKindOfClass:[UIImage class]]) {
            cell.img = obj;
        }
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    if ([self.delegate respondsToSelector:@selector(commentUtilsToolBar:actionType:value:)]) {
        [self.delegate commentUtilsToolBar:self actionType:CommentUtilsToolBarActionTypeSelectPicture value:@(indexPath.row)];
    }
}

- (void)dealloc {
    [NotificationCenter removeObserver:self name:kUserLocationHasChangedNotification object:nil];
}
@end
