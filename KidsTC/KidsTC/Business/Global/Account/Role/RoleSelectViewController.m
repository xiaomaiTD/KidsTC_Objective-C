//
//  TCUserRoleSelectViewController.m
//  KidsTC
//
//  Created by zhanping on 5/3/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "RoleSelectViewController.h"
#import "UIButton+Category.h"
#import "User.h"
#import "UIBarButtonItem+Category.h"

typedef enum {
    RoleTypeSelectTagZeroToOne,
    RoleTypeSelectTagTwoToThree,
    RoleTypeSelectTagFourToSix,
    RoleTypeSelectTagSevenToTwelve
}RoleTypeSelectTag;

typedef enum {
    RoleSexSelectTagBoy,
    RoleSexSelectTagGirl
}RoleSexSelectTag;

@interface RoleSelectViewController ()
@property (nonatomic, assign) RoleTypeSelectTag typeTag;
@property (nonatomic, assign) RoleSexSelectTag sexTag;
@property (nonatomic, assign) NSInteger currentSelectedIndex;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *attachments;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;

@end

@implementation RoleSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"请选择阶段";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.scrollView = (UIScrollView *)self.view;
    self.nextBtn.layer.cornerRadius = 25;
    self.nextBtn.layer.masksToBounds = YES;
    
    Role *role = [User shareUser].role;
    if (role) {
        [self resetCurrentSelectedIndexWith:role];
    }else{
        [(UIImageView *)self.attachments[0] setHidden:NO];
        self.currentSelectedIndex = 0;
    };
    
    //second
    self.backButton.layer.cornerRadius = 25;
    self.backButton.layer.masksToBounds = YES;
    [self.backButton setBackgroundColor:COLOR_PINK forState:UIControlStateNormal];
    [self.backButton setBackgroundColor:COLOR_PINK forState:UIControlStateSelected];
    self.doneButton.layer.cornerRadius = 25;
    self.doneButton.layer.masksToBounds = YES;
    [self.doneButton setBackgroundColor:COLOR_PINK forState:UIControlStateNormal];
    [self.doneButton setBackgroundColor:COLOR_PINK forState:UIControlStateSelected];
    
    [self.leftImageView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickedSexImage:)];
    [self.leftImageView addGestureRecognizer:tap1];
    
    [self.rightImageView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickedSexImage:)];
    [self.rightImageView addGestureRecognizer:tap2];
    
    [self selectSexWithTag:self.leftImageView.tag];
}

- (BOOL)prefersStatusBarHidden{
    return NO;
}

- (void)back{
    [super back];
    if (self.resultBlock) self.resultBlock();
}

- (void)resetCurrentSelectedIndexWith:(Role *)role {
    NSUInteger index = 0;
    switch (role.type) {
        case RoleTypeZeroToOne:
        {
            index = 0;
        }
            break;
        case RoleTypeTwoToThree:
        {
            index = 1;
        }
            break;
        case RoleTypeFourToSix:
        {
            index = 2;
        }
            break;
        case RoleTypeSevenToTwelveMale:
        {
            index = 3;
        }
            break;
        default:
            break;
    }
    [(UIImageView *)self.attachments[index] setHidden:NO];
    self.currentSelectedIndex = index;
}

/**
 *  选择年龄
 */
- (IBAction)selectAction:(UIButton *)sender {

    [(UIImageView *)self.attachments[self.currentSelectedIndex] setHidden:YES];
    [(UIImageView *)self.attachments[sender.tag] setHidden:NO];
    self.currentSelectedIndex = sender.tag;
}
/**
 *  下一步
 */
- (IBAction)nextAction:(UIButton *)sender {
    self.typeTag = (RoleTypeSelectTag)self.currentSelectedIndex;
    if (self.typeTag == RoleTypeSelectTagZeroToOne) {
        [self finishedUserRoleSelecting];
    } else {
        [self resetSecondView];
        [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:YES];
    }
}

/**
 *  选择性别
 */
- (void)didClickedSexImage:(UITapGestureRecognizer *)sender {
    [self selectSexWithTag:sender.view.tag];
}
- (void)selectSexWithTag:(NSUInteger)tag {
    if (tag == self.leftImageView.tag) {
        self.sexTag = RoleSexSelectTagBoy;
        [self.leftImageView setAlpha:1];
        [self.rightImageView setAlpha:0.3];
    } else if (tag == self.rightImageView.tag) {
        self.sexTag = RoleSexSelectTagGirl;
        [self.leftImageView setAlpha:0.3];
        [self.rightImageView setAlpha:1];
    }
}

/**
 *  上一步
 */
- (IBAction)lastAction:(UIButton *)sender {
    
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}
/**
 *  完成
 */
- (IBAction)doneAction:(UIButton *)sender {
    [self finishedUserRoleSelecting];
}

/**
 *  重新设置第二个视图的图片
 */
- (void)resetSecondView {
    switch (self.typeTag) {

        case RoleTypeSelectTagTwoToThree:
        {
            [self.leftImageView setImage:[UIImage imageNamed:@"sexselect_boy_1"]];
            [self.rightImageView setImage:[UIImage imageNamed:@"sexselect_girl_1"]];
        }
            break;
        case RoleTypeSelectTagFourToSix:
        {
            [self.leftImageView setImage:[UIImage imageNamed:@"sexselect_boy_123"]];
            [self.rightImageView setImage:[UIImage imageNamed:@"sexselect_girl_123"]];
        }
            break;
        case RoleTypeSelectTagSevenToTwelve:
        {
            [self.leftImageView setImage:[UIImage imageNamed:@"sexselect_boy_426"]];
            [self.rightImageView setImage:[UIImage imageNamed:@"sexselect_girl_426"]];
        }
            break;
        default:
            break;
    }
}

/**
 * 用户角色选择完毕
 */
- (void)finishedUserRoleSelecting {
    RoleType roleType = RoleTypeUnknown;
    switch (self.typeTag) {
        case RoleTypeSelectTagZeroToOne:
        {
            roleType = RoleTypeZeroToOne;
        }
            break;
        case RoleTypeSelectTagTwoToThree:
        {
            roleType = RoleTypeTwoToThree;
        }
            break;
        case RoleTypeSelectTagFourToSix:
        {
            roleType = RoleTypeFourToSix;
        }
            break;
        case RoleTypeSelectTagSevenToTwelve:
        {
            roleType = RoleTypeSevenToTwelveMale;
        }
            break;
        default:
            break;
    }
    
    RoleSex roleSex = (RoleSex)(self.sexTag+1);
    Role *role = [Role instanceWithType:roleType sex:roleSex];
    if ([role roleIdentifier] != [[User shareUser].role roleIdentifier]) {
        [User shareUser].role = role;
        [[User shareUser] updateUserPopulation];
    }
    
    [self back];
}



@end
