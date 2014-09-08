#import "Location.h"
#import "Note.h"

@import AddressBookUI;

@interface Location ()

// Private interface goes here.

@end


@implementation Location

+(instancetype)locationWithCLLocation:(CLLocation*)location
                              forNote:(Note*)note
{
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[Location entityName]];
    
    NSPredicate *latitude = [NSPredicate predicateWithFormat:@"abs(latitude) - abs(%lf) < 0.001", location.coordinate.latitude];
    NSPredicate *longitude = [NSPredicate predicateWithFormat:@"abs(longitude) - abs(%lf) < 0.001", location.coordinate.longitude];
    req.predicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[latitude, longitude]];
    
    NSError *error = nil;
    NSArray *results = [note.managedObjectContext executeFetchRequest:req
                                                                error:&error];
    NSAssert(results, @"Error buscando datos");
    
    if ([results count]) {
        Location *found = [results lastObject];
        [found addNotesObject:note];
        return found;
    }else{
        Location *loc = [self insertInManagedObjectContext:note.managedObjectContext];
        loc.latitudeValue = location.coordinate.latitude;
        loc.longitudeValue = location.coordinate.longitude;
        [loc addNotesObject:note];
        
        CLGeocoder *code = [CLGeocoder new];
        [code reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
            if(error){
                NSLog(@"Error obtaining location");
            }else{
                loc.address = ABCreateStringWithAddressDictionary([[placemarks lastObject] addressDictionary], YES);
            }
            
        }];
        return loc;
    }
}

@end
