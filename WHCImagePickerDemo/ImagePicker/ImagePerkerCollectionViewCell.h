//
//  ImagePerkerCollectionViewCell.h
//  whc2
//
//  Created by 汪弘昌 on 2018/8/30.
//  Copyright © 2018年 汪弘昌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImagePerkerModel.h"
@protocol ImagePerkerCollectionViewCellDelegat <NSObject>

@optional
- (void)deleteImageModel:(ImagePerkerModel*)model;

@end

@interface ImagePerkerCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong)ImagePerkerModel *model;
@property (nonatomic, weak)id<ImagePerkerCollectionViewCellDelegat> delegate;
@end
