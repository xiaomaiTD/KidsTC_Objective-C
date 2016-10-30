//
//  SoftwareSettingViewController.m
//  KidsTC
//
//  Created by zhanping on 7/26/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "SoftwareSettingViewController.h"
#import "SoftwareSettingViewCell.h"
#import "SoftwareSettingModel.h"
#import "SDWebImageManager.h"
#import "WebViewController.h"
#import "TCProgressHUD.h"
#import "iToast.h"
@interface SoftwareSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSArray<SoftwareSettingModel *> *ary;
@end
static NSString *SoftwareSettingViewCellID = @"SoftwareSettingViewCellID";
@implementation SoftwareSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageId = 10907;
    
    self.navigationItem.title = @"设置";
    
    [self initTableView];
    
    [self reloadData];
}

- (void)initTableView{
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerNib:[UINib nibWithNibName:@"SoftwareSettingViewCell" bundle:nil] forCellReuseIdentifier:SoftwareSettingViewCellID];
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

#ifdef DEBUG
#define DEBUGESTR @"-debug"
#else
#define DEBUGESTR @""
#endif

- (void)reloadData{
    SoftwareSettingModel *model0 = [SoftwareSettingModel modelWithTitle:@"清理图片缓存"
                                                               subTitle:self.currentImageCacheVolumStr
                                                              showArrow:YES
                                                                    sel:@selector(cleanSDWebCache)];
    SoftwareSettingModel *model1 = [SoftwareSettingModel modelWithTitle:@"当前版本"
                                                               subTitle:[NSString stringWithFormat:@"v%@%@",APP_VERSION,DEBUGESTR]
                                                              showArrow:NO
                                                                    sel:nil];
    SoftwareSettingModel *model2 = [SoftwareSettingModel modelWithTitle:@"关于我们"
                                                               subTitle:nil
                                                              showArrow:YES
                                                                    sel:@selector(aboutUs)];
    SoftwareSettingModel *model3 = [SoftwareSettingModel modelWithTitle:@"联系我们"
                                                               subTitle:nil
                                                              showArrow:YES
                                                                    sel:@selector(contactUs)];
    self.ary = @[model0,model1,model2,model3];
    
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.ary.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SoftwareSettingViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SoftwareSettingViewCellID];
    cell.model = self.ary[indexPath.section];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SEL sel = self.ary[indexPath.section].sel;
    if ([self respondsToSelector:sel]) [self performSelector:sel withObject:nil afterDelay:0.0];
}

#pragma mark - private

- (NSString *)currentImageCacheVolumStr{
    NSUInteger intg = [[SDImageCache sharedImageCache] getSize];
    return [NSString stringWithFormat:@"%@",[self fileSizeWithInterge:intg]];
}

- (NSString *)fileSizeWithInterge:(NSInteger)size{
    if (size < 1024) {
        return [NSString stringWithFormat:@"%ldB",(long)size];
    }else if (size < 1024 * 1024){
        CGFloat aFloat  = size*1.0/1024;
        return [NSString stringWithFormat:@"%.0fK",aFloat];
    }else if (size < 1024 * 1024 * 1024){
        CGFloat aFloat  = size*1.0/(1024 * 1024);
        return [NSString stringWithFormat:@"%.1fM",aFloat];
    }else{
        CGFloat aFloat  = size*1.0/(1024*1024*1024);
        return [NSString stringWithFormat:@"%.1fG",aFloat];
    }
}

#pragma mark - actions

- (void)cleanSDWebCache{
    
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [TCProgressHUD showSVP];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
                [TCProgressHUD dismissSVP];
                [iToast makeText:@"缓存清理成功"];
                SoftwareSettingModel *model0 = self.ary[0];
                model0.subTitle = self.currentImageCacheVolumStr;
                [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            }];
        });
    }];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertController *alertViewController =[UIAlertController alertControllerWithTitle:@"提示" message:@"确定清理缓存？" preferredStyle:UIAlertControllerStyleAlert];
    [alertViewController addAction:sure];
    [alertViewController addAction:cancle];
    [self presentViewController:alertViewController animated:YES completion:nil];
}

- (void)aboutUs{
    WebViewController *controller = [[WebViewController alloc] init];
    controller.urlString = @"http://m.kidstc.com/tools/about_us";
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)contactUs{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://021-51135015"]];
}

@end
