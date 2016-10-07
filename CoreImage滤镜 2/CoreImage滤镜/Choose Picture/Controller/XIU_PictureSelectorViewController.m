//
//  XIU_PictureSelectorViewController.m
//  XIU_PictureSelector
//
//  Created by XIUDeveloper on 16/9/13.
//  Copyright © 2016年 杨岫峰. All rights reserved.
//

#import "XIU_PictureSelectorViewController.h"
#import "XIU_PickerImageCollectionVC.h"
#import "XIU_ImageProcessingVC.h"

#define MainHeight [UIScreen mainScreen].bounds.size.height
#define MainWidth [UIScreen mainScreen].bounds.size.width

@interface XIU_PictureSelectorViewController ()
{
    UIImage *tmpImg;
}
@property (strong, nonatomic)UIImageView *MainImageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TopScrollViewConstraint;
@property (weak, nonatomic) IBOutlet UIScrollView *XIUScrollView;

@property (nonatomic, strong)XIU_PickerImageCollectionVC *pickerImg;
@property (nonatomic,assign) CGFloat lastScale;
@property (nonatomic,weak) UIImage *currentImage;
@end

@implementation XIU_PictureSelectorViewController
-(UIImageView *)MainImageView{
    if (!_MainImageView) {
        _MainImageView = [[UIImageView alloc] init];
        UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
//        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];

        [_MainImageView addGestureRecognizer:pinch];
        _MainImageView.userInteractionEnabled = YES;
        [self.XIUScrollView addSubview:_MainImageView];
    }
    return _MainImageView;
}
-(void)pan:(UIPanGestureRecognizer *)pan{
    CGPoint point = [pan translationInView:self.MainImageView];
    self.MainImageView.transform = CGAffineTransformTranslate(self.MainImageView.transform, point.x, point.y);
    [pan setTranslation:CGPointZero inView:self.MainImageView];
}
-(void)pinch:(UIPinchGestureRecognizer *)pic{
    self.MainImageView.transform = CGAffineTransformScale(self.MainImageView.transform, pic.scale, pic.scale);
    CGRect frame = self.MainImageView.frame;
    frame.origin = CGPointZero;
    self.MainImageView.frame = frame;
    self.XIUScrollView.contentSize = CGSizeMake(self.MainImageView.frame.size.width, self.MainImageView.frame.size.height);
    pic.scale = 1;

    
}
-(void)updateViewConstraints {
    [super updateViewConstraints];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.TopScrollViewConstraint.constant =[UIScreen mainScreen].bounds.size.height / 2;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"尖角箭头-上"] style:UIBarButtonItemStyleDone target:self action:@selector(chickedRightBtn)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification:) name:@"MainImageNotification" object:nil];
    

}

- (void)chickedRightBtn {
    XIU_ImageProcessingVC *vc = [[XIU_ImageProcessingVC alloc] init];
    vc.sendImg = _currentImage;
//    [self.navigationController pushViewController:vc animated:YES];
    [self.navigationController presentViewController:vc animated:YES completion:nil];
    

}

- (void)notification:(NSNotification *)notificaton {
    NSLog(@"%@",notificaton.userInfo[@"img"]);
    self.currentImage = notificaton.userInfo[@"img"];
    CGFloat w = self.XIUScrollView.frame.size.width;
    CGFloat imageH = self.currentImage.size.height;
    CGFloat imageW = self.currentImage.size.width;
    CGFloat h = imageH*w/imageW;
    
    self.MainImageView.image = _currentImage;
    self.MainImageView.frame = CGRectMake(0, 0, w, h);
   _XIUScrollView.contentSize=CGSizeMake(w, h);
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    XIU_PickerImageCollectionVC *vc = [[XIU_PickerImageCollectionVC alloc] initWithNibName:@"XIU_PickerImageCollectionVC" bundle:nil];
    vc.view.frame = CGRectMake(0, MainHeight/2, self.XIUScrollView.frame.size.width, MainHeight/2);
    [self.view addSubview:vc.view];
}

@end
