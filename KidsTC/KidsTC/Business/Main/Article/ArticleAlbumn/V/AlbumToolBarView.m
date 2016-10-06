//
//  AlbumToolBarView.m
//  KidsTC
//
//  Created by zhanping on 6/2/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "AlbumToolBarView.h"


#define ContentMaxHight 80

@interface AlbumToolBarView ()
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentCountLabel;
@property (weak, nonatomic) IBOutlet UIView *toolBGView;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;


@end

@implementation AlbumToolBarView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.toolBGView.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.5];
    self.contentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    self.likeBtn.tag = AlbumToolBarViewBtnType_like;
    self.commentBtn.tag = AlbumToolBarViewBtnType_comment;
    
}
-(void)setArticleContent:(ADArticleContent *)articleContent{
    _articleContent = articleContent;
    
    NSString *likeBtnImg = _articleContent.isLike?@"icon_album_like":@"icon_favor_white_border";
    [self.likeBtn setImage:[UIImage imageNamed:likeBtnImg] forState:UIControlStateNormal];
    NSString *likeCount = [NSString stringWithFormat:@"%zd",_articleContent.likeCount];
    self.likeCountLabel.text = likeCount;
    
    NSString *readCount = [NSString stringWithFormat:@"%zd",_articleContent.commentCount];
    self.commentCountLabel.text = readCount;
}

- (void)setContent:(NSAttributedString *)content{
    _content = content;
    
    self.contentTextView.attributedText = content;
    
    CGSize size = CGSizeMake(self.contentTextView.frame.size.width-7, 999);
    CGRect rect = [content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    
    CGFloat contentHight = rect.size.height;
    contentHight = contentHight>ContentMaxHight?ContentMaxHight:contentHight;
    CGFloat hight = contentHight+49+34;
    self.frame = CGRectMake(0, SCREEN_HEIGHT-hight+1, self.frame.size.width, hight);
}


- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(albumToolBarView:didClickOnBtnType:)]) {
        [self.delegate albumToolBarView:self didClickOnBtnType:(AlbumToolBarViewBtnType)sender.tag];
    }
}



@end
