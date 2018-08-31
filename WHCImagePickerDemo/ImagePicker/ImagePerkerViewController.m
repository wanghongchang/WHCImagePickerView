//
//  ImagePerkerViewController.m
//  whc2
//
//  Created by 汪弘昌 on 2018/8/30.
//  Copyright © 2018年 汪弘昌. All rights reserved.
//

#import "ImagePerkerViewController.h"
#import "ImagePerkerCollectionViewCell.h"
#import <MJRefresh.h>
#import "PhotoManager.h"
#import "WHCPickerView.h"
@interface ImagePerkerViewController ()
@property (nonatomic, strong)WHCPickerView *pickerView;
@end

@implementation ImagePerkerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"图片选择器";
    [self configPickerView];
}


- (void)configPickerView
{
    _pickerView = [[WHCPickerView alloc]initWithFrame:CGRectMake(0, 64, 375, 500)];
    _pickerView.reloadViewHeight = ^(CGFloat height) {
        NSLog(@"%f",height);
    };
    _pickerView.seletecImages = ^(NSArray<ImagePerkerModel *> *images) {
        NSLog(@"%ld",images.count);
//        for (ImagePerkerModel *model in images)
//        {
//            UIImage *image = model.image;
//        }
    };
    [self.view addSubview:_pickerView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
