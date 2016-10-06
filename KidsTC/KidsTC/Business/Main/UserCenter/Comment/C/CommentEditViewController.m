//
//  CommentEditViewController.m
//  KidsTC
//
//  Created by Altair on 12/2/15.
//  Copyright © 2015 KidsTC. All rights reserved.
//

#import "CommentEditViewController.h"
#import "CommentEditView.h"
#import "TZImagePickerController.h"
#import "MWPhotoBrowser.h"
#import "KTCImageUploader.h"
#import "MyCommentListItemModel.h"
#import "CommentEditingModel.h"
#import "GHeader.h"

@interface CommentEditViewController () <CommentEditViewDelegate, TZImagePickerControllerDelegate, MWPhotoBrowserDelegate>{
    NSMutableArray *_selectedPhotos;
    NSMutableArray *_selectedAssets;
}

@property (weak, nonatomic) IBOutlet CommentEditView *commentView;
@property (nonatomic, strong) CommentEditingModel *commentModel;
@property (nonatomic, strong) KTCCommentManager *commentManager;
@property (nonatomic, strong) NSArray *mwPhotosArray;
@end

@implementation CommentEditViewController

- (instancetype)initWithMyCommentItem:(MyCommentListItemModel *)item {
    self = [super initWithNibName:@"CommentEditViewController" bundle:nil];
    if (self) {
        self.commentModel = [CommentEditingModel modelFromItem:item];
        self.commentManager = [[KTCCommentManager alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationItem.title = @"修改评价";
    self.commentView.delegate = self;
    [self.commentView setCommentModel:self.commentModel];
    self.mwPhotosArray = [NSArray arrayWithArray:self.commentModel.photosArray];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.commentView endEditing];
}

#pragma mark CommentEditViewDelegate

- (void)didClickedAddPhotoButtonOnCommentEditView:(CommentEditView *)editView {
    
    int count = 10 - (int)[self.commentModel.thumbnailPhotoUrlStringsArray count];
    if (count<=0 || count>10) {
        [[iToast makeText:@"已超过最大图片数量，请删除其他图片后再选择"] show];
        return;
    }
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:count columnNumber:4 delegate:self];
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.selectedAssets = _selectedAssets; // 目前已经选中的图片数组
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

- (void)commentEditView:(CommentEditView *)editView didClickedThumbImageAtIndex:(NSUInteger)index {
    MWPhotoBrowser *photoBrowser = [[MWPhotoBrowser alloc] initWithPhotos:self.mwPhotosArray];
    [photoBrowser setCurrentPhotoIndex:index];
    [photoBrowser setShowDeleteButton:YES];
    photoBrowser.delegate = self;
    [self presentViewController:photoBrowser animated:YES completion:nil];
}

- (void)didClickedSubmitButtonOnCommentEditView:(CommentEditView *)editView {
    if (![self isValidateComment]) {
        return;
    }
    __weak CommentEditViewController *weakSelf = self;
    [TCProgressHUD showSVP];
    if (_selectedPhotos.count>0) {
        [[KTCImageUploader sharedInstance]  startUploadWithImagesArray:_selectedPhotos splitCount:2 withSucceed:^(NSArray *locateUrlStrings) {
            NSArray *remote = [weakSelf.commentModel remoteImageUrlStrings];
            NSMutableArray *tempArray = [[NSMutableArray alloc] init];
            if ([remote count] > 0) {
                [tempArray addObjectsFromArray:remote];
            }
            [tempArray addObjectsFromArray:locateUrlStrings];
            weakSelf.commentModel.uploadPhotoLocationStrings = [NSArray arrayWithArray:tempArray];
            [weakSelf submitComments];
        } failure:^(NSError *error) {
            [TCProgressHUD dismissSVP];
            if (error.userInfo) {
                NSString *errMsg = [error.userInfo objectForKey:@"data"];
                if ([errMsg isKindOfClass:[NSString class]] && [errMsg length] > 0) {
                    
                    [[iToast makeText:errMsg] show];
                } else {
                    [[iToast makeText:@"照片上传失败，请重新提交"] show];
                }
            } else {
                [[iToast makeText:@"照片上传失败，请重新提交"] show];
            }
        }];
    }else{
        [TCProgressHUD showSVP];
        [self submitComments];
    }
}

#pragma mark - TZImagePickerControllerDelegate

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    _selectedAssets = [NSMutableArray arrayWithArray:assets];
    if ([self.commentModel.thumbnailPhotoUrlStringsArray count] > 0) {
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        if ([self.commentModel.thumbnailPhotoUrlStringsArray count] > 0) {
            [tempArray addObjectsFromArray:self.commentModel.thumbnailPhotoUrlStringsArray];
        }
        [tempArray addObjectsFromArray:_selectedPhotos];
        self.commentModel.combinedImagesArray = [NSArray arrayWithArray:tempArray];
    } else {
        self.commentModel.combinedImagesArray = _selectedPhotos;
    }
    [self.commentView resetPhotoViewWithImagesArray:self.commentModel.combinedImagesArray];
    
    [self makeMWPhotoFromImageArray:_selectedPhotos];
}

#pragma mark MWPhotoBrowserDelegate

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didClickedDeleteButtonAtIndex:(NSUInteger)index {
    [self deletePhotoAtIndex:index];
    [self.commentView resetPhotoViewWithImagesArray:self.commentModel.combinedImagesArray];
}

- (void)deletePhotoAtIndex :(NSInteger)index
{
    NSInteger originIndex = index;
    if ([self.commentModel.thumbnailPhotoUrlStringsArray count] > index) {
        NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.commentModel.thumbnailPhotoUrlStringsArray];
        [tempArray removeObjectAtIndex:index];
        self.commentModel.thumbnailPhotoUrlStringsArray = [NSArray arrayWithArray:tempArray];
        
        [tempArray removeAllObjects];
        [tempArray addObjectsFromArray:self.commentModel.originalPhotoUrlStringsArray];
        [tempArray removeObjectAtIndex:index];
        self.commentModel.originalPhotoUrlStringsArray = [NSArray arrayWithArray:tempArray];
        
        [tempArray removeAllObjects];
        [tempArray addObjectsFromArray:self.commentModel.photosArray];
        [tempArray removeObjectAtIndex:index];
        self.commentModel.photosArray = [NSArray arrayWithArray:tempArray];
        
        [tempArray removeAllObjects];
        [tempArray addObjectsFromArray:self.commentModel.combinedImagesArray];
        [tempArray removeObjectAtIndex:index];
        self.commentModel.combinedImagesArray = [NSArray arrayWithArray:tempArray];
        
        [tempArray removeAllObjects];
        [tempArray addObjectsFromArray:self.mwPhotosArray];
        [tempArray removeObjectAtIndex:index];
        self.mwPhotosArray = [NSArray arrayWithArray:tempArray];
        
        [tempArray removeAllObjects];
        [tempArray addObjectsFromArray:self.commentModel.uploadPhotoLocationStrings];
        [tempArray removeObjectAtIndex:index];
        self.commentModel.uploadPhotoLocationStrings = [NSArray arrayWithArray:tempArray];
        
        return;
    } else {
        index -= [self.commentModel.thumbnailPhotoUrlStringsArray count];
        
        if (_selectedPhotos.count>index && _selectedAssets.count>index) {
            [_selectedPhotos removeObjectAtIndex:index];
            [_selectedAssets removeObjectAtIndex:index];
        }
        if ([self.commentModel.thumbnailPhotoUrlStringsArray count] > 0) {
            NSMutableArray *tempArray = [[NSMutableArray alloc] init];
            if ([self.commentModel.thumbnailPhotoUrlStringsArray count] > 0) {
                [tempArray addObjectsFromArray:self.commentModel.thumbnailPhotoUrlStringsArray];
            }
            [tempArray addObjectsFromArray:_selectedPhotos];
            self.commentModel.combinedImagesArray = [NSArray arrayWithArray:tempArray];
        } else {
            self.commentModel.combinedImagesArray = _selectedPhotos;
        }
        [self.commentView resetPhotoViewWithImagesArray:self.commentModel.combinedImagesArray];
        [self makeMWPhotoFromImageArray:_selectedPhotos];
    }
}

#pragma mark Private methods

- (void)makeMWPhotoFromImageArray:(NSArray<UIImage *> *)array {
    NSMutableArray *temp = [[NSMutableArray alloc] initWithArray:self.mwPhotosArray];
    [array enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MWPhoto *photo = [[MWPhoto alloc] initWithImage:obj];
        if (photo) {
            [temp addObject:photo];
        }
    }];
    self.mwPhotosArray =  [NSArray arrayWithArray:temp];
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
    object.identifier = self.commentModel.relationIdentifier;
    object.relationType = self.commentModel.relationType;
    object.commentIdentifier = self.commentModel.commentIdentifier;
    object.isAnonymous = NO;
    object.isComment = YES;
    object.content = self.commentModel.commentText;
    object.uploadImageStrings = self.commentModel.uploadPhotoLocationStrings;
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
    __weak CommentEditViewController *weakSelf = self;
    [weakSelf.commentManager modifyUserCommentWithObject:object succeed:^(NSDictionary *data) {
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
    if (self.delegate && [self.delegate respondsToSelector:@selector(commentEditViewControllerDidFinishSubmitComment:)]) {
        [self.delegate commentEditViewControllerDidFinishSubmitComment:self];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
