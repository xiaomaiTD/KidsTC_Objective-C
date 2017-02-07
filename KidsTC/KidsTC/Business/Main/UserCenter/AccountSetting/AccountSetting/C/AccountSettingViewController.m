//
//  AccountSettingViewController.m
//  KidsTC
//
//  Created by zhanping on 7/26/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "AccountSettingViewController.h"
#import "AccountSettingViewCell.h"
#import "AccountSettingLogoutView.h"
#import "RoleSelectViewController.h"
#import "ResetPasswordViewController.h"
#import "ChangeNickNameViewController.h"
#import "GHeader.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "ImageTrimViewController.h"
#import "UIImage+Category.h"
#import "ActionSheet.h"
#import "TZImagePickerController.h"
#import "BuryPointManager.h"
#import "UserAddressManageViewController.h"

@interface AccountSettingViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,TZImagePickerControllerDelegate,ImageTrimViewControllerDelegate,ActionSheetDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<AccountSettingViewCell *> *cells;
@property (nonatomic, strong) ActionSheet *logoutActionSheet;
@end
static NSString *const AccountSettingViewCellID = @"AccountSettingViewCellID";
@implementation AccountSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageId = 10906;
    
    self.navigationItem.title = @"账户设置";
    
    [self initTableView];
    
    [NotificationCenter addObserver:self selector:@selector(roleDidChangeAction) name:kRoleHasChangedNotification object:nil];
}

- (void)dealloc{
    [NotificationCenter removeObserver:self forKeyPath:kRoleHasChangedNotification];
}

- (void)initTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerNib:[UINib nibWithNibName:@"AccountSettingViewCell" bundle:nil] forCellReuseIdentifier:AccountSettingViewCellID];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    AccountSettingLogoutView *logoutView = [[NSBundle mainBundle] loadNibNamed:@"AccountSettingLogoutView" owner:self options:nil].firstObject;
    logoutView.logoutBlock = ^void(){
        [self logout];
    };
    logoutView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 60);
    self.tableView.tableFooterView = logoutView;
}

- (void)roleDidChangeAction{
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.row==0?80:44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AccountSettingViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AccountSettingViewCellID];
    cell.tag = indexPath.row;
    cell.model = self.model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSUInteger row = indexPath.row;
    if (row==0){[self changeHeaderImage];}else
    if (row==1){[self changeRole];}else
    if (row==2){[self changeName];}else
    if (row==4){[self manageAddress];}else
    if (row==5){[self resetPassword];}
}

#pragma mark - actions

- (void)changeHeaderImage{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"更改头像" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *actionCamara = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self getMediaFromSource:UIImagePickerControllerSourceTypeCamera];
    }];
    UIAlertAction *actionAlbum = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //[self getMediaFromSource:UIImagePickerControllerSourceTypePhotoLibrary];
        [self pushImagePickerController];
    }];
    UIAlertAction *actionCancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:actionCamara];
    [alert addAction:actionAlbum];
    [alert addAction:actionCancle];
    [self presentViewController:alert animated:YES completion:nil];
    
    [BuryPointManager trackEvent:@"event_click_usr_changehead" actionId:21504 params:nil];
}

-(void)getMediaFromSource:(UIImagePickerControllerSourceType)sourceType
{
    if([UIImagePickerController isSourceTypeAvailable:sourceType]){
        UIImagePickerController *picker=[[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing=NO;
        picker.sourceType=sourceType;
        NSArray *mediatypes=[UIImagePickerController availableMediaTypesForSourceType:sourceType];
        picker.mediaTypes=mediatypes;
        NSArray *arrmediatypes=[NSArray arrayWithObject:(NSString *)kUTTypeImage];
        picker.mediaTypes=arrmediatypes;
        [self presentViewController:picker animated:YES completion:nil];
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误信息" message:@"当前设备不支持拍摄功能" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(nonnull NSDictionary<NSString *,id> *)info {
    NSString *lastChosenMediaType=[info objectForKey:UIImagePickerControllerMediaType];
    [picker dismissViewControllerAnimated:YES completion:^{
        if([lastChosenMediaType isEqual:(NSString *) kUTTypeImage]) {
            UIImage *chosenImage=[info objectForKey:UIImagePickerControllerOriginalImage];
            [self trimImage:chosenImage];
        } else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误信息" message:@"头像不支持非图片格式" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
}

#pragma mark - TZImagePickerController

- (void)pushImagePickerController{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self];
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowTakePicture = NO;
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark - TZImagePickerControllerDelegate

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    [picker dismissViewControllerAnimated:NO completion:nil];
    
    if (photos.count>0) {
        [self trimImage:photos[0]];
    }
}

- (void)trimImage:(UIImage *)img {
    if (!img || ![img isKindOfClass:[UIImage class]]) {
        return;
    }
    ImageTrimViewController *trimVC = [[ImageTrimViewController alloc] initWithImage:img targetSize:CGSizeMake(400, 400)];
    trimVC.delegate = self;
    [self presentViewController:trimVC animated:YES completion:nil];
}

#pragma mark - ImageTrimViewControllerDelegate

- (void)imageTrimViewController:(ImageTrimViewController *)controller didFinishedTrimmingWithNewImage:(UIImage *)image{
    if (image) {
        [TCProgressHUD showSVP];
        NSData *data = UIImageJPEGRepresentation(image, 0.0);
        NSString *dataString = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        NSDictionary *param = @{@"fileStr": dataString,
                                @"suffix" : @"JPEG",
                                @"count"  : @"1"};
        [Request startWithName:@"IMAGE_UPLOAD" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
            NSString *url = dic[@"data"];
            if (url.length==0) {[[iToast makeText:@"图片上传成功,但返回url为空"] show];return;}
            [self uploadImageSuccess:url];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [TCProgressHUD dismissSVP];
            [[iToast makeText:@"图片上传失败，请稍后再试"] show];
        }];
    } else {
        [[iToast makeText:@"获取图片失败"] show];
    }
}

- (void)uploadImageSuccess:(NSString *)url{
    NSDictionary *param = @{@"headUrl":url};
    [Request startWithName:@"USER_UPDATE_INFO" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        
        [TCProgressHUD dismissSVP];
        [[iToast makeText:@"头像更换成功"] show];
        self.model.headerUrl = url;
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        [[iToast makeText:@"图片上传失败，请稍后再试"] show];
    }];
}

- (void)changeRole{
    RoleSelectViewController *controller = [[RoleSelectViewController alloc]initWithNibName:@"RoleSelectViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)changeName{
    ChangeNickNameViewController *controller = [[ChangeNickNameViewController alloc]initWithNibName:@"ChangeNickNameViewController" bundle:nil];
    controller.oldNickName = self.model.userName;
    controller.successBlock = ^BOOL(NSString *newNickName){
        self.model.userName = newNickName;
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        return YES;
    };
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)manageAddress{
    UserAddressManageViewController *controller = [[UserAddressManageViewController alloc]init];
    controller.fromeType = UserAddressManageFromTypeAccountSetting;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)resetPassword{
    ResetPasswordViewController *controller = [[ResetPasswordViewController alloc] initWithNibName:@"ResetPasswordViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)logout{
    if (!self.logoutActionSheet) {
        self.logoutActionSheet = [[ActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil];
    }
    [self.logoutActionSheet show];
}

#pragma mark - ActionSheetDelegate

- (void)didClickActionSheet:(ActionSheet *__nullable)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    [actionSheet hide];
    if (buttonIndex==1){
        [TCProgressHUD showSVP];
        [[User shareUser] logoutManually:YES withSuccess:^{
            [TCProgressHUD dismissSVP];
            [[iToast makeText:@"退出登录成功"] show];
            [self back];
        } failure:^(NSError *err) {
            [TCProgressHUD dismissSVP];
            [[iToast makeText:@"退出登录失败"] show];
        }];
        NSDictionary *params = @{@"uid":[User shareUser].uid};
        [BuryPointManager trackEvent:@"event_result_logoff" actionId:21503 params:params];
    }
}

@end
