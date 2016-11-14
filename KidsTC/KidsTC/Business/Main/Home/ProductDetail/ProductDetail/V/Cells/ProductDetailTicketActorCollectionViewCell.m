//
//  ProductDetailTicketActorCollectionViewCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/11.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailTicketActorCollectionViewCell.h"

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
    
}

@end
