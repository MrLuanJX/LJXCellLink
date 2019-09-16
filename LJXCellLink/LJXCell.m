//
//  LJXCell.m
//  LJXCellLink
//
//  Created by 栾金鑫 on 2019/9/12.
//  Copyright © 2019年 栾金鑫. All rights reserved.
//

#import "LJXCell.h"
#import <YYText/YYText.h>
#import <YYLabel.h>

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface LJXCell()

@property (nonatomic , strong)  YYLabel *msgboard;

@end

@implementation LJXCell

- (void)setModel:(LJXModel *)model {
    _model = model;
    
    [self addSeeMoreButtonInLabel:self.msgboard AttString:model.userMsg];
    
    if (!model.isOpen) {
        _msgboard.frame = CGRectMake(20, 5,kScreenWidth - 40,60);
        [self packUpString];
    }else{
        _msgboard.frame = CGRectMake(20, 5,kScreenWidth - 40,model.msgSize.height);
        [self expandString];
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor whiteColor];
                
        [self.contentView addSubview:self.msgboard];
    }
    return self;
}

- (YYLabel *)msgboard {
    if (!_msgboard) {
        _msgboard  = [[YYLabel alloc] init];
        _msgboard.numberOfLines = 0;
    }
    return _msgboard;
}

- (void)addSeeMoreButtonInLabel:(YYLabel *)label AttString:(nonnull NSString *)attString {
    // @"我们可以使用以下方式来指定切断文本; 收起 我们可以使用以下方式来指定切断文本"
    UIFont *font16 = [UIFont systemFontOfSize:16];
    // 添加行间距
    NSMutableParagraphStyle * paragraph = [[NSMutableParagraphStyle alloc]init];
    paragraph.lineSpacing = 5.0;
    /* 文本颜色、字号、行间距 */
    label.attributedText = [[NSAttributedString alloc] initWithString:attString attributes:@{NSParagraphStyleAttributeName:paragraph,NSFontAttributeName : font16,NSForegroundColorAttributeName:[UIColor redColor]}];
    
    NSString *moreString = @" 展开";
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"... %@", moreString]];
    
    NSRange expandRange = [text.string rangeOfString:moreString];
    /* 展开的颜色 */
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:expandRange];
    /* ... 的文字颜色 */
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, expandRange.location)];
    
    // 添加点击事件
    YYTextHighlight *hi = [YYTextHighlight new];
    [text yy_setTextHighlight:hi range:[text.string rangeOfString:moreString]];
    
    __weak typeof(self) weakSelf = self;
    hi.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
        //点击展开
        [weakSelf setLabelFrame:YES];
    };
    
    text.yy_font = font16;
    
    YYLabel *seeMore = [YYLabel new];
    seeMore.attributedText = text;
    [seeMore sizeToFit];
    
    NSAttributedString *truncationToken = [NSAttributedString yy_attachmentStringWithContent:seeMore contentMode:UIViewContentModeCenter attachmentSize:seeMore.frame.size alignToFont:text.yy_font alignment:YYTextVerticalAlignmentTop];
    
    label.truncationToken = truncationToken;
}

- (NSAttributedString *)appendAttriStringWithFont:(UIFont *)font {
    if (!font) {
        font = [UIFont systemFontOfSize:16];
    }
    
    NSString *appendText = @" 收起 ";
    NSMutableAttributedString *append = [[NSMutableAttributedString alloc] initWithString:appendText attributes:@{NSFontAttributeName : font, NSForegroundColorAttributeName : [UIColor blueColor]}];
    
    YYTextHighlight *hi = [YYTextHighlight new];
    [append yy_setTextHighlight:hi range:[append.string rangeOfString:appendText]];
    
    __weak typeof(self) weakSelf = self;
    hi.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
        //点击收起
        [weakSelf setLabelFrame:NO];
    };

    return append;
}

- (void)expandString {
    NSMutableAttributedString *attri = [self.msgboard.attributedText mutableCopy];
    
    [attri appendAttributedString:[self appendAttriStringWithFont:attri.yy_font]];
    
    self.msgboard.attributedText = attri;
}

- (void)packUpString {
    NSString *appendText = @" 收起 ";
    NSMutableAttributedString *attri = [self.msgboard.attributedText mutableCopy];
    NSRange range = [attri.string rangeOfString:appendText options:NSBackwardsSearch];
    
    if (range.location != NSNotFound) {
        [attri deleteCharactersInRange:range];
    }
    
    self.msgboard.attributedText = attri;
}

- (void)setLabelFrame:(BOOL)isExpand {
        
    if (isExpand) {
        [self expandString];
        self.msgboard.frame = CGRectMake(20, 10, [UIScreen mainScreen].bounds.size.width - 40, self.model.msgSize.height);
    }
    else {
        [self packUpString];
        self.msgboard.frame = CGRectMake(20, 10, [UIScreen mainScreen].bounds.size.width - 40, 60);
    }
    
    if (self.model.isOpen == YES) {
        self.ljxRefreshBlock(self.model,1,1);
    }else{
        self.ljxRefreshBlock(self.model,0,1);
    }
}

-(void)doRefreshModel:(LJXRefreshBlock)ljxRefreshBlock{
    _ljxRefreshBlock = ljxRefreshBlock;
}

@end
