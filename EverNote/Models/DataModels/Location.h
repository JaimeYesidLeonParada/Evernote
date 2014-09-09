#import "_Location.h"

@import CoreLocation;
@class Note;
@interface Location : _Location <MKAnnotation> {}
// Custom logic goes here.

+(instancetype)locationWithCLLocation:(CLLocation*)location
                              forNote:(Note*)note;

@end
