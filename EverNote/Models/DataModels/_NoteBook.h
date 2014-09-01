// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NoteBook.h instead.

#import <CoreData/CoreData.h>
#import "NamedEntity.h"

extern const struct NoteBookAttributes {
} NoteBookAttributes;

extern const struct NoteBookRelationships {
	__unsafe_unretained NSString *notes;
} NoteBookRelationships;

extern const struct NoteBookFetchedProperties {
} NoteBookFetchedProperties;

@class Note;


@interface NoteBookID : NSManagedObjectID {}
@end

@interface _NoteBook : NamedEntity {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (NoteBookID*)objectID;





@property (nonatomic, strong) NSSet *notes;

- (NSMutableSet*)notesSet;





@end

@interface _NoteBook (CoreDataGeneratedAccessors)

- (void)addNotes:(NSSet*)value_;
- (void)removeNotes:(NSSet*)value_;
- (void)addNotesObject:(Note*)value_;
- (void)removeNotesObject:(Note*)value_;

@end

@interface _NoteBook (CoreDataGeneratedPrimitiveAccessors)



- (NSMutableSet*)primitiveNotes;
- (void)setPrimitiveNotes:(NSMutableSet*)value;


@end
