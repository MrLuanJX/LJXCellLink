//
//  LJXModel.h
//  LJXCellLink
//
//  Created by 栾金鑫 on 2019/9/12.
//  Copyright © 2019年 栾金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LJXModel : NSObject
/* 文本 */
@property (nonatomic , strong) NSString * userMsg;
/* 文本高度 */
@property (nonatomic,assign) CGSize msgSize;
/* 是否展开 */
@property (nonatomic,assign) BOOL isOpen;

@end

NS_ASSUME_NONNULL_END
