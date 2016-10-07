//
//  XIU_MainSliderView.m
//  CoreImage滤镜
//
//  Created by XIUDeveloper on 16/9/10.
//  Copyright © 2016年 XIU. All rights reserved.
//

#import "XIU_MainSliderView.h"
#import "XIU_EditImageManager.h"
@interface XIU_MainSliderView ()

@property (nonatomic, strong)XIU_EditImageManager *edit;
@end

@implementation XIU_MainSliderView

-(void)awakeFromNib {
    [super awakeFromNib];
    [self commitInit];
}

-(XIU_EditImageManager *)edit {
    if (!_edit) {
        _edit = [XIU_EditImageManager shareManager];
    }
    return _edit;
}

- (void)commitInit {
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(20, self.frame.size.height / 2 - 10, [UIScreen mainScreen].bounds.size.width - 40, 20)];
    [slider addTarget:self action:@selector(scrollSliderView:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:slider];
}


- (void)scrollSliderView:(UISlider *)slider {
   [ self.edit changeBrightness:slider];
}
@end
