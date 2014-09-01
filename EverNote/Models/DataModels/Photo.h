#import "_Photo.h"

@interface Photo : _Photo {}
// Custom logic goes here.

@property (nonatomic, strong) UIImage *image;

+(instancetype) photoWithImage:(UIImage *)image
                       context:(NSManagedObjectContext *)context;

@end
