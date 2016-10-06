//
//  FDHeaderView.m
//  KidsTC
//
//  Created by zhanping on 5/17/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "FDHeaderView.h"
#import "FlashDetailAutoRollView.h"
// 只要添加了这个宏，就不用带mas_前缀
#define MAS_SHORTHAND
// 只要添加了这个宏，equalTo就等价于mas_equalTo
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"
#import "ToolBox.h"

#define FDHeaderViewMargin 12
#define mapaddrLabelRectHight 30
#define SmallIconSize 15


#define PriceConfigitemViewSize (SCREEN_WIDTH - 4*FDHeaderViewMargin)/3.5
#define FDTipLeftIconWidth 4
#define FDNoteViewAuthorHeaderImageViewSize 40

#define Flash_Pink_Color [UIColor colorWithRed:1  green:0.600  blue:0.714 alpha:1]


@interface FDNoteView ()
@property (nonatomic, weak) UIImageView *authorHeaderImageView;
@property (nonatomic, weak) UILabel *authorNameLabel;
@property (nonatomic, weak) UILabel *noteLabel;
@end
@implementation FDNoteView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *authorHeaderImageView = [[UIImageView alloc]init];
        authorHeaderImageView.layer.cornerRadius = FDNoteViewAuthorHeaderImageViewSize*0.5;
        authorHeaderImageView.layer.masksToBounds = YES;
        [self addSubview:authorHeaderImageView];
        
        UILabel *authorNameLabel = [[UILabel alloc]init];
        authorNameLabel.numberOfLines = 0;
        authorNameLabel.textColor = [UIColor lightGrayColor];
        authorNameLabel.font = [UIFont systemFontOfSize:15];
        authorNameLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:authorNameLabel];
        
        UILabel *noteLabel = [[UILabel alloc]init];
        noteLabel.numberOfLines = 0;
        noteLabel.textColor = [UIColor lightGrayColor];
        noteLabel.font = [UIFont systemFontOfSize:15];
        //noteLabel.contentMode = UIViewContentModeTopLeft;
        [self addSubview:noteLabel];
        
        self.authorHeaderImageView = authorHeaderImageView;
        self.authorNameLabel = authorNameLabel;
        self.noteLabel = noteLabel;
        
        CGFloat margin = FDHeaderViewMargin;
        [authorHeaderImageView makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(FDNoteViewAuthorHeaderImageViewSize, FDNoteViewAuthorHeaderImageViewSize));
            make.left.equalTo(margin);
            make.top.equalTo(margin);
        }];
        [authorNameLabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(authorHeaderImageView.centerX);
            make.top.equalTo(authorHeaderImageView.bottom).offset(margin);
            make.left.equalTo(authorHeaderImageView.left).offset(-margin);
            make.right.equalTo(authorHeaderImageView.right).offset(margin);
        }];
        [noteLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(margin);
            make.left.equalTo(authorHeaderImageView.right).offset(margin);
            make.right.equalTo(-margin);
            make.bottom.greaterThanOrEqualTo(authorNameLabel);
        }];
        
        [self makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(SCREEN_WIDTH);
            make.bottom.equalTo(noteLabel).offset(margin);
        }];
        
    }
    return self;
}
- (void)setNote:(FDNote *)note{
    _note = note;
    [self.authorHeaderImageView sd_setImageWithURL:[NSURL URLWithString:note.imgUrl] placeholderImage:PLACEHOLDERIMAGE_SMALL];
    self.authorNameLabel.text = note.name;
    self.noteLabel.text = note.note;
}
@end

/**
 *  购买须知
 */
@interface FDPurchaseNotesTipView : UIView
@end
@implementation FDPurchaseNotesTipView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *leftIcon = [[UIImageView alloc] init];
        leftIcon.backgroundColor = Flash_Pink_Color;
        [self addSubview:leftIcon];
        
        UILabel *titleL = [[UILabel alloc] init];
        titleL.textColor = [UIColor darkGrayColor];
        titleL.text = @"购买须知";
        titleL.font = [UIFont systemFontOfSize:15];
        [self addSubview:titleL];
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:line];
        
        CGFloat margin = FDHeaderViewMargin;
        
        [leftIcon makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(FDTipLeftIconWidth, SmallIconSize));
            make.left.equalTo(0);
            make.centerY.equalTo(self.centerY);
        }];
        
        [titleL makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(leftIcon.right).offset(margin-FDTipLeftIconWidth);
            make.centerY.equalTo(self.centerY);
        }];
        
        [line makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH, LINE_H));
            make.left.equalTo(0);
            make.bottom.equalTo(0);
        }];
    }
    return self;
}
@end
@interface FDPurchaseNotesView ()
@property (nonatomic, weak) UILabel *notesL;
@end
@implementation FDPurchaseNotesView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        FDPurchaseNotesTipView *tipView = [[FDPurchaseNotesTipView alloc]init];
        [self addSubview:tipView];
        
        UILabel *notesL = [[UILabel alloc]init];
        notesL.textColor = [UIColor lightGrayColor];
        notesL.font = [UIFont systemFontOfSize:15];
        notesL.numberOfLines = 0;
        [self addSubview:notesL];
        self.notesL = notesL;
        CGFloat margin = FDHeaderViewMargin;
        [tipView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(0);
            make.left.equalTo(0);
            make.right.equalTo(0);
            make.height.equalTo(30);
        }];
        
        [notesL makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(tipView.bottom).offset(margin);
            make.left.equalTo(margin);
            make.right.equalTo(-margin);
        }];
        
        [self makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(SCREEN_WIDTH);
            make.bottom.equalTo(notesL.bottom).offset(margin);
        }];
        
    }
    return self;
}
-(void)setBuyNotice:(NSArray<FDBuyNoticeItem *> *)buyNotice{
    _buyNotice = buyNotice;
    
    NSMutableString *notesString = [[NSMutableString alloc]init];
    NSInteger totalCount = [buyNotice count];
    [buyNotice enumerateObjectsUsingBlock:^(FDBuyNoticeItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *noteString = [NSString stringWithFormat:@"%@: %@",obj.clause,obj.notice];
        [notesString appendString:noteString];
        if (idx != totalCount-1)[notesString appendString:@"\n"];
    }];
    
    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc]init];
    para.lineSpacing = 8;
    NSDictionary *att = @{NSForegroundColorAttributeName:[UIColor lightGrayColor],
                          NSFontAttributeName:[UIFont systemFontOfSize:13],
                          NSParagraphStyleAttributeName:para};
    NSMutableAttributedString *attNotesString = [[NSMutableAttributedString alloc]initWithString:notesString attributes:att];
    
    self.notesL.attributedText = attNotesString;
}
@end

/**
 *  简介
 */
@interface FDBriefIntroductionView ()
@property (nonatomic, weak) UILabel *contentL;
@end
@implementation FDBriefIntroductionView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UILabel *contentL = [[UILabel alloc] init];
        contentL.numberOfLines = 0;
        contentL.font = [UIFont systemFontOfSize:15];
        contentL.textColor = [UIColor darkGrayColor];
        [self addSubview:contentL];
        self.contentL = contentL;
        CGFloat margin = FDHeaderViewMargin;
        [contentL makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(margin);
            make.left.equalTo(margin);
            make.right.equalTo(-margin);
            make.bottom.equalTo(-margin);
        }];
        [self makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(SCREEN_WIDTH);
            make.bottom.equalTo(contentL).offset(margin);
        }];
    }
    return self;
}
-(void)setContentString:(NSString *)contentString{
    _contentString = contentString;
    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc]init];
    para.lineSpacing = 8;
    NSDictionary *att = @{NSForegroundColorAttributeName:[UIColor darkGrayColor],
                          NSFontAttributeName:[UIFont systemFontOfSize:15],
                          NSParagraphStyleAttributeName:para};
    NSMutableAttributedString *attContentString = [[NSMutableAttributedString alloc]initWithString:contentString attributes:att];
    self.contentL.attributedText = attContentString;
}
@end

/**
 *  闪购流程
 */
@class FDFlowTipView;
@protocol FDFlowTipViewDelegate <NSObject>
- (void)flowTipView:(FDFlowTipView *)flowTipView didClickOnTitLabel:(UILabel *)label;
@end
@interface FDFlowTipView : UIView
@property (nonatomic, weak) UIImageView *leftIcon;
@property (nonatomic, weak) UIImageView *rightIcon;
@property (nonatomic, weak) UILabel *titleL;
@property (nonatomic, weak) UILabel *titL;
@property (nonatomic, weak) id<FDFlowTipViewDelegate> delegate;
@end
@implementation FDFlowTipView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *leftIcon = [[UIImageView alloc] init];
        leftIcon.backgroundColor = Flash_Pink_Color;
        [self addSubview:leftIcon];
        
        UILabel *titleL = [[UILabel alloc] init];
        titleL.textColor = [UIColor darkGrayColor];
        titleL.text = @"闪购流程";
        titleL.font = [UIFont systemFontOfSize:15];
        [self addSubview:titleL];
        
        UIImageView *rightIcon = [[UIImageView alloc] init];
        rightIcon.image = [UIImage imageNamed:@"arrow_r"];
        [self addSubview:rightIcon];
        
        UILabel *titL = [[UILabel alloc] init];
        titL.textColor = [UIColor lightGrayColor];
        titL.font = [UIFont systemFontOfSize:15];
        titL.text = @"规则明细";
        [self addSubview:titL];
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:line];
        
        self.leftIcon = leftIcon;
        self.titleL = titleL;
        self.rightIcon = rightIcon;
        self.titL = titL;
        
        
        CGFloat margin = FDHeaderViewMargin;
        
        [leftIcon makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(FDTipLeftIconWidth, SmallIconSize));
            make.left.equalTo(0);
            make.centerY.equalTo(self.centerY);
        }];
        
        [titleL makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(leftIcon.right).offset(margin-FDTipLeftIconWidth);
            make.centerY.equalTo(self.centerY);
        }];
        
        [rightIcon makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(SmallIconSize, SmallIconSize));
            make.centerY.equalTo(self.centerY);
            make.right.equalTo(-margin);
        }];
        
        [titL makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.centerY);
            make.right.equalTo(rightIcon.left);
        }];
        
        [line makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH, LINE_H));
            make.left.equalTo(0);
            make.bottom.equalTo(0);
        }];
        
        titL.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGRAction:)];
        [titL addGestureRecognizer:tapGR];
    }
    return self;
}
- (void)tapGRAction:(UITapGestureRecognizer *)tapGR {
    if ([self.delegate respondsToSelector:@selector(flowTipView:didClickOnTitLabel:)]) {
        [self.delegate flowTipView:self didClickOnTitLabel:self.titL];
    }
}
@end
@interface FDFlowView ()<FDFlowTipViewDelegate>
@property (nonatomic, weak) FDFlowTipView *flowTipView;
@property (nonatomic, weak) UIImageView *flowIconView;
@property (nonatomic, copy) void (^clickBlock)(SegueModel *segue);
@end
@implementation FDFlowView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        FDFlowTipView *flowTipView = [[FDFlowTipView alloc] init];
        flowTipView.delegate = self;
        [self addSubview:flowTipView];
        
        UIImageView *flowIconView = [[UIImageView alloc]init];
        [self addSubview:flowIconView];
        
        self.flowTipView = flowTipView;
        self.flowIconView = flowIconView;
        
        [flowTipView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(0);
            make.left.equalTo(0);
            make.right.equalTo(0);
            make.height.equalTo(30);
        }];
        [flowIconView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(flowTipView.bottom).offset(8);
            make.left.equalTo(0);
            make.right.equalTo(0);
            make.height.equalTo(64);
        }];
        
        [self makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(flowIconView).offset(8);
            make.width.equalTo(SCREEN_WIDTH);
        }];
    }
    return self;
}

- (void)setData:(FDData *)data{
    _data = data;
    [self.flowIconView sd_setImageWithURL:[NSURL URLWithString:data.flowImg] placeholderImage:PLACEHOLDERIMAGE_SMALL];
}
- (void)flowTipView:(FDFlowTipView *)flowTipView didClickOnTitLabel:(UILabel *)label{
    NSString *flowLinkUrl = self.data.flowLinkUrl;
    
    if (self.clickBlock && flowLinkUrl && ![flowLinkUrl isEqualToString:@""]) {
        NSDictionary *params = @{@"linkurl":flowLinkUrl};
        SegueModel *segue = [SegueModel modelWithDestination:SegueDestinationH5 paramRawData:params];
        self.clickBlock(segue);
    }
}

@end

/**
 *  产品信息
 */
@interface FSImageView : UIImageView
@property (nonatomic, weak) UILabel *priceL;
@property (nonatomic, weak) UILabel *peopleNumL;
@property (nonatomic, weak) FDPriceConfigsItem *priceConfigsItem;
@end
@implementation FSImageView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

        UILabel *priceL = [[UILabel alloc] init];
        priceL.font = [UIFont boldSystemFontOfSize:19];
        priceL.textAlignment = NSTextAlignmentCenter;
        priceL.numberOfLines = 0;
        [self addSubview:priceL];
        
        UILabel *peopleNumL = [[UILabel alloc] init];
        peopleNumL.font = [UIFont systemFontOfSize:13];
        peopleNumL.numberOfLines = 0;
        peopleNumL.textColor = [UIColor whiteColor];
        [self addSubview:peopleNumL];
        
        self.priceL = priceL;
        self.peopleNumL = peopleNumL;
        CGFloat priceLTopMargin = 10;
        [priceL makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(priceLTopMargin);
            make.left.equalTo(0);
            make.right.equalTo(0);
            make.height.equalTo(PriceConfigitemViewSize*0.5-priceLTopMargin);
        }];
        
        [peopleNumL makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(priceL.bottom);
            make.left.equalTo(0);
            make.right.equalTo(0);
            make.height.equalTo(PriceConfigitemViewSize*0.5);
        }];
        
    }
    return self;
}
-(void)setPriceConfigsItem:(FDPriceConfigsItem *)priceConfigsItem{
    _priceConfigsItem = priceConfigsItem;
    NSString *priceString = [NSString stringWithFormat:@"¥ %0.0f",priceConfigsItem.price];
    self.priceL.text = priceString;
    self.priceL.textColor = priceConfigsItem.priceStatus == FDPriceStatus_CurrentAchieved?Flash_Pink_Color:[UIColor lightGrayColor];
    
    NSString *peopleNumString = [NSString stringWithFormat:@"%zd人闪购价\n%@",priceConfigsItem.peopleNum,priceConfigsItem.priceStatusName];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.paragraphSpacing = 6;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = @{NSParagraphStyleAttributeName:paragraphStyle};
    NSAttributedString *peopleNumAttributedString = [[NSAttributedString alloc]initWithString:peopleNumString attributes:attributes];
    self.peopleNumL.attributedText = peopleNumAttributedString;
    
    UIColor *priceLTextColor = [UIColor lightGrayColor];
    NSString *imageName = @"priceState-0";
    if (priceConfigsItem.priceStatus == FDPriceStatus_CurrentAchieved) {
        priceLTextColor = Flash_Pink_Color;
        imageName = @"priceState-1";
    }
    self.priceL.textColor = priceLTextColor;
    self.image = [UIImage imageNamed:imageName];
}
@end
@interface FIScrollView : UIScrollView
@property (nonatomic, weak) NSArray<FDPriceConfigsItem *> *priceConfigs;
@property (nonatomic, weak) UIView *itemContentView;
@end
@implementation FIScrollView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        UIView *itemContentView = [[UIView alloc]init];
        [self addSubview:itemContentView];
        self.itemContentView = itemContentView;
    }
    return self;
}
-(void)setPriceConfigs:(NSArray *)priceConfigs{
    _priceConfigs = priceConfigs;
    
    CGFloat margin = FDHeaderViewMargin;
    
    [priceConfigs enumerateObjectsUsingBlock:^(FDPriceConfigsItem *priceConfigsItem, NSUInteger idx, BOOL * _Nonnull stop) {
        FSImageView *itemView = [[FSImageView alloc] init];
        [self.itemContentView addSubview:itemView];
        itemView.priceConfigsItem = priceConfigsItem;
        
        NSUInteger count = priceConfigs.count;
        CGFloat leftContentCount = count+1;
        CGFloat itemMargin = (SCREEN_WIDTH - count*PriceConfigitemViewSize)/leftContentCount;
        itemMargin = itemMargin<margin?margin:itemMargin;
        CGFloat leftMargin = itemMargin + (PriceConfigitemViewSize + itemMargin)*idx;
        [itemView makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(PriceConfigitemViewSize, PriceConfigitemViewSize));
            make.top.equalTo(0);
            make.left.equalTo(leftMargin);
            make.bottom.equalTo(0);
        }];
        if (idx == count-1) {
            
            [self.itemContentView remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(0);
                make.bottom.equalTo(0);
                make.left.equalTo(0);
                make.right.equalTo(itemView).offset(itemMargin);
                make.right.equalTo(0);
            }];
            
            
            
            //self.contentSize = CGSizeMake(leftMargin+(PriceConfigitemViewSize+leftMargin)*count, PriceConfigitemViewSize);

            NSLog(@"FIScrollView.frame:%@",NSStringFromCGRect(self.frame));
        }
    }];
    
    
}
@end
@interface FDInfoView ()<TTTAttributedLabelDelegate>
@property (nonatomic, weak) UILabel *serveNameL;
@property (nonatomic, weak) TTTAttributedLabel *promoteL;
@property (nonatomic, weak) FIScrollView *sv;
@property (nonatomic, weak) UILabel *priceL;
@property (nonatomic, weak) UILabel *stateL;
@property (nonatomic, copy) void (^clickBlock)(SegueModel *segue);
@end
@implementation FDInfoView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        CGFloat margin = FDHeaderViewMargin;
        UILabel *serveNameL = [[UILabel alloc] init];
        serveNameL.font = [UIFont systemFontOfSize:17];
        serveNameL.numberOfLines = 0;
        serveNameL.textColor = [UIColor darkGrayColor];
        [self addSubview:serveNameL];
        
        TTTAttributedLabel *promoteL = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
        promoteL.numberOfLines = 0;
        promoteL.delegate = self;
        [self addSubview:promoteL];
        
        FIScrollView *sv = [[FIScrollView alloc] init];
        [self addSubview:sv];
        
        UILabel *priceL = [[UILabel alloc] init];
        //priceL.textAlignment = NSTextAlignmentCenter;
        priceL.contentMode =UIViewContentModeCenter;
        [self addSubview:priceL];
        
        UILabel *stateL = [[UILabel alloc] init];
        [self addSubview:stateL];
        
        self.serveNameL = serveNameL;
        self.promoteL = promoteL;
        self.sv = sv;
        self.priceL = priceL;
        self.stateL = stateL;
        
        [serveNameL makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(margin);
            make.left.equalTo(margin);
            make.right.equalTo(-margin);
        }];
        
        [promoteL makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(serveNameL.bottom).offset(margin*0.5);
            make.left.equalTo(margin);
            make.right.equalTo(-margin);
        }];
        
        [sv makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH, PriceConfigitemViewSize));
            make.top.equalTo(promoteL.bottom).offset(margin);
            make.left.equalTo(0);
            make.right.equalTo(0);
            make.bottom.equalTo(priceL.top).offset(-margin);
        }];
        
        [priceL makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(margin);
            make.bottom.equalTo(-margin);
        }];
        
        [stateL makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-margin);
            make.bottom.equalTo(-margin);
        }];
        
        [self makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(stateL).offset(margin);
        }];
    }
    return self;
}
- (void)setData:(FDData *)data{
    _data = data;
    
    //serveName
    self.serveNameL.text = data.serveName;
    
    //promote
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc]init];
    paragraph.lineSpacing = 8;
    
    NSDictionary *attributes = @{NSForegroundColorAttributeName:COLOR_PINK_FLASH,
                                 NSFontAttributeName:[UIFont systemFontOfSize:15],
                                 NSParagraphStyleAttributeName:paragraph};
    NSMutableAttributedString *promoteLArrtibutedTex = [[NSMutableAttributedString alloc] initWithString:data.promote
                                                                                              attributes:attributes];
    NSArray *promotionLink = data.promotionLink;
    [promotionLink enumerateObjectsUsingBlock:^(FDPromotionLinkItem  *promotionLinkItem, NSUInteger idx, BOOL * _Nonnull stop) {
        NSRange range = [promoteLArrtibutedTex.mutableString rangeOfString:promotionLinkItem.linkKey];
        [promoteLArrtibutedTex addAttribute:NSForegroundColorAttributeName value:promotionLinkItem.uiColor range:range];
        [promoteLArrtibutedTex addAttribute:NSUnderlineStyleAttributeName value:@YES range:range];
        if (promotionLinkItem) {
            [self.promoteL setLinkAttributes:nil];
            [self.promoteL addLinkToAddress:@{@"promotionLinkItem":promotionLinkItem} withRange:range];
        }
    }];
    self.promoteL.attributedText = promoteLArrtibutedTex;
    
    
    self.sv.priceConfigs = data.priceConfigs;
    
    //价格
    NSMutableAttributedString *allPriceAttributedString = [[NSMutableAttributedString alloc]init];
    
    NSString *priceString = [NSString stringWithFormat:@"门店价:¥%0.0f",data.price];
    NSDictionary *priceAttributes = @{NSForegroundColorAttributeName:[UIColor lightGrayColor],
                                      NSFontAttributeName:[UIFont systemFontOfSize:15],
                                      NSStrikethroughStyleAttributeName:@YES};
    NSAttributedString *priceAttributedString = [[NSAttributedString alloc]initWithString:priceString attributes:priceAttributes];
    
    [allPriceAttributedString appendAttributedString:priceAttributedString];
    
    NSString *prepaidPriceString = [NSString stringWithFormat:@"  预付:¥%0.0f",data.prepaidPrice];
    NSDictionary *prepaidPriceAttributes = @{NSForegroundColorAttributeName:Flash_Pink_Color,
                                      NSFontAttributeName:[UIFont boldSystemFontOfSize:15]};
    NSAttributedString *prepaidPriceAttributedString = [[NSAttributedString alloc]initWithString:prepaidPriceString attributes:prepaidPriceAttributes];
    
    [allPriceAttributedString appendAttributedString:prepaidPriceAttributedString];
    
    self.priceL.attributedText = allPriceAttributedString;
    
    //当前的销售状态
    NSString *prepaidNumStr = [NSString stringWithFormat:@"%zd",data.prepaidNum];
    NSString *evaluateStr = [NSString stringWithFormat:@"%zd",data.evaluate];
    
    NSString *stateString = [NSString stringWithFormat:@"%@人报名丨%@评价",prepaidNumStr,evaluateStr];
    NSDictionary *stateAttributes = @{NSForegroundColorAttributeName:[UIColor lightGrayColor],
                                      NSFontAttributeName:[UIFont systemFontOfSize:13]};
    NSMutableAttributedString *stateAttributedString = [[NSMutableAttributedString alloc] initWithString:stateString attributes:stateAttributes];
    
    NSRange prepaidNumRange = [stateString rangeOfString:prepaidNumStr];
    [stateAttributedString addAttribute:NSForegroundColorAttributeName value:COLOR_BLUE range:prepaidNumRange];
    NSRange evaluateRange = [stateString rangeOfString:evaluateStr];
    [stateAttributedString addAttribute:NSForegroundColorAttributeName value:COLOR_BLUE range:evaluateRange];
    
    self.stateL.attributedText = stateAttributedString;
    
}
#pragma mark TTTAttributedLabelDelegate
- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithAddress:(NSDictionary *)addressComponents {
    FDPromotionLinkItem  *promotionLinkIte = addressComponents[@"promotionLinkItem"];
    if (promotionLinkIte) {
        if (self.clickBlock) {
            NSLog(@"promotionLinkIte.linkKey:%@",promotionLinkIte.linkKey);
            SegueModel *segue = [SegueModel modelWithDestination:(SegueDestination)promotionLinkIte.linkType paramRawData:promotionLinkIte.params];
            self.clickBlock(segue);
        }
    }
}
@end

/**
 *  地理位置信息
 */
@interface FDMapaddrLabel ()
@property (nonatomic, weak) UIImageView *leftIcon;
@property (nonatomic, weak) UIImageView *rightIcon;
@property (nonatomic, weak) UILabel *titleL;
@property (nonatomic, weak) UILabel *titL;
@property (nonatomic, copy) void (^clickBlock)(NSArray<StoreListItemModel *> *store);
@end
@implementation FDMapaddrLabel
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *leftIcon = [[UIImageView alloc] init];
        leftIcon.image = [UIImage imageNamed:@"unlocated"];
        [self addSubview:leftIcon];
        
        UILabel *titleL = [[UILabel alloc] init];
        titleL.textColor = [UIColor whiteColor];
        titleL.font = [UIFont systemFontOfSize:13];
        [self addSubview:titleL];
        
        UIImageView *rightIcon = [[UIImageView alloc] init];
        rightIcon.image = [UIImage imageNamed:@"Me-11"];
        [self addSubview:rightIcon];
        
        UILabel *titL = [[UILabel alloc] init];
        titL.textColor = [UIColor whiteColor];
        titL.font = [UIFont systemFontOfSize:13];
        titL.text = @"查看详情";
        [self addSubview:titL];
        
        self.leftIcon = leftIcon;
        self.titleL = titleL;
        self.rightIcon = rightIcon;
        self.titL = titL;
        
        
        CGFloat margin = FDHeaderViewMargin;
        
        [leftIcon makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(SmallIconSize, SmallIconSize));
            make.left.equalTo(margin);
            make.centerY.equalTo(self.centerY);
        }];
        
        [titleL makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(leftIcon.right).offset(margin*0.5);
            make.centerY.equalTo(self.centerY);
        }];
        
        [rightIcon makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(SmallIconSize, SmallIconSize));
            make.centerY.equalTo(self.centerY);
            make.right.equalTo(-margin);
        }];
        
        [titL makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.centerY);
            make.right.equalTo(rightIcon.left);
        }];
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGRAction:)];
        [self addGestureRecognizer:tapGR];
    }
    return self;
}

- (void)setStore:(NSArray *)store{
    _store = store;
    
    NSString *title = @"暂无门店可用";
    if (store.count>1) {
        title = [NSString stringWithFormat:@"全城%zd家门店通用",store.count];
    }else if (store.count == 1){
        NSDictionary *storeItemDic = store[0];
        title = storeItemDic[@"storeName"];
    }
    self.titleL.text = title;
}

- (void)tapGRAction:(UITapGestureRecognizer *)tapGR {
    if (self.clickBlock) {
        NSMutableArray<StoreListItemModel *> *store = [NSMutableArray array];
        for (NSDictionary *dic in self.store) {
            StoreListItemModel *storeListItemModel = [[StoreListItemModel alloc]initWithRawData:dic];
            [store addObject:storeListItemModel];
        }
        self.clickBlock(store);
    }
}
@end

/**
 *  头视图
 */
@interface FDHeaderView () <FlashDetailAutoRollViewDelegate>
@end
@implementation FDHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return self;
}

- (void)setData:(FDData *)data{

    _data = data;
    
    CGRect autoRollViewRect = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * data.picRate.floatValue);
    FlashDetailAutoRollView *autoRollView = [[FlashDetailAutoRollView alloc] initWithFrame:autoRollViewRect items:data.narrowImg delegate:self];
    [self addSubview:autoRollView];
    
    CGRect mapaddrLabelRect = CGRectMake(0, autoRollViewRect.size.height-mapaddrLabelRectHight, SCREEN_WIDTH, mapaddrLabelRectHight);
    FDMapaddrLabel *mapaddrLabel = [[FDMapaddrLabel alloc] initWithFrame:mapaddrLabelRect];
    mapaddrLabel.clickBlock = ^void (NSArray<StoreListItemModel *> *store){
        if ([self.delegate respondsToSelector:@selector(fdHeaderView:didClickOnMapLabelWithStore:)]) {
            [self.delegate fdHeaderView:self didClickOnMapLabelWithStore:store];
        }
    };
    [autoRollView addSubview:mapaddrLabel];
    mapaddrLabel.store = data.store;
    [ToolBox renderGradientForView:mapaddrLabel displayFrame:CGRectMake(0, 0, mapaddrLabel.frame.size.width, mapaddrLabel.frame.size.height) startPoint:CGPointMake(0.5, 0) endPoint:CGPointMake(0.5, 1) colors:[NSArray arrayWithObjects:RGBA(0, 0, 0, 0), RGBA(0, 0, 0, 0.3), nil] locations:nil];
    
    FDInfoView *infoView = [[FDInfoView alloc] init];
    infoView.data = data;
    infoView.clickBlock = ^void (SegueModel *segue){
        if ([self.delegate respondsToSelector:@selector(fdHeaderView:didClickWithSegue:)]) {
            [self.delegate fdHeaderView:self didClickWithSegue:segue];
        }
    };
    [self addSubview:infoView];
    [infoView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(autoRollView.bottom);
    }];
    
    FDFlowView *flowView = [[FDFlowView alloc]init];
    flowView.data = data;
    flowView.clickBlock = ^void (SegueModel *segue){
        NSLog(@"seguedestination:%zd",segue.destination);
        if ([self.delegate respondsToSelector:@selector(fdHeaderView:didClickWithSegue:)]) {
            [self.delegate fdHeaderView:self didClickWithSegue:segue];
        }
    };
    [self addSubview:flowView];
    [self addConstraintForView:flowView];
    
    if (data.content && ![data.content isEqualToString:@""]) {
        FDBriefIntroductionView *briefIntroductionView = [[FDBriefIntroductionView alloc] init];
        briefIntroductionView.contentString = data.content;
        [self addSubview:briefIntroductionView];
        [self addConstraintForView:briefIntroductionView];
    }
    
    if (data.buyNotice.count>0) {
        FDPurchaseNotesView *purchaseNotesView = [[FDPurchaseNotesView alloc]init];
        purchaseNotesView.buyNotice = data.buyNotice;
        [self addSubview:purchaseNotesView];
        [self addConstraintForView:purchaseNotesView];
    }
    
    if (data.note) {
        FDNoteView *noteView = [[FDNoteView alloc]init];
        noteView.note = data.note;
        [self addSubview:noteView];
        [self addConstraintForView:noteView];
    }
    
    //FDToolBar *tooBar = [[FDToolBar alloc]init];
    //[self addSubview:tooBar];
    //[self addConstraintForView:tooBar];
    
    [self makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(SCREEN_WIDTH);
        make.top.equalTo(0);
        UIView *lastSubView = self.subviews[self.subviews.count-1];
        make.bottom.equalTo(lastSubView).offset(FDHeaderViewMargin);
    }];
    
    [self layoutIfNeeded];
}

- (void)addConstraintForView:(UIView *)view{
    [view makeConstraints:^(MASConstraintMaker *make) {
        UIView *lastSubView = self.subviews[self.subviews.count-2];
        make.top.equalTo(lastSubView.bottom).offset(FDHeaderViewMargin);
    }];
}

#pragma mark - FlashDetailAutoRollViewDelegate

-(void)didSelectPageAtIndex:(NSUInteger)index{
    
}

@end


