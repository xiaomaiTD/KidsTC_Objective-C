//
//  CommentFoundingViewController.m
//  KidsTC
//
//  Created by Altair on 11/27/15.
//  Copyright © 2015 KidsTC. All rights reserved.
//

#import "CommentFoundingViewController.h"
#import "CommentFoundingView.h"
#import "TZImagePickerController.h"
#import "MWPhotoBrowser.h"
#import "KTCImageUploader.h"
#import "iToast.h"
#import "GHeader.h"
#import "NSString+Category.h"

@interface CommentFoundingViewController () <CommentFoundingViewDelegate, TZImagePickerControllerDelegate, MWPhotoBrowserDelegate>{
    NSMutableArray *_selectedPhotos;
    NSMutableArray *_selectedAssets;
}

@property (weak, nonatomic) IBOutlet CommentFoundingView *commentView;

@property (nonatomic, strong) CommentFoundingModel *commentModel;

@property (nonatomic, strong) KTCCommentManager *commentManager;

@end

@implementation CommentFoundingViewController

- (instancetype)initWithCommentFoundingModel:(CommentFoundingModel *)model {
    self = [super initWithNibName:@"CommentFoundingViewController" bundle:nil];
    if (self) {
        self.commentModel = model;
        self.commentManager = [[KTCCommentManager alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"评价";
    self.pageId = 10601;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if ([self.commentModel.relationSysNo isNotNull]) {
        [dic setValue:self.commentModel.relationSysNo forKey:@"relationNo"];
    }
    self.trackParams = [NSDictionary dictionaryWithDictionary:dic];
    
    [self.commentView setCommentModel:self.commentModel];
    self.commentView.delegate = self;
    __weak CommentFoundingViewController *weakSelf = self;
    [weakSelf.commentManager getScoreConfigWithSourceType:weakSelf.commentModel.sourceType succeed:^(NSDictionary *data) {
        weakSelf.commentModel.scoreConfigModel = [[CommentScoreConfigModel alloc] initWithRawData:[data objectForKey:@"data"]];
        [weakSelf.commentView setCommentModel:weakSelf.commentModel];
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.commentView endEditing];
}

#pragma mark CommentFoundingViewDelegate

- (void)didClickedAddPhotoButtonOnCommentFoundingView:(CommentFoundingView *)commentView {
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:10 columnNumber:4 delegate:self];
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.selectedAssets = _selectedAssets; // 目前已经选中的图片数组
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

- (void)commentFoundingView:(CommentFoundingView *)commentView didClickedThumbImageAtIndex:(NSUInteger)index {
    NSArray *array = [self makeMWPhotoFromImageArray:_selectedPhotos];
    MWPhotoBrowser *photoBrowser = [[MWPhotoBrowser alloc] initWithPhotos:array];
    [photoBrowser setCurrentPhotoIndex:index];
    [photoBrowser setShowDeleteButton:YES];
    photoBrowser.delegate = self;
    [self presentViewController:photoBrowser animated:YES completion:nil];
}

- (void)didClickedSubmitButtonOnCommentFoundingView:(CommentFoundingView *)commentView {
    if (![self isValidateComment]) return;
    
    if (_selectedPhotos.count>0) {
        __weak CommentFoundingViewController *weakSelf = self;
        [[KTCImageUploader sharedInstance]  startUploadWithImagesArray:_selectedPhotos splitCount:2 withSucceed:^(NSArray *locateUrlStrings) {
            weakSelf.commentModel.uploadPhotoLocationStrings = locateUrlStrings;
            [weakSelf submitComments];
        } failure:^(NSError *error) {
            [TCProgressHUD dismissSVP];
            [[iToast makeText:@"照片上传失败，请重新提交"] show];
        }];
    } else {
        [TCProgressHUD showSVP];
        [self submitComments];
    }
}

#pragma mark - TZImagePickerControllerDelegate

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    _selectedAssets = [NSMutableArray arrayWithArray:assets];
    [self.commentView resetPhotoViewWithImagesArray:_selectedPhotos];
}


#pragma mark MWPhotoBrowserDelegate

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didClickedDeleteButtonAtIndex:(NSUInteger)index {
    [self deletePhotoAtIndex:index];
    [self.commentView resetPhotoViewWithImagesArray:_selectedPhotos];
}

- (void)deletePhotoAtIndex :(NSInteger)index
{
    if (_selectedPhotos.count>index) {
        [_selectedPhotos removeObjectAtIndex:index];
    }
    if (_selectedAssets.count>index) {
        [_selectedAssets removeObjectAtIndex:index];
    }
}

#pragma mark Private methods

- (NSArray *)makeMWPhotoFromImageArray:(NSArray<UIImage *> *)array {
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    [array enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MWPhoto *photo = [[MWPhoto alloc] initWithImage:obj];
        if (photo) {
            [temp addObject:photo];
        }
    }];
    return [NSArray arrayWithArray:temp];
}

- (BOOL)isValidateComment {
    self.commentModel = self.commentView.commentModel;
    NSString *commentText = self.commentModel.commentText;
    if ([commentText length] < MINCOMMENTLENGTH) {
        [[iToast makeText:@"请输入至少10个字的评价。"] show];
        return NO;
    }
    
    commentText = [commentText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([commentText length] < MINCOMMENTLENGTH - 7) {
        [[iToast makeText:@"请输入有效的评论内容。"] show];
        return NO;
    }
    
    for (CommentScoreItem *item in [self.commentModel.scoreConfigModel allShowingScoreItems]) {
        if (item.score == 0) {
            [[iToast makeText:@"请给商品评分(1~5)"] show];
            return NO;
        }
    }
    
    return YES;
}

- (void)submitComments {
    KTCCommentObject *object = [[KTCCommentObject alloc] init];
    object.identifier = self.commentModel.relationSysNo;
    object.relationType = self.commentModel.relationType;
    object.isAnonymous = NO;
    object.isComment = YES;
    object.content = self.commentModel.commentText;
    object.uploadImageStrings = self.commentModel.uploadPhotoLocationStrings;
    object.orderId = self.commentModel.orderId;
    if ([[self.commentModel.scoreConfigModel allShowingScoreItems] count] > 0) {
        object.totalScore = self.commentModel.scoreConfigModel.totalScoreItem.score;
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] init];
        for (CommentScoreItem *item in self.commentModel.scoreConfigModel.otherScoreItems) {
            [tempDic setObject:[NSNumber numberWithInteger:item.score] forKey:item.key];
        }
        object.scoresDetail = [[NSDictionary alloc] initWithDictionary:tempDic copyItems:YES];
    }
    
    if (!self.commentManager) {
        self.commentManager = [[KTCCommentManager alloc] init];
    }
    __weak CommentFoundingViewController *weakSelf = self;
    [weakSelf.commentManager addCommentWithObject:object succeed:^(NSDictionary *data) {
        [TCProgressHUD dismissSVP];
        [weakSelf submitCommentSucceed:data];
    } failure:^(NSError *error) {
        [TCProgressHUD dismissSVP];
        [weakSelf submitCommentFailed:error];
    }];
}

- (void)submitCommentSucceed:(NSDictionary *)data {
    NSString *respString = [data objectForKey:@"data"];
    if ([respString isKindOfClass:[NSString class]] && [respString length] > 0) {
        [[iToast makeText:respString] show];
    } else {
        [[iToast makeText:@"评论成功"] show];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(commentFoundingViewControllerDidFinishSubmitComment:)]) {
        [self.delegate commentFoundingViewControllerDidFinishSubmitComment:self];
    }
    [self back];
}

- (void)submitCommentFailed:(NSError *)error {
    NSString *errMsg = @"提交评论失败，请重新提交。";
    NSString *remoteErrMsg = [error.userInfo objectForKey:@"data"];
    if ([remoteErrMsg isKindOfClass:[NSString class]] && [remoteErrMsg length] > 0) {
        errMsg = remoteErrMsg;
    }
    [[iToast makeText:errMsg] show];
}


@end
