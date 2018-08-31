//
//  WHCPickerView.m
//  whc2
//
//  Created by 汪弘昌 on 2018/8/31.
//  Copyright © 2018年 汪弘昌. All rights reserved.
//

#import "WHCPickerView.h"

@interface WHCPickerView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,ImagePerkerCollectionViewCellDelegat>
@property (nonatomic, strong)UICollectionView *mainCollectionView;
@property (nonatomic, strong)NSMutableArray *imageData;

@end

@implementation WHCPickerView


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self whc_initialize];
        [self configCollectionView];
        [self addAddIamgeModel];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self whc_initialize];
        [self configCollectionView];
        [self addAddIamgeModel];
    }
    return self;
}

- (void)whc_initialize
{
    self.whc_hideCloseBut = NO;
    self.whc_maxHideAdd = NO;
    self.whc_lineCount = 3;
    self.whc_max = 5;
    self.imageData = [NSMutableArray array];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self whc_initialize];
    [self configCollectionView];
    [self addAddIamgeModel];
    
}

- (void)setWhc_lineCount:(NSInteger)whc_lineCount
{
    _whc_lineCount = whc_lineCount;
    [self whc_reloadHeight];
}
- (void)setWhc_max:(NSInteger)whc_max
{
    _whc_max = whc_max;
    [self whc_reloadHeight];
}
- (void)setWhc_maxHideAdd:(BOOL)whc_maxHideAdd
{
    _whc_maxHideAdd = whc_maxHideAdd;
    [self whc_reloadHeight];
}
- (void)setWhc_hideCloseBut:(BOOL)whc_hideCloseBut
{
    _whc_hideCloseBut = whc_hideCloseBut;
    [self whc_reloadHeight];
}
#pragma mark ************UI
- (void)configCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.mainCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.mj_w, 0) collectionViewLayout:flowLayout];
    [self addSubview:self.mainCollectionView];
    self.mainCollectionView.dataSource = self;
    self.mainCollectionView.delegate = self;
    self.mainCollectionView.backgroundColor = [UIColor whiteColor];
    self.mainCollectionView.showsVerticalScrollIndicator = NO;
    self.mainCollectionView.showsHorizontalScrollIndicator = NO;
    [self.mainCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ImagePerkerCollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass([ImagePerkerCollectionViewCell class])];
}

#pragma mark ************collectionView delegate dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageData.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImagePerkerCollectionViewCell *cell = [self.mainCollectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ImagePerkerCollectionViewCell class]) forIndexPath:indexPath];
    cell.model = self.imageData[indexPath.item];
    cell.delegate = self;
    return cell;
}

#pragma mark ************UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.mj_w - (10 * (self.whc_lineCount + 1)))/self.whc_lineCount, (self.mj_w - (10 * (self.whc_lineCount + 1)))/self.whc_lineCount);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIImage *image = [UIImage imageNamed:@"AddMedia"];
    for (NSInteger i = 0; i < self.imageData.count; i++ )
    {
        if ([image isEqual:[self.imageData[i] image]])
        {
            if (indexPath.item == i && self.imageData.count < self.whc_max + 1)
            {
                PhotoManager *photoManager = [PhotoManager shareManager];
                photoManager.maxCount = self.whc_max - self.imageData.count + 1;
                [photoManager jumpCustomPhotoAlbum];
                __weak typeof(self) weakSelf = self;
                photoManager.selectCustomImages = ^(NSArray<LGPhotoAssets *> *images) {
                    for (NSInteger i = 0; i < images.count; i++ )
                    {
                        [weakSelf settleImage:[images[i] thumbImage]];
                    }
                    [weakSelf deleteAddImageModel];
                };
                
                photoManager.customCameraImages = ^(NSArray<ZLCamera *> *images) {
                    ZLCamera *canamerPhoto = images[0];
                    [weakSelf settleImage:canamerPhoto.photoImage];
                    [weakSelf deleteAddImageModel];
                };
            }
            else if(indexPath.item == i)
            {
                NSLog(@"最多只能选择%ld张图片",_whc_max);
            }
        }
    }
}
#pragma mark ************cell Delegate
- (void)deleteImageModel:(ImagePerkerModel *)model
{
    for (NSInteger i = 0; i < self.imageData.count; i++ )
    {
        ImagePerkerModel *imagePerkerModel = self.imageData[i];
        if ([model.image isEqual:imagePerkerModel.image])
        {
            [self.imageData removeObjectAtIndex:i];
            if (self.imageData.count == self.whc_max - 1 && !self.whc_maxHideAdd && ![self dataIsAdd]) {
                [self addAddIamgeModel];
            }
            else
            {
                [self.mainCollectionView reloadData];
                [self whc_reloadHeight];
            }
            
            break;
        }
    }
}
#pragma mark ************私有方法
- (BOOL)dataIsAdd
{
    BOOL isAdd = NO;
    UIImage *image = [UIImage imageNamed:@"AddMedia"];
    for (NSInteger i = 0; i < self.imageData.count; i++) {
        if ([image isEqual:[self.imageData[i] image]])
        {
            isAdd = YES;
        }
        else
        {
            isAdd = NO;
        }
    }
    return isAdd;
}
- (void)addAddIamgeModel
{
    ImagePerkerModel *model = [ImagePerkerModel new];
    model.image = [UIImage imageNamed:@"AddMedia"];
    model.hideCloseBut = YES;
    [self.imageData addObject:model];
    [self.mainCollectionView reloadData];
    [self whc_reloadHeight];
}

- (void)settleImage:(UIImage*)image
{
    ImagePerkerModel *model = [ImagePerkerModel new];
    model.image = image;
    model.hideCloseBut = self.whc_hideCloseBut;
    [self.imageData insertObject:model atIndex:0];
}

- (void)deleteAddImageModel
{
    if (self.imageData.count == self.whc_max + 1 && !self.whc_maxHideAdd)
    {
        [_imageData removeLastObject];
    }
    [self.mainCollectionView reloadData];
    [self whc_reloadHeight];
}

- (void)whc_reloadHeight
{
    if (self.imageData.count)
    {
        [self reloadHeight];
    }
}


- (void)reloadHeight
{
    NSInteger count = self.imageData.count / self.whc_lineCount;
    if (self.imageData.count % self.whc_lineCount > 0)
    {
        count += 1;
    }
    self.mainCollectionView.mj_h = (count * ((self.mj_w - (10 * (self.whc_lineCount + 1)))/self.whc_lineCount)) + 10 * (count + 1);
    if (self.reloadViewHeight)
    {
        self.reloadViewHeight(self.mainCollectionView.mj_h);
    }
    if (self.seletecImages)
    {
        NSMutableArray *arr = [NSMutableArray array];
        if ([self dataIsAdd])
        {
            for (NSInteger i = 0; i < self.imageData.count - 1; i++ )
            {
                [arr addObject:self.imageData[i]];
            }
        }
        else
        {
            for (NSInteger i = 0; i < self.imageData.count; i++ )
            {
                [arr addObject:self.imageData[i]];
            }
        }
        self.seletecImages(arr);
    }
}


@end
