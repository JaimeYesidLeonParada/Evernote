#import "_Photo.h"

@interface Photo : _Photo {}
// Custom logic goes here.

+(instancetype) photoWithImage:(UIImage *)image
                       context:(NSManagedObjectContext *)context;

@end
