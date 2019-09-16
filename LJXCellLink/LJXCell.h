//
//  LJXCell.h
//  LJXCellLink
//
//  Created by 栾金鑫 on 2019/9/12.
//  Copyright © 2019年 栾金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJXModel.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^LJXRefreshBlock)(LJXModel *model,NSInteger rowNum,NSInteger sectionNum);

@interface LJXCell : UITableViewCell

@property (nonatomic , strong) LJXModel * model;

@property (nonatomic,copy) LJXRefreshBlock ljxRefreshBlock;

-(void)doRefreshModel:(LJXRefreshBlock)ljxRefreshBlock;

@end

NS_ASSUME_NONNULL_END
