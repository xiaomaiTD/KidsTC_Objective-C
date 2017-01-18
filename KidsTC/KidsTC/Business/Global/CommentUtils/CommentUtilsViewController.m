//
//  CommentUtilsViewController.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/17.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "CommentUtilsViewController.h"
#import "CommentUtilsView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "TZImageManager.h"
#import "TZImagePickerController.h"
#import "TZGifPhotoPreviewController.h"
#import "TZVideoPlayerController.h"
#import "iToast.h"

static NSUInteger maxCount = 4;

@interface CommentUtilsViewController ()<CommentUtilsViewDelegate,TZImagePickerControllerDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet CommentUtilsView *utilsView;
@property (nonatomic, strong) NSMutableArray *selectedPhotos;
@property (nonatomic, strong) NSMutableArray *selectedAssets;

@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@end

@implementation CommentUtilsViewController

- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        _imagePickerVc.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
        _imagePickerVc.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (iOS9Later) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    return _imagePickerVc;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.naviTheme = NaviThemeWihte;
    self.view.backgroundColor = [UIColor clearColor];
    self.selectedPhotos = [NSMutableArray array];
    self.selectedAssets = [NSMutableArray array];
    self.utilsView.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.utilsView show:0];
}

- (void)keyboardWillShow:(NSNotification *)noti {
    [super keyboardWillShow:noti];
    [self.utilsView show:self.keyboardHeight];
}

- (void)keyboardWillDisappear:(NSNotification *)noti {
    [super keyboardWillDisappear:noti];
    [self.utilsView show:0];
}

#pragma mark - CommentUtilsViewDelegate

- (void)commentUtilsView:(CommentUtilsView *)view actionType:(CommentUtilsViewActionType)type value:(id)value {
    
    switch (type) {
        case CommentUtilsViewActionTypeTouchBegin:
        {
            [self touchBegin:value];
        }
            break;
            
        case CommentUtilsViewActionTypeCamera:
        {
            [self camera];
        }
            break;
        case CommentUtilsViewActionTypePhotos:
        {
            [self photos];
        }
            break;
        case CommentUtilsViewActionTypeAddress:
        {
            [self address];
        }
            break;
        case CommentUtilsViewActionTypeSend:
        {
            [self send:value];
        }
            break;
        case CommentUtilsViewActionTypeSelectPicture:
        {
            [self selectPicture:value];
        }
            break;
        default:
            break;
    }
    
}

#pragma mark 触摸灰色半透明区域

- (void)touchBegin:(id)value {
    if (![value isKindOfClass:[NSString class]]) return;
    NSString *text = value;
    if (self.selectedPhotos.count>0 || self.selectedPhotos.count>0 || text.length>0) {
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定退出评论吗?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self.utilsView hide:^(BOOL finish) {
                [self back];
            }];
        }];
        [controller addAction:action];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [controller addAction:cancelAction];
        [self presentViewController:controller animated:YES completion:nil];
    }else {
        [self.utilsView hide:^(BOOL finish) {
            [self back];
        }];
    }
}

#pragma mark 拍照

- (void)camera {
    
    if (self.selectedPhotos.count>=maxCount || self.selectedPhotos.count>=maxCount) {
        NSString *msg = [NSString stringWithFormat:@"最多只能选择%zd张照片",maxCount];
        [[iToast makeText:msg] show];
        return;
    }
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) && iOS7Later) {
        // 无相机权限 做一个友好的提示
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alert show];
        // 拍照之前还需要检查相册权限
    } else if ([[TZImageManager manager] authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        alert.tag = 1;
        [alert show];
    } else if ([[TZImageManager manager] authorizationStatus] == 0) { // 正在弹框询问用户是否允许访问相册，监听权限状态
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            return [self camera];
        });
    } else { // 调用相机
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            self.imagePickerVc.sourceType = sourceType;
            if(iOS8Later) {
                self.imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            }
            [self presentViewController:_imagePickerVc animated:YES completion:nil];
        } else {
            NSLog(@"模拟器中无法打开照相机,请在真机中使用");
        }
    }
}

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
        tzImagePickerVc.sortAscendingByModificationDate = YES;
        [tzImagePickerVc showProgressHUD];
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        // save photo and get asset / 保存图片，获取到asset
        [[TZImageManager manager] savePhotoWithImage:image completion:^(NSError *error){
            if (error) {
                [tzImagePickerVc hideProgressHUD];
                NSLog(@"图片保存失败 %@",error);
            } else {
                [[TZImageManager manager] getCameraRollAlbum:NO allowPickingImage:YES completion:^(TZAlbumModel *model) {
                    [[TZImageManager manager] getAssetsFromFetchResult:model.result allowPickingVideo:NO allowPickingImage:YES completion:^(NSArray<TZAssetModel *> *models) {
                        [tzImagePickerVc hideProgressHUD];
                        TZAssetModel *assetModel = [models firstObject];
                        if (tzImagePickerVc.sortAscendingByModificationDate) {
                            assetModel = [models lastObject];
                        }
                        [self refreshCollectionViewWithAddedAsset:assetModel.asset image:image];
                    }];
                }];
            }
        }];
    }
}

- (void)refreshCollectionViewWithAddedAsset:(id)asset image:(UIImage *)image {
    [self.selectedAssets addObject:asset];
    [self.selectedPhotos addObject:image];
    self.utilsView.selectedPhotos = self.selectedPhotos;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([picker isKindOfClass:[UIImagePickerController class]]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) { // 去设置界面，开启相机访问权限
        if (iOS8Later) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        } else {
            NSURL *privacyUrl;
            if (alertView.tag == 1) {
                privacyUrl = [NSURL URLWithString:@"prefs:root=Privacy&path=PHOTOS"];
            } else {
                privacyUrl = [NSURL URLWithString:@"prefs:root=Privacy&path=CAMERA"];
            }
            if ([[UIApplication sharedApplication] canOpenURL:privacyUrl]) {
                [[UIApplication sharedApplication] openURL:privacyUrl];
            } else {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"抱歉" message:@"无法跳转到隐私设置页面，请手动前往设置页面，谢谢" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
            }
        }
    }
}

#pragma mark 选择照片

- (void)photos {
    TZImagePickerController *controller = [[TZImagePickerController alloc] initWithMaxImagesCount:maxCount columnNumber:4 delegate:self];
    controller.allowPickingVideo = NO;
    controller.selectedAssets = self.selectedAssets; // 目前已经选中的图片数组
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    self.selectedPhotos = [NSMutableArray arrayWithArray:photos];
    self.selectedAssets = [NSMutableArray arrayWithArray:assets];
    self.utilsView.selectedPhotos = self.selectedPhotos;
}

#pragma mark 获取地址

- (void)address {
    
}

#pragma mark 发送

- (void)send:(id)value {
    if (![value isKindOfClass:[NSString class]]) return;
    if ([self.delegate respondsToSelector:@selector(commentUtilsViewController:didClickSendWithPhotos:text:)]) {
        [self.delegate commentUtilsViewController:self didClickSendWithPhotos:self.selectedPhotos text:value];
    }
}

#pragma mark 点击图片预览

- (void)selectPicture:(id)value {
    if (![value respondsToSelector:@selector(integerValue)]) return;
    NSInteger index = [value integerValue];
    if (index>self.selectedAssets.count-1) return;
    if (index>self.selectedPhotos.count-1) return;
    id asset = _selectedAssets[index];
    BOOL isVideo = NO;
    if ([asset isKindOfClass:[PHAsset class]]) {
        PHAsset *phAsset = asset;
        isVideo = phAsset.mediaType == PHAssetMediaTypeVideo;
    } else if ([asset isKindOfClass:[ALAsset class]]) {
        ALAsset *alAsset = asset;
        isVideo = [[alAsset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypeVideo];
    }
    if ([[asset valueForKey:@"filename"] containsString:@"GIF"]) {
        TZGifPhotoPreviewController *vc = [[TZGifPhotoPreviewController alloc] init];
        TZAssetModel *model = [TZAssetModel modelWithAsset:asset type:TZAssetModelMediaTypePhotoGif timeLength:@""];
        vc.model = model;
        [self presentViewController:vc animated:YES completion:nil];
    } else if (isVideo) { // perview video / 预览视频
        TZVideoPlayerController *vc = [[TZVideoPlayerController alloc] init];
        TZAssetModel *model = [TZAssetModel modelWithAsset:asset type:TZAssetModelMediaTypeVideo timeLength:@""];
        vc.model = model;
        [self presentViewController:vc animated:YES completion:nil];
    } else { // preview photos / 预览照片
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithSelectedAssets:_selectedAssets selectedPhotos:_selectedPhotos index:index];
        imagePickerVc.maxImagesCount = maxCount;
        imagePickerVc.allowPickingOriginalPhoto = YES;
        imagePickerVc.isSelectOriginalPhoto = YES;
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            self.selectedPhotos = [NSMutableArray arrayWithArray:photos];
            self.selectedAssets = [NSMutableArray arrayWithArray:assets];
            self.utilsView.selectedPhotos = self.selectedPhotos;
        }];
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }
}


@end
