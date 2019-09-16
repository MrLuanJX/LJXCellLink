//
//  LJXModel.m
//  LJXCellLink
//
//  Created by 栾金鑫 on 2019/9/12.
//  Copyright © 2019年 栾金鑫. All rights reserved.
//

#import "LJXModel.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@implementation LJXModel

-(CGSize)msgSize{
    if (_userMsg) {
        
    }else{
        _userMsg = @"";
    }
    // 添加行间距
    NSMutableParagraphStyle * paragraph = [[NSMutableParagraphStyle alloc]init];
    paragraph.lineSpacing = 5.0;
    
    _msgSize = [_userMsg boundingRectWithSize:CGSizeMake(kScreenWidth - 40, 999) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSParagraphStyleAttributeName:paragraph,NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
    return _msgSize;
}

@end
