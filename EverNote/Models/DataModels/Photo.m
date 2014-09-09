#import "Photo.h"


@interface Photo ()

// Private interface goes here.

@end


@implementation Photo

#pragma mark - Properties
-(void) setImage:(UIImage *)image
{
    self.imageData = UIImageJPEGRepresentation(image, 0.9);
}

- (UIImage*)image
{
    return [UIImage imageWithData:self.imageData];
}

#pragma mark - Class Methos
+(instancetype) photoWithImage:(UIImage *)image
                       context:(NSManagedObjectContext *)context
{
    Photo *photo = [NSEntityDescription insertNewObjectForEntityForName:[Photo entityName] inManagedObjectContext:context];
    
    photo.imageData = UIImageJPEGRepresentation(image, 0.9);
    
    return photo;
}

@end
