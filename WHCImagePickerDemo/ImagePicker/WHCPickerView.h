//
//  WHCPickerView.h
//  whc2
//
//  Created by 汪弘昌 on 2018/8/31.
//  Copyright © 2018年 汪弘昌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImagePerkerCollectionViewCell.h"
#import <MJRefresh.h>
#import "PhotoManager.h"
#import "ImagePerkerModel.h"
@interface WHCPickerView : UIView
/** 最大照片数 默认5张*/
@property (nonatomic, assign)NSInteger whc_max;
/** 最大图片数量，是否显示+号, 默认NO*/
@property (nonatomic, assign)BOOL whc_maxHideAdd;
/** 是否隐藏删除按钮 默认NO*/
@property (nonatomic, assign)BOOL whc_hideCloseBut;
/** 每行显示几个*/
@property (nonatomic, assign)NSInteger whc_lineCount;
/** 刷新view高度，没有父视图情况下可以不调*/
@property (nonatomic, copy) void(^reloadViewHeight)(CGFloat height);
/** 获取图片模型数组*/
@property (nonatomic, copy) void(^seletecImages)(NSArray<ImagePerkerModel*> *images);
@end
