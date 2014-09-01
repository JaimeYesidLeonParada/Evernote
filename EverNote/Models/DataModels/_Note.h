// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Note.h instead.

#import <CoreData/CoreData.h>
#import "NamedEntity.h"

extern const struct NoteAttributes {
	__unsafe_unretained NSString *text;
} NoteAttributes;

extern const struct NoteRelationships {
	__unsafe_unretained NSString *notebook;
	__unsafe_unretained NSString *photo;
} NoteRelationships;

extern const struct NoteFetchedProperties {
} NoteFetchedProperties;

@class NoteBook;
@class Photo;



@interface NoteID : NSManagedObjectID {}
@end

@interface _Note : NamedEntity {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (NoteID*)objectID;





@property (nonatomic, strong) NSString* text;



//- (BOOL)validateText:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NoteBook *notebook;

//- (BOOL)validateNotebook:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) Photo *photo;

//- (BOOL)validatePhoto:(id*)value_ error:(NSError**)error_;





@end

@interface _Note (CoreDataGeneratedAccessors)

@end

@interface _Note (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveText;
- (void)setPrimitiveText:(NSString*)value;





- (NoteBook*)primitiveNotebook;
- (void)setPrimitiveNotebook:(NoteBook*)value;



- (Photo*)primitivePhoto;
- (void)setPrimitivePhoto:(Photo*)value;


@end
