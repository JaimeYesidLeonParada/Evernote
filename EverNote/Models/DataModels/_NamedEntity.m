// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NamedEntity.m instead.

#import "_NamedEntity.h"

const struct NamedEntityAttributes NamedEntityAttributes = {
	.creationDate = @"creationDate",
	.modificationDate = @"modificationDate",
	.name = @"name",
};

const struct NamedEntityRelationships NamedEntityRelationships = {
};

const struct NamedEntityFetchedProperties NamedEntityFetchedProperties = {
};

@implementation NamedEntityID
@end

@implementation _NamedEntity

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"NamedEntity" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"NamedEntity";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"NamedEntity" inManagedObjectContext:moc_];
}

- (NamedEntityID*)objectID {
	return (NamedEntityID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic creationDate;






@dynamic modificationDate;






@dynamic name;











@end
