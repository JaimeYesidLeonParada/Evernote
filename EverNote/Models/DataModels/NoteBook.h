#import "_NoteBook.h"

@interface NoteBook : _NoteBook {}
// Custom logic goes here.

+ (instancetype)notebookWithName:(NSString *)name
                         context:(NSManagedObjectContext *)context;

@end
