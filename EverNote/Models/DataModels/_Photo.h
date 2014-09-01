// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Photo.h instead.

#import <CoreData/CoreData.h>


extern const struct PhotoAttributes {
	__unsafe_unretained NSString *imageData;
} PhotoAttributes;

extern const struct PhotoRelationships {
	__unsafe_unretained NSString *notes;
} PhotoRelationships;

extern const struct PhotoFetchedProperties {
} PhotoFetchedProperties;

@class Note;



@interface PhotoID : NSManagedObjectID {}
@end

@interface _Photo : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PhotoID*)objectID;





@property (nonatomic, strong) NSData* imageData;



//- (BOOL)validateImageData:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) Note *notes;

//- (BOOL)validateNotes:(id*)value_ error:(NSError**)error_;





@end

@interface _Photo (CoreDataGeneratedAccessors)

@end

@interface _Photo (CoreDataGeneratedPrimitiveAccessors)


- (NSData*)primitiveImageData;
- (void)setPrimitiveImageData:(NSData*)value;





- (Note*)primitiveNotes;
- (void)setPrimitiveNotes:(Note*)value;


@end
