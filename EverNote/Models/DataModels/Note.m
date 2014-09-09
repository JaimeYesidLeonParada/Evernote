#import "Note.h"
#import "Location.h"


@interface Note () <CLLocationManagerDelegate>

+(NSArray*)observableKeyNames;

@property (nonatomic, strong) CLLocationManager *locationManager;

@end


@implementation Note

@synthesize locationManager = _locationManager;

-(BOOL)hasLocation
{
    return (nil != self.location);
}

+(NSArray*)observableKeyNames
{
    return @[@"name", @"creationDate", @"notebook", @"photo", @"location"];
}

+(instancetype) noteWithName:(NSString *)name
                    notebook:(NoteBook *)notebook
                     context:(NSManagedObjectContext *)context{
    
    Note *note = [NSEntityDescription insertNewObjectForEntityForName:[Note entityName] inManagedObjectContext:context];
    
    note.name = name;
    note.creationDate = [NSDate date];
    note.notebook = notebook;
    note.modificationDate = [NSDate date];
    
    return note;
}

#pragma mark - Init
-(void)awakeFromInsert
{
    //[self awakeFromInsert];
    
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    if ((status == kCLAuthorizationStatusAuthorized) || ((status == kCLAuthorizationStatusNotDetermined) && ([CLLocationManager locationServicesEnabled]))) {
        self.locationManager = [CLLocationManager new];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [self.locationManager startUpdatingLocation];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self zapLocationManager];
        });
        
    }
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    [self zapLocationManager];
    
    if (![self hasLocation]) {
        CLLocation *lastLocation = [locations lastObject];
        self.location = [Location locationWithCLLocation:lastLocation forNote:self];
    }else{
        NSLog(@"Error location");
    }
}

- (void)zapLocationManager
{
    [self.locationManager stopUpdatingLocation];
    self.locationManager.delegate = nil;
    self.locationManager = nil;
}



@end
