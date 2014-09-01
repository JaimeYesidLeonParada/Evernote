// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NoteBook.m instead.

#import "_NoteBook.h"

const struct NoteBookAttributes NoteBookAttributes = {
};

const struct NoteBookRelationships NoteBookRelationships = {
	.notes = @"notes",
};

const struct NoteBookFetchedProperties NoteBookFetchedProperties = {
};

@implementation NoteBookID
@end

@implementation _NoteBook

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"NoteBook" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"NoteBook";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"NoteBook" inManagedObjectContext:moc_];
}

- (NoteBookID*)objectID {
	return (NoteBookID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic notes;

	
- (NSMutableSet*)notesSet {
	[self willAccessValueForKey:@"notes"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"notes"];
  
	[self didAccessValueForKey:@"notes"];
	return result;
}
	






@end
