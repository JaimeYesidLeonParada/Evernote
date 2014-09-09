// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MapSnapshot.m instead.

#import "_MapSnapshot.h"

const struct MapSnapshotAttributes MapSnapshotAttributes = {
	.snapshotData = @"snapshotData",
};

const struct MapSnapshotRelationships MapSnapshotRelationships = {
	.location = @"location",
};

const struct MapSnapshotFetchedProperties MapSnapshotFetchedProperties = {
};

@implementation MapSnapshotID
@end

@implementation _MapSnapshot

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"MapSnapshot" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"MapSnapshot";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"MapSnapshot" inManagedObjectContext:moc_];
}

- (MapSnapshotID*)objectID {
	return (MapSnapshotID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic snapshotData;






@dynamic location;

	






@end
