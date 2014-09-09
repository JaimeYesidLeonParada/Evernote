#import "_MapSnapshot.h"


@interface MapSnapshot : _MapSnapshot {}
// Custom logic goes here.

@property (nonatomic, strong) UIImage *image;

+(instancetype)mapSnapshotForLocation:(Location*)location;

@end
