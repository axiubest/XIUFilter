

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
@interface ImageUtil : NSObject 

+ (UIImage *)imageWithImage:(UIImage*)inImage withColorMatrix:(const float*)f;



// Open GLES
//+ (UIImage *)XIU_GLimageWithImage:(UIImage*)inImage withColorMatrix:(const float*)f;


+(UIImage *)imageWithImage:(UIImage *)img filterName:(NSString *)filterName;
@end
