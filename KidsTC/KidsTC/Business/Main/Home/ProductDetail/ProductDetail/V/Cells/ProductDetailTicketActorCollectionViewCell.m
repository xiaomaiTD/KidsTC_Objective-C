//
//  ProductDetailTicketActorCollectionViewCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/11.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailTicketActorCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"
#import "Colours.h"

@interface ProductDetailTicketActorCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *actorL;
@end

@implementation ProductDetailTicketActorCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.icon.layer.borderWidth = LINE_H;
    self.icon.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.nameL.textColor = [UIColor colorFromHexString:@"555555"];
    self.actorL.textColor = [UIColor colorFromHexString:@"999999"];
}

- (void)setActor:(ProductDetailActor *)actor {
    _actor = actor;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:actor.imgUrl] placeholderImage:PLACEHOLDERIMAGE_SMALL];
    self.nameL.text = actor.name;
    self.actorL.text = [NSString stringWithFormat:@"饰 %@",actor.roleName];
}

@end
