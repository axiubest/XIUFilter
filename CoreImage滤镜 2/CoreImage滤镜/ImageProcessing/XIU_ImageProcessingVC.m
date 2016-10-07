//
//  XIU_FilterViewController.m
//  CoreImage滤镜

//  Created by A-XIU on 16/9/8.
//  Copyright © 2016年 XIU. All rights reserved.
//

#import "XIU_ImageProcessingVC.h"
#import "XIU_FiterView.h"
#import "XIU_EditView.h"
#import "XIU_FiterImageModel.h"
#import "XIU_EditImageModel.h"
#import "XIU_MainSliderView.h"
@interface XIU_ImageProcessingVC ()<FiterImageDelegate, EditImageDelegate>

/**
 *传过来的图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *MainImg;

/**
 *滤镜View
 */
@property (strong, nonatomic) IBOutlet XIU_FiterView *fiterView;
/**
 *编辑View
 */
@property (weak, nonatomic) IBOutlet XIU_EditView *exitView;

/**
 *滤镜按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *fiterBtn;

/**
 *编辑按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *editBtn;

@property (weak, nonatomic) IBOutlet XIU_MainSliderView *SliderView;


/**
 *取消按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

/**
 *确定按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *DoneBtn;
@end

@implementation XIU_ImageProcessingVC



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    _SliderView.hidden = YES;
        _MainImg.image = _sendImg;
    [_fiterView baseInit:_sendImg];
    _fiterView.MyDelegate = self;
    [_exitView baseInit:_sendImg];
    _exitView.MyDelegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)chickedButtomBtn:(UIButton *)sender {
    switch (sender.tag) {
        case 1:
            _exitView.hidden = YES;
            _fiterView.hidden = NO;
 
            break;
        case 2:
            _exitView.hidden = NO;
            _fiterView.hidden = YES;
            break;
        default:
            break;
    }
}

#pragma mark chicked Edit Btn Method
- (IBAction)chickedCancelBtn:(id)sender {
    [self showAnimationOfDissMiss];
}

- (IBAction)chickedDoneBtn:(id)sender {
    [self showAnimationOfDissMiss];
}

- (void)showAnimationOfDissMiss {
    [UIView animateWithDuration:0.5 animations:^{
        _cancelBtn.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width / 2, 40);
        _DoneBtn.frame = CGRectMake(self.view.frame.size.width / 2, self.view.frame.size.height, self.view.frame.size.width / 2, 40);
    }];
    _fiterBtn.hidden = NO;
    _editBtn.hidden = NO;
    _SliderView.hidden = YES;
    
}
#pragma mark Delegate
- (void)ChangeImage:(UIImage *)img {
    self.MainImg.image = img;
}

- (void)showSlider {
    _SliderView.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        _cancelBtn.frame = _fiterBtn.frame;
        _DoneBtn.frame = _editBtn.frame;
    }];
    _fiterBtn.hidden = YES;
    _editBtn.hidden = YES;
    _fiterView.hidden = YES;
    _exitView.hidden = YES;

}
- (IBAction)chickedBackBtn:(id)sender {

    [self dismissViewControllerAnimated:YES completion:nil];
    
}


@end
