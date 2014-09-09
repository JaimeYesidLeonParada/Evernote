// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MapSnapshot.h instead.

#import <CoreData/CoreData.h>


extern const struct MapSnapshotAttributes {
	__unsafe_unretained NSString *snapshotData;
} MapSnapshotAttributes;

extern const struct MapSnapshotRelationships {
	__unsafe_unretained NSString *location;
} MapSnapshotRelationships;

extern const struct MapSnapshotFetchedProperties {
} MapSnapshotFetchedProperties;

@class Location;



@interface MapSnapshotID : NSManagedObjectID {}
@end

@interface _MapSnapshot : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (MapSnapshotID*)objectID;





@property (nonatomic, strong) NSData* snapshotData;



//- (BOOL)validateSnapshotData:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) Location *location;

//- (BOOL)validateLocation:(id*)value_ error:(NSError**)error_;





@end

@interface _MapSnapshot (CoreDataGeneratedAccessors)

@end

@interface _MapSnapshot (CoreDataGeneratedPrimitiveAccessors)


- (NSData*)primitiveSnapshotData;
- (void)setPrimitiveSnapshotData:(NSData*)value;





- (Location*)primitiveLocation;
- (void)setPrimitiveLocation:(Location*)value;


@end
