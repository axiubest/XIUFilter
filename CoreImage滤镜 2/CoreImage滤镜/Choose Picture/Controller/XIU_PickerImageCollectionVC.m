//
//  XIU_PickerImageCollectionVC.m
//  XIU_PictureSelector
//
//  Created by XIUDeveloper on 16/9/14.
//  Copyright © 2016年 杨岫峰. All rights reserved.
//

#import "XIU_PickerImageCollectionVC.h"
#import "XIU_AssetsLibraryManager.h"
#import "XIU_PickerImageCollectionCell.h"
@interface XIU_PickerImageCollectionVC ()<returnAllImageDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *XIUCollectionView;

@property (nonatomic, strong)XIU_AssetsLibraryManager  *XIUmgr;

@property (nonatomic, strong)XIU_PickerImageCollectionCell *XIUCell;
/**
 *  collectionView dataSource
 */
@property (nonatomic, strong) NSMutableArray *dateSource;
@end

@implementation XIU_PickerImageCollectionVC

static NSString * const reuseIdentifier = @"Cell";

-(NSMutableArray *)dateSource {
    if (!_dateSource) {
        _dateSource = [NSMutableArray array];
    }
    return _dateSource;
}



-(XIU_AssetsLibraryManager *)XIUmgr {
    if (!_XIUmgr) {
        _XIUmgr = [XIU_AssetsLibraryManager shareManager];
        _XIUmgr.XIUDelegate = self;
    }
    return _XIUmgr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
      [self.XIUmgr checkOpenJurisdictionMethod];
    
    
    [_XIUCollectionView registerNib:[UINib nibWithNibName:@"XIU_PickerImageCollectionCell"
   bundle: nil] forCellWithReuseIdentifier:reuseIdentifier];

}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.dateSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    _XIUCell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    

    [_XIUCell applyData:[self.dateSource objectAtIndex:indexPath.row]];
 

    return _XIUCell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat size = [UIScreen mainScreen].bounds.size.width / 4 - 10;
    return (CGSize){size,size};
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 0);
}


#pragma mark collectionView select image
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    点击发送通知 按钮增加遮罩， 顶部缩略图展示， 传旨到下一页的编辑页面
    
//    asset.defaultRepresentation.fullScreenImage 获取原始图片，书写方法和获取缩略图不同。
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageWithCGImage:[[self.dateSource[indexPath.row] defaultRepresentation] fullScreenImage]],@"img", nil];
    
    
    NSNotification *not = [NSNotification notificationWithName:@"MainImageNotification" object:nil userInfo:dic];
    [[NSNotificationCenter defaultCenter] postNotification:not];

}


#pragma mark Delegate
-(void)returnAllThumbnailImageArray:(NSMutableArray *)array {

    self.dateSource = array;
    [_XIUCollectionView reloadData];
}


@end
