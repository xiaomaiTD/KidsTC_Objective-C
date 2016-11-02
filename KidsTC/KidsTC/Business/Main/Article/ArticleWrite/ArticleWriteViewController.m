//
//  ArticleWriteViewController.m
//  KidsTC
//
//  Created by zhanping on 9/8/16.
//  Copyright © 2016 zhanping. All rights reserved.
//

#import "ArticleWriteViewController.h"

#import "GHeader.h"
#import "SegueMaster.h"
#import "UIBarButtonItem+Category.h"
#import "TZImagePickerController.h"
#import "KTCImageUploader.h"
#import "NSString+Category.h"

#import "ArticleWriteModel.h"
#import "ArticleHomeModel.h"
#import "ArticleWriteShareModel.h"

#import "ArticleWriteBaseCell.h"
#import "ArticleWriteCategoryCell.h"
#import "ArticleWriteTitleCell.h"
#import "ArticleWriteContentCell.h"
#import "ArticleWriteCoverCell.h"
#import "ArticleWriteImageCell.h"
#import "ArticleWriteBottomView.h"

#import "ArticleWriteAlertSuccessResultViewController.h"
#import "CommonShareViewController.h"
#import "ArticleWritePreviewViewController.h"
#import "ArticleUserCenterViewController.h"
#import "TabBarController.h"
#import "BuryPointManager.h"


static int const kBottomViewHeight = 49;

static NSString *const ArticleWriteBaseCellID     = @"ArticleWriteBaseCellID";
static NSString *const ArticleWriteCategoryCellID = @"ArticleWriteCategoryCellID";
static NSString *const ArticleWriteTitleCellID    = @"ArticleWriteTitleCellID";
static NSString *const ArticleWriteContentCellID  = @"ArticleWriteContentCellID";
static NSString *const ArticleWriteCoverCellID    = @"ArticleWriteCoverCellID";
static NSString *const ArticleWriteImageCellID    = @"ArticleWriteImageCellID";

typedef enum : NSUInteger {
    ArticleWriteViewControllerPickImgTypeCover=1,
    ArticleWriteViewControllerPickImgTypeContent,
} ArticleWriteViewControllerPickImgType;

@interface ArticleWriteViewController ()<UITableViewDelegate,UITableViewDataSource,ArticleWriteBottomViewDelegate,ArticleWriteBaseCellDelegate,TZImagePickerControllerDelegate,ArticleWriteAlertSuccessResultViewControllerDelegate>
@property (nonatomic, weak) UITableView *tableview;
@property (nonatomic, strong) ArticleWriteModel *classModel;
@property (nonatomic, strong) ArticleWriteModel *coverModel;
@property (nonatomic, strong) ArticleWriteModel *titleModel;
@property (nonatomic, strong)NSMutableArray<ArticleWriteModel *> *models;

@property (nonatomic, weak) ArticleWriteBottomView *bottomView;

@property (nonatomic, strong) ArticleHomeClassItem *selectedClassItem;

@property (nonatomic, strong) NSIndexPath *selectedIndexPathPlaceHolder;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;


@property (nonatomic, assign) ArticleWriteViewControllerPickImgType pickImgType;


@property (nonatomic, strong) ArticleWriteShareModel *shareModel;
@end

@implementation ArticleWriteViewController

- (NSMutableArray<ArticleWriteModel *> *)models {
    if (!_models) {
        
        //分类
        _classModel = [ArticleWriteModel modelWith:ArticleWriteModelTypeClass];
        
        //封面
        _coverModel = [ArticleWriteModel modelWith:ArticleWriteModelTypeCover];
        
        //标题
        _titleModel = [ArticleWriteModel modelWith:ArticleWriteModelTypeTitle];
        _titleModel.lineShow = YES;
        _titleModel.font = [UIFont boldSystemFontOfSize:19];
        NSMutableAttributedString *titleAtr = [[NSMutableAttributedString alloc] initWithString:@"请输入标题"];
        titleAtr.color = [UIColor lightGrayColor];
        titleAtr.font = [UIFont boldSystemFontOfSize:19];
        _titleModel.place = titleAtr;
        
        //正文
        ArticleWriteModel *contentModel = [ArticleWriteModel modelWith:ArticleWriteModelTypeContent];
        contentModel.font = [UIFont systemFontOfSize:17];
        NSMutableAttributedString *contentAtr = [[NSMutableAttributedString alloc] initWithString:@"书写心情，让自己的萌宝嗨翻全场"];
        contentAtr.color = [UIColor lightGrayColor];
        contentAtr.font = [UIFont systemFontOfSize:17];
        contentModel.place = contentAtr;
        
        _models = [NSMutableArray arrayWithObjects:_classModel, _coverModel, _titleModel, contentModel,nil];
    }
    return _models;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageId = 10710;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationItem.title = @"编辑心情";
    
    [self prepareClasses];
    
    [self setupNaviItems];
    
    [self setupTableViews];
    
    ArticleWriteBottomView *bottomView = [[NSBundle mainBundle] loadNibNamed:@"ArticleWriteBottomView" owner:self options:nil].lastObject;
    bottomView.frame = CGRectMake(0, SCREEN_HEIGHT-kBottomViewHeight, SCREEN_WIDTH, kBottomViewHeight);
    bottomView.delegate = self;
    [self.view addSubview:bottomView];
    self.bottomView = bottomView;
}

- (void)prepareClasses {
    if (self.classes.count<1) {
        NSMutableArray<ArticleHomeClassItem *> *ary = [NSMutableArray array];
        [self.articleClasses enumerateObjectsUsingBlock:^(ComposeClass  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.SysNo isNotNull] && ![@"0" isEqualToString:obj.SysNo]) {
                ArticleHomeClassItem *item = [[ArticleHomeClassItem alloc] init];
                item.ID = obj.SysNo;
                item.className = obj.ClassName;
                item.selectedIcon = obj.SelectedIcon;
                item.icon = obj.Icon;
                [item modelCustomTransformFromDictionary:nil];
                [ary addObject:item];
                item.selected = ary.count==1;
            }
        }];
        self.classes = [NSArray arrayWithArray:ary];
        
        if (self.classes.count<1) {
            [[iToast makeText:@"暂不支持投稿哟~"] show];
            [self back];
            return;
        }
    }
}

- (void)setupNaviItems {
    self.navigationItem.leftBarButtonItem  = [UIBarButtonItem itemWithTitle:@"取消" postion:UIBarButtonPositionLeft target:self action:@selector(dismiss)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"发布" postion:UIBarButtonPositionRight target:self action:@selector(send)];
}

- (void)dismiss {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"确定离开投稿嘛？" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *makeSure = [UIAlertAction actionWithTitle:@"离开" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self back];
    }];
    [alertController addAction:cancle];
    [alertController addAction:makeSure];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)send {
    [self analysisModels:^(NSArray<UIImage *> *images,NSString *previewTitle,NSArray<ArticleWriteModel *> *previewModels) {
        if (images.count>0) {
            [TCProgressHUD showSVP];
            [[KTCImageUploader sharedInstance] startUploadWithImagesArray:images splitCount:1 withSucceed:^(NSArray *imageUrlStrings) {
                [self uploadImgSuccess:imageUrlStrings];
            } failure:^(NSError *error) {
                [self uploadImgFailure:error];
            }];
        }else{
            [self startSend:nil];
        }
    }];
}

- (void)analysisModels:(void(^)(NSArray<UIImage *> *images, NSString *previewTitle, NSArray<ArticleWriteModel *> *previewModels))resultBlock {
    
    if (!_selectedClassItem) {
        [[iToast makeText:@"请选择类别"] show];
        return;
    }
    if (![_titleModel.words.string isNotNull]) {
        [[iToast makeText:@"请填写标题"] show];
        return;
    }
    __block BOOL hasContent = NO;
    NSMutableArray<UIImage *> *images = [NSMutableArray array];
    __block NSString *previewTitle = @"";
    NSMutableArray<ArticleWriteModel *> *previewModels = [NSMutableArray array];
    [self.models enumerateObjectsUsingBlock:^(ArticleWriteModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.image) [images addObject:obj.image];
        if (obj.type == ArticleWriteModelTypeTitle) {
            previewTitle = obj.words.string;
        }else if (obj.type == ArticleWriteModelTypeContent ||
                  obj.type == ArticleWriteModelTypeImage) {
            if (obj.image || [obj.words.string isNotNull]) {
                hasContent = YES;
                [previewModels addObject:obj.copy];
            }
        }else if (obj.type == ArticleWriteModelTypeCover) {
            
        }
    }];
    if (!hasContent) {
        [[iToast makeText:@"请填写文章内容"] show];
        return;
    }
    resultBlock(images,previewTitle,previewModels);
}

- (void)uploadImgSuccess:(NSArray *)imageUrlStrings {
    [self startSend:imageUrlStrings];
}

- (void)uploadImgFailure:(NSError *)error {
    [TCProgressHUD dismissSVP];
    [[iToast makeText:@"图片上传失败，请重试！"] show];
    [self trackFailure];
}

- (NSDictionary *)paramWith:(NSArray *)imageUrlStrings {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    NSString *title = _titleModel.words.string;
    if ([title isNotNull]) {
        [param setValue:title forKey:@"title"];
    }
    
    NSString *articleClass = _selectedClassItem.ID;
    if ([articleClass isNotNull]) {
        [param setValue:articleClass forKey:@"articleClass"];
    }
    
    if (imageUrlStrings.count>0 && _coverModel.image) {
        NSString *coverImgUrl = imageUrlStrings[0];
        if ([coverImgUrl isNotNull]) {
            [param setValue:coverImgUrl forKey:@"image"];
        }
    }
    
    NSString *contentJson = [self contentJson:imageUrlStrings];
    if ([contentJson isNotNull]) {
        [param setValue:contentJson forKey:@"contentJson"];
    }
    return param;
}

- (NSString *)contentJson:(NSArray *)imageUrlStrings {
    
    NSMutableString *content = [NSMutableString string];
    __block int index = 1;
    __block int imgIndex = _coverModel.image?1:0;
    [self.models enumerateObjectsUsingBlock:^(ArticleWriteModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        switch (obj.type) {
            case ArticleWriteModelTypeContent:
            {
                if (obj.words.length>0) {
                    NSMutableDictionary *contentItemDic = [NSMutableDictionary dictionary];
                    [contentItemDic setValue:@"2" forKey:@"ContentDetailType"];
                    [contentItemDic setValue:@(index++) forKey:@"SortNo"];
                    [contentItemDic setValue:obj.words.string forKey:@"Content"];
                    
                    NSString *jsonString = contentItemDic.jsonStringEncoded;
                    if ([jsonString isNotNull]) {
                        [content appendFormat:@"%@,",jsonString];
                    }
                }
            }
                break;
            case ArticleWriteModelTypeImage:
            {
                if (imageUrlStrings.count>imgIndex) {
                    NSString *imgUrl = imageUrlStrings[imgIndex++];
                    if ([imgUrl isNotNull]) {
                        NSMutableDictionary *imgItemDic = [NSMutableDictionary dictionary];
                        [imgItemDic setValue:@"4" forKey:@"ContentDetailType"];
                        [imgItemDic setValue:@(index++) forKey:@"SortNo"];
                        [imgItemDic setValue:imgUrl forKey:@"ImgUrl"];
                        
                        NSString *jsonString = imgItemDic.jsonStringEncoded;
                        if ([jsonString isNotNull]) {
                            [content appendFormat:@"%@,",jsonString];
                        }
                    }
                }
            }
                break;
            default:break;
        }
    }];
    
    if ([content isNotNull]) {
        NSRange range = [content rangeOfString:@"," options:NSBackwardsSearch];
        [content deleteCharactersInRange:range];
        NSMutableString *contentJson = [NSMutableString stringWithFormat:@"[%@]",content];
        return [contentJson isNotNull]?contentJson:nil;
    }else{
        return nil;
    }
}

- (void)startSend:(NSArray *)imageUrlStrings{
    [TCProgressHUD showSVP];
    NSDictionary *param =  [self paramWith:imageUrlStrings];
    [Request startWithName:@"ARTICLE_USER_EDIT" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [self sendSuccess:[ArticleWriteShareModel modelWithDictionary:dic]];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self sendFailure];
    }];
}

- (void)sendSuccess:(ArticleWriteShareModel *)model {
    [TCProgressHUD dismissSVP];
    self.shareModel = model;
    self.models = nil;
    [_tableview reloadData];
    ArticleWriteAlertSuccessResultViewController *controller = [[ArticleWriteAlertSuccessResultViewController alloc] initWithNibName:@"ArticleWriteAlertSuccessResultViewController" bundle:nil];
    controller.delegate = self;
    controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    controller.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:controller animated:NO completion:nil];
    [self trackSuccecss];
}

- (void)sendFailure {
    [TCProgressHUD dismissSVP];
    [[iToast makeText:@"发表失败!"] show];
    [self trackFailure];
}

- (void)trackSuccecss {
    NSMutableDictionary *trackParams = [@{@"result":@"1"} mutableCopy];
    NSString *articleClass = _selectedClassItem.ID;
    if ([articleClass isNotNull]) {
        [trackParams setValue:articleClass forKey:@"tagId"];
    }
    [BuryPointManager trackEvent:@"event_result_contribute_commit" actionId:21102 params:trackParams];
}

- (void)trackFailure {
    NSMutableDictionary *trackParams = [@{@"result":@"2"} mutableCopy];
    NSString *articleClass = _selectedClassItem.ID;
    if ([articleClass isNotNull]) {
        [trackParams setValue:articleClass forKey:@"tagId"];
    }
    [BuryPointManager trackEvent:@"event_result_contribute_commit" actionId:21102 params:trackParams];
}


#pragma mark - ArticleWriteAlertSuccessResultViewControllerDelegate

- (void)articleWriteAlertSuccessResultViewController:(ArticleWriteAlertSuccessResultViewController *)controller actionType:(ArticleWriteAlertSuccessResultBtnType)type {

    switch (type) {
        case ArticleWriteAlertSuccessResultBtnTypeWriteMore:
        {
            //[_tableview reloadData];
        }
            break;
        case ArticleWriteAlertSuccessResultBtnTypeShare:
        {
            [self share];
        }
            break;
        case ArticleWriteAlertSuccessResultBtnTypeMakeSure:
        {
            [self back];
            ArticleUserCenterViewController *controller = [[ArticleUserCenterViewController alloc]init];
            TabBarController *tabBarController = [TabBarController shareTabBarController];
            UINavigationController *navi = tabBarController.selectedViewController;
            [navi pushViewController:controller animated:YES];
        }
            break;
    }
}

- (void)share {
    
    ArticleWriteShareData *data = self.shareModel.data;
    if (!data) return;
    NSString *title = data.title;
    if (![title isNotNull]) return;
    NSString *desc = data.desc;
    if (![desc isNotNull]) return;
    NSString *imgUrl = data.imgUrl;
    if (![imgUrl isNotNull]) return;
    NSString *urlStr = data.linkUrl;
    if (![urlStr isNotNull]) return;
    CommonShareObject *obj = [CommonShareObject shareObjectWithTitle:title description:desc thumbImageUrl:[NSURL URLWithString:imgUrl] urlString:urlStr];
    obj.followingContent = @"【童成网】";
    if(obj) [self shareWithObj:obj];
}

- (void)shareWithObj:(CommonShareObject *)obj {
    CommonShareViewController *controller = [CommonShareViewController instanceWithShareObject:obj sourceType:KTCShareServiceTypeNews];
    [self presentViewController:controller animated:YES completion:nil];
}



- (void)setupTableViews {
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    tableview.contentInset = UIEdgeInsetsMake(64, 0, kBottomViewHeight, 0);
    tableview.scrollIndicatorInsets = tableview.contentInset;
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.estimatedRowHeight = 44.0f;
    tableview.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableview];
    _tableview = tableview;
    
    [tableview registerClass:[ArticleWriteBaseCell class] forCellReuseIdentifier:ArticleWriteBaseCellID];
    [tableview registerNib:[UINib nibWithNibName:@"ArticleWriteCategoryCell" bundle:nil] forCellReuseIdentifier:ArticleWriteCategoryCellID];
    [tableview registerNib:[UINib nibWithNibName:@"ArticleWriteTitleCell" bundle:nil] forCellReuseIdentifier:ArticleWriteTitleCellID];
    [tableview registerNib:[UINib nibWithNibName:@"ArticleWriteContentCell" bundle:nil] forCellReuseIdentifier:ArticleWriteContentCellID];
    [tableview registerNib:[UINib nibWithNibName:@"ArticleWriteCoverCell" bundle:nil] forCellReuseIdentifier:ArticleWriteCoverCellID];
    [tableview registerNib:[UINib nibWithNibName:@"ArticleWriteImageCell" bundle:nil] forCellReuseIdentifier:ArticleWriteImageCellID];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ArticleWriteModel *model = self.models[indexPath.row];
    NSString *ID = [self IdWith:model.type];
    ArticleWriteBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.delegate = self;
    cell.indexPath = indexPath;
    cell.classes = _classes;
    cell.model = model;
    return cell;
}

- (NSString *)IdWith:(ArticleWriteModelType)type {
    NSString *ID = ArticleWriteBaseCellID;
    switch (type) {
        case ArticleWriteModelTypeClass:
        {
            ID = ArticleWriteCategoryCellID;
        }
            break;
        case ArticleWriteModelTypeTitle:
        {
            ID = ArticleWriteTitleCellID;
        }
            break;
        case ArticleWriteModelTypeContent:
        {
            ID = ArticleWriteContentCellID;
        }
            break;
        case ArticleWriteModelTypeCover:
        {
            ID = ArticleWriteCoverCellID;
        }
            break;
        case ArticleWriteModelTypeImage:
        {
            ID = ArticleWriteImageCellID;
        }
            break;
        default:
        {
            ID = ArticleWriteBaseCellID;
        }
            break;
    }
    return ID;
}

#pragma mark - ArticleWriteBottomView

- (void)articleWriteBottomView:(ArticleWriteBottomView *)view actionType:(ArticleWriteBottomViewActionType)type {
    switch (type) {
        case ArticleWriteBottomViewActionTypePicture:
        {
            self.selectedIndexPath = self.selectedIndexPathPlaceHolder;
            [self pickImg:ArticleWriteViewControllerPickImgTypeContent];
        }
            break;
        case ArticleWriteBottomViewActionTypePreview:
        {
            [self analysisModels:^(NSArray<UIImage *> *images, NSString *previewTitle, NSArray<ArticleWriteModel *> *previewModels) {
                ArticleWritePreviewViewController *controller = [[ArticleWritePreviewViewController alloc] init];
                controller.navigationItem.title = previewTitle;
                controller.models = previewModels;
                [self.navigationController pushViewController:controller animated:YES];
            }];
            [BuryPointManager trackEvent:@"event_skip_contribute_preview" actionId:21101 params:nil];
        }
            break;
        default:break;
    }
}

#pragma mark - ArticleWriteBaseCellDelegate

- (void)articleWriteBaseCell:(ArticleWriteBaseCell *)cell actionType:(ArticleWriteBaseCellActionType)type value:(id)value {
    switch (type) {
        case ArticleWriteBaseCellActionTypeSelectClass:
        {
            self.selectedClassItem = (ArticleHomeClassItem *)value;
        }
            break;
        case ArticleWriteBaseCellActionTypeSelectCover:
        {
            [self pickImg:ArticleWriteViewControllerPickImgTypeCover];
        }
            break;
        case ArticleWriteBaseCellActionTypeDeletContentImage:
        {
            [self deletePic:cell.indexPath];
        }
            break;
        case ArticleWriteBaseCellActionTypeTextViewDidBeginEditing:
        {
            NSIndexPath *cellIndex = cell.indexPath;
            if (cellIndex.row>2) {
                self.selectedIndexPathPlaceHolder = cellIndex;
            }else{
                self.selectedIndexPathPlaceHolder = nil;
            }
            [_tableview scrollToRowAtIndexPath:cellIndex atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        }
            break;
        case ArticleWriteBaseCellActionTypeTextViewDidChange:
        {
//            CGFloat space = [value floatValue];
//            CGPoint offSet = _tableview.contentOffset;
//            offSet.y += space;
//            _tableview.contentOffset = offSet;
        }
            break;
        case ArticleWriteBaseCellActionTypeTextViewDidEndEditing:
        {
            [_tableview reloadData];
            self.selectedIndexPathPlaceHolder = nil;
        }
            break;
        default:break;
    }
}

- (void)deletePic:(NSIndexPath *)indexPath {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"将此照片从文章中删除？" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *makeSure = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        ArticleWriteModel *topContentModel = self.models[indexPath.row-1];
        ArticleWriteModel *bottomContentModel = self.models[indexPath.row+1];
        NSMutableAttributedString *words = [[NSMutableAttributedString alloc]init];
        if (topContentModel.words.length>0) {
            [words appendAttributedString:topContentModel.words];
        }
        if (bottomContentModel.words) {
            [words appendAttributedString:bottomContentModel.words];
        }
        topContentModel.words = words;
        
        
        [self.models removeObjectsInRange:NSMakeRange(indexPath.row, 2)];
        
        NSIndexPath *cellIndex = indexPath;
        NSIndexPath *bottomIndex = [NSIndexPath indexPathForRow:cellIndex.row+1 inSection:cellIndex.section];
        [_tableview deleteRowsAtIndexPaths:@[cellIndex,bottomIndex] withRowAnimation:UITableViewRowAnimationLeft];
        
        NSIndexPath *topIndex = [NSIndexPath indexPathForRow:cellIndex.row-1 inSection:cellIndex.section];
        [_tableview reloadRowAtIndexPath:topIndex withRowAnimation:UITableViewRowAnimationNone];
    }];
    [alertController addAction:cancle];
    [alertController addAction:makeSure];
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark Keyboard Notification
- (void)keyboardWillShow:(NSNotification *)notification{
    [super keyboardWillShow:notification];
    [self changeBottomViewFrameWithEffectHeight:self.keyboardHeight];
    [self changeTableViewFrameWithEffectHeight:self.keyboardHeight];
}
- (void)keyboardWillDisappear:(NSNotification *)notification {
    [super keyboardWillDisappear:notification];
    [self changeBottomViewFrameWithEffectHeight:0];
    [self changeTableViewFrameWithEffectHeight:0];
}

- (void)changeBottomViewFrameWithEffectHeight:(CGFloat)height {
    CGRect frame = _bottomView.frame;
    frame.origin.y = SCREEN_HEIGHT - height - CGRectGetHeight(frame);
    self.bottomView.frame = frame;
}

- (void)changeTableViewFrameWithEffectHeight:(CGFloat)height {
    CGRect frame = _tableview.frame;
    frame.size.height = SCREEN_HEIGHT - height;
    [UIView animateWithDuration:0.3 animations:^{
        _tableview.frame = frame;
    }];
}

#pragma mark - 选取图片

- (void)pickImg:(ArticleWriteViewControllerPickImgType)type {

    NSUInteger count = [self toSelCount:type];
    if (count<=0||count>10) {
        [[iToast makeText:@"已达到最大照片数量,请删除照片后再添加"] show];
        return;
    }
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:count columnNumber:4 delegate:self];
    imagePickerVc.allowPickingVideo = NO;
    [self presentViewController:imagePickerVc animated:YES completion:nil];
    
    self.pickImgType = type;
}

- (NSUInteger)toSelCount:(ArticleWriteViewControllerPickImgType)type {
    switch (type) {
        case ArticleWriteViewControllerPickImgTypeCover:
        {
            return 1;
        }
            break;
            
        case ArticleWriteViewControllerPickImgTypeContent:
        {
            return 10 - self.currentContentImgCount;
        }
            break;
    }
}

- (int)currentContentImgCount {
    __block int count = 0;
    [self.models enumerateObjectsUsingBlock:^(ArticleWriteModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.type == ArticleWriteModelTypeImage) {
            count++;
        }
    }];
    return count;
}

#pragma mark - TZImagePickerControllerDelegate

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    [self finishPickImg:photos];
}

#pragma mark TZImagePickerControllerDelegate helpers

- (void)finishPickImg:(NSArray *)photos {
    switch (self.pickImgType) {
        case ArticleWriteViewControllerPickImgTypeCover:
        {
            [self finishPickImgCover:photos];
        }
            break;
        case ArticleWriteViewControllerPickImgTypeContent:
        {
            [self finishPickImgContent:photos];
        }
            break;
    }
}

- (void)finishPickImgCover:(NSArray *)photos {
    
    if (photos.count>0) {
        UIImage *img = photos[0];
        if ([img isKindOfClass:[UIImage class]]) {
            _coverModel.image = img;
            [_tableview reloadRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] withRowAnimation:UITableViewRowAnimationNone];
        }
    }
}

- (void)finishPickImgContent:(NSArray *)photos {
    NSUInteger index = _selectedIndexPath?_selectedIndexPath.row+1:self.models.count;
    [self insertAtIndex:index imgAry:photos];
}

- (void)insertAtIndex:(NSUInteger)index imgAry:(NSArray<UIImage *> *)imgAry {
    NSMutableArray *arys = [NSMutableArray array];
    [imgAry enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ArticleWriteModel *imgModel = [ArticleWriteModel modelWith:ArticleWriteModelTypeImage];
        imgModel.image = obj;
        [arys addObject:imgModel];
        ArticleWriteModel *contentModel = [ArticleWriteModel modelWith:ArticleWriteModelTypeContent];
        contentModel.font = [UIFont systemFontOfSize:17];
        [arys addObject:contentModel];
    }];
    [self.models insertObjects:arys atIndex:index];
    [_tableview reloadData];
}

@end
