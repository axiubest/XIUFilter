//
//  XIU_AssetsLibraryManager.m
//  XIU_PictureSelector
//
//  Created by XIUDeveloper on 16/9/13.
//  Copyright © 2016年 杨岫峰. All rights reserved.
//

#import "XIU_AssetsLibraryManager.h"

@interface XIU_AssetsLibraryManager ()
{
    NSMutableArray *mutableArray;

}
@property (nonatomic, strong) ALAssetsFilter *assetsFilter;

@end

@implementation XIU_AssetsLibraryManager

+ (XIU_AssetsLibraryManager *)shareManager
{
    static XIU_AssetsLibraryManager *sharedManager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}



- (void)checkOpenJurisdictionMethod {
    NSString *tipTextWhenNoPhotosAuthorization;
    
    if ([ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusRestricted || [ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusDenied) {
        NSDictionary *mainInfoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *appName = [mainInfoDictionary objectForKey:@"CFBundleDisplayName"];
        //        show reminder
        tipTextWhenNoPhotosAuthorization = [NSString stringWithFormat:@"请在设备的\"设置-隐私-照片\"选项中，允许%@访问你的手机相册", appName];
        return;
    }
    //   go through albums
    [self goThroughAlbums];
    
}

- (void)goThroughAlbums {
    
    [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if(group)
        {
            mutableArray = [self getContentFrom:group withAssetFilter:[ALAssetsFilter allPhotos]];
        
        }
    } failureBlock:^(NSError *error) {
        NSLog(@"Error Description %@",[error description]);
    }];
    
}

-(NSMutableArray *) getContentFrom:(ALAssetsGroup *) group withAssetFilter:(ALAssetsFilter *)filter
{
    [group setAssetsFilter:filter];
    [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        
        if(result)
        {
            
            if([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {

                [self.currentArray addObject:result];
            }
        }
        //倒序排列图片
        [_XIUDelegate returnAllThumbnailImageArray:(NSMutableArray *)[[self.currentArray reverseObjectEnumerator] allObjects]];
    }];
    return self.currentArray;
}


#pragma mark lazy

-(NSMutableArray *)albumsArray {
    if (!_albumsArray) {
        _albumsArray = [NSMutableArray array];
    }
    return  _albumsArray;
}

-(ALAssetsLibrary *)assetsLibrary {
    if (!_assetsLibrary) {
        _assetsLibrary = [[ALAssetsLibrary alloc] init];
        
    }
    return _assetsLibrary;
}

-(NSMutableArray *)currentArray {
    if (!_currentArray) {
        _currentArray = [NSMutableArray array];
    }
    return _currentArray;
}

@end
