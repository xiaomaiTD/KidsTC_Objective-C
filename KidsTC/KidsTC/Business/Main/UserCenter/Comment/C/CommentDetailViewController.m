//
//  CommentDetailViewController.m
//  KidsTC
//
//  Created by 钱烨 on 10/29/15.
//  Copyright © 2015 KidsTC. All rights reserved.
//

#import "CommentDetailViewController.h"
#import "AUIKeyboardAdhesiveView.h"
#import "TZImagePickerController.h"
#import "MWPhotoBrowser.h"
#import "KTCImageUploader.h"
#import "SegueMaster.h"
#import "GHeader.h"
#import "BuryPointManager.h"
#import "NSString+Category.h"

@interface CommentDetailViewController () <CommentDetailViewDelegate, AUIKeyboardAdhesiveViewDelegate,TZImagePickerControllerDelegate, MWPhotoBrowserDelegate>{
    NSMutableArray *_selectedPhotos;
    NSMutableArray *_selectedAssets;
}

@property (weak, nonatomic) IBOutlet CommentDetailView *detailView;
@property (nonatomic, strong) CommentDetailViewModel *viewModel;

@property (nonatomic, strong) AUIKeyboardAdhesiveView *keyboardAdhesiveView;

@property (nonatomic, strong) id headerModel;

@property (nonatomic, strong) NSDictionary *produceInfo;

@property (nonatomic, assign) BOOL isComment;

@property (nonatomic, strong) KTCCommentManager *commentManager;

@end

@implementation CommentDetailViewController

- (instancetype)initWithSource:(CommentDetailSource)source relationType:(CommentRelationType)type headerModel:(id)model {
    self = [super initWithNibName:@"CommentDetailViewController" bundle:nil];
    if (self) {
        _viewSource = source;
        _relationType = type;
        self.headerModel = model;
        if (source == CommentDetailViewSourceServiceOrStore) {
            _relationIdentifier = ((CommentListItemModel *)model).relationIdentifier;
            _commentIdentifier = ((CommentListItemModel *)model).identifier;
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"用户评价";
    switch (self.viewSource) {
        case CommentDetailViewSourceServiceOrStore:
        {
            self.pageId = 10603;
        }
            break;
        case CommentDetailViewSourceStrategy:
        {
            self.pageId = 10805;
        }
            break;
        case CommentDetailViewSourceStrategyDetail:
        {
            self.pageId = 10804;
        }
            break;
        default:
            break;
    }
    if ([self.relationIdentifier isNotNull]) {
        self.trackParams = @{@"relationNo":self.relationIdentifier};
    }
    // Do any additional setup after loading the view from its nib.
    self.detailView.delegate = self;
    self.viewModel = [[CommentDetailViewModel alloc] initWithView:self.detailView];
    [self.viewModel.detailModel setModelSource:self.viewSource];
    [self.viewModel.detailModel setRelationType:self.relationType];
    [self.viewModel.detailModel setIdentifier:self.commentIdentifier];
    [self.viewModel.detailModel setRelationIdentifier:self.relationIdentifier];
    [self.viewModel.detailModel setHeaderModel:self.headerModel];
    [self.viewModel startUpdateDataWithSucceed:nil failure:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!self.keyboardAdhesiveView) {
        self.keyboardAdhesiveView = [[AUIKeyboardAdhesiveView alloc] initWithAvailableFuntions:nil];
        [self.keyboardAdhesiveView.headerView setBackgroundColor:COLOR_PINK];
        [self.keyboardAdhesiveView setTextLimitLength:100];
        self.keyboardAdhesiveView.delegate = self;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [TCProgressHUD dismissSVP];
}

- (void)dealloc {
    if (self.keyboardAdhesiveView) {
        [self.keyboardAdhesiveView destroy];
    }
}

#pragma mark CommentDetailViewDelegate

- (void)commentDetailView:(CommentDetailView *)detailView didSelectedReplyAtIndex:(NSUInteger)index {
    
    [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
        CommentReplyItemModel *model = [self.viewModel.detailModel.replyModels objectAtIndex:index];
        [self.keyboardAdhesiveView setPlaceholder:[NSString stringWithFormat:@"回复%@：",model.userName]];
        [self.keyboardAdhesiveView expand];
        if (self.viewSource == CommentDetailViewSourceStrategy || self.viewSource == CommentDetailViewSourceStrategyDetail) {
            self.isComment = YES;
        } else {
            self.isComment = NO;
        };
        self.commentIdentifier = model.identifier;
    }];
    
}

- (void)didTappedOnCommentDetailView:(CommentDetailView *)detailView {
    [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
        [self.keyboardAdhesiveView setPlaceholder:@"发表评论："];
        [self.keyboardAdhesiveView expand];
        self.commentIdentifier = self.viewModel.detailModel.identifier;
        if (self.viewSource == CommentDetailViewSourceStrategy || self.viewSource == CommentDetailViewSourceStrategyDetail) {
            self.isComment = YES;
            self.commentIdentifier = nil;
        } else {
            self.isComment = NO;
        }
    }];
}

- (void)didClickedRelationInfoOnCommentDetailView:(CommentDetailView *)detailView {
    
//    ParentingStrategyDetailCellModel *model = self.headerModel;
//    [SegueMaster makeSegueWithModel:model.relatedInfoModel fromController:self];
}

- (void)commentDetailViewDidPulledDownToRefresh:(CommentDetailView *)detailView {
    [self.viewModel startUpdateDataWithSucceed:nil failure:nil];
}

- (void)commentDetailViewDidPulledUpToloadMore:(CommentDetailView *)detailView {
    [self.viewModel getMoreReplies];
}

- (void)commentDetailView:(CommentDetailView *)detailView didSelectedLinkWithSegueModel:(SegueModel *)model {
    [SegueMaster makeSegueWithModel:model fromController:self];
}

#pragma mark AUIKeyboardAdhesiveViewDelegate

- (void)didClickedSendButtonOnKeyboardAdhesiveView:(AUIKeyboardAdhesiveView *)view {
    if (![self isValidateComment]) {
        return;
    }
    [TCProgressHUD showSVP];
    if (_selectedPhotos.count>0) {
        __weak CommentDetailViewController *weakSelf = self;
        [[KTCImageUploader sharedInstance] startUploadWithImagesArray:_selectedPhotos splitCount:2 withSucceed:^(NSArray *locateUrlStrings) {
            [weakSelf submitCommentsWithUploadLocations:locateUrlStrings];
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
    } else {
        [self submitCommentsWithUploadLocations:nil];
    }
}

- (void)keyboardAdhesiveView:(AUIKeyboardAdhesiveView *)view didClickedExtensionFunctionButtonWithType:(AUIKeyboardAdhesiveViewExtensionFunctionType)type {
    if (type == AUIKeyboardAdhesiveViewExtensionFunctionTypeImageUpload) {
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:10 columnNumber:4 delegate:self];
        imagePickerVc.allowPickingVideo = NO;
        imagePickerVc.selectedAssets = _selectedAssets; // 目前已经选中的图片数组
        [self presentViewController:imagePickerVc animated:YES completion:nil];
        [self.keyboardAdhesiveView hide];
    }
}

- (void)keyboardAdhesiveView:(AUIKeyboardAdhesiveView *)view didClickedUploadImageAtIndex:(NSUInteger)index {
    NSArray *array = [self makeMWPhotoFromImageArray:_selectedPhotos];
    MWPhotoBrowser *photoBrowser = [[MWPhotoBrowser alloc] initWithPhotos:array];
    [photoBrowser setCurrentPhotoIndex:index];
    [photoBrowser setShowDeleteButton:YES];
    photoBrowser.delegate = self;
    [self presentViewController:photoBrowser animated:YES completion:nil];
}

//选择照片完成
#pragma mark - TZImagePickerControllerDelegate

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    _selectedAssets = [NSMutableArray arrayWithArray:assets];
    [self.keyboardAdhesiveView setUploadImages:_selectedPhotos];
    [self.keyboardAdhesiveView show];
}

- (void)imagePickerControllerDidCancel:(TZImagePickerController *)picker {
    [self.keyboardAdhesiveView show];
}

#pragma mark MWPhotoBrowserDelegate

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didClickedDeleteButtonAtIndex:(NSUInteger)index {
    [self deletePhotoAtIndex:index];
    [self.keyboardAdhesiveView setUploadImages:_selectedPhotos];
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

#define MIN_COMMENTLENGTH (1)

- (BOOL)isValidateComment {
    NSString *commentText = self.keyboardAdhesiveView.text;
    commentText = [commentText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([commentText length] < MIN_COMMENTLENGTH) {
        [[iToast makeText:@"请至少输入1个字"] show];
        return NO;
    }
    
    return YES;
}


- (void)submitCommentsWithUploadLocations:(NSArray *)locationUrls {
    KTCCommentObject *object = [[KTCCommentObject alloc] init];
    object.identifier = self.relationIdentifier;
    object.relationType = self.relationType;
    object.isAnonymous = NO;
    object.isComment = self.isComment;
    if ([self.commentIdentifier length] > 0) {
        object.commentIdentifier = self.commentIdentifier;
    }
    object.content = self.keyboardAdhesiveView.text;
    object.uploadImageStrings = locationUrls;
    
    if (!self.commentManager) {
        self.commentManager = [[KTCCommentManager alloc] init];
    }
    __weak CommentDetailViewController *weakSelf = self;
    [weakSelf.commentManager addCommentWithObject:object succeed:^(NSDictionary *data) {
        [TCProgressHUD dismissSVP];
        [weakSelf submitCommentSucceed:data];
    } failure:^(NSError *error) {
        [TCProgressHUD dismissSVP];
        [weakSelf submitCommentFailed:error];
    }];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if ([object.identifier isNotNull]) {
        [params setValue:object.identifier forKey:@"pid"];
    }
    if ([self.commentIdentifier isNotNull]) {
        [params setValue:self.commentIdentifier forKey:@"reply"];
    }
    [BuryPointManager trackEvent:@"event_result_eva_commit" actionId:20802 params:params];
}

- (void)submitCommentSucceed:(NSDictionary *)data {
    [self.keyboardAdhesiveView shrink];
    [self.viewModel startUpdateDataWithSucceed:nil failure:nil];
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
