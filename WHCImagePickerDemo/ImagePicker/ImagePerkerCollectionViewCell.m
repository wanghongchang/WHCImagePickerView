//
//  ImagePerkerCollectionViewCell.m
//  whc2
//
//  Created by 汪弘昌 on 2018/8/30.
//  Copyright © 2018年 汪弘昌. All rights reserved.
//

#import "ImagePerkerCollectionViewCell.h"
@interface ImagePerkerCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIButton *closeBut;
@property (weak, nonatomic) IBOutlet UIImageView *iv;

@end

@implementation ImagePerkerCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setModel:(ImagePerkerModel *)model
{
    _model = model;
    self.iv.image = model.image;
    self.closeBut.hidden = model.hideCloseBut;
}

- (IBAction)deleteButClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(deleteImageModel:)])
    {
        [self.delegate deleteImageModel:_model];
    }
}

@end
