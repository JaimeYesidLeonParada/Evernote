#import "Note.h"


@interface Note ()

+(NSArray*)observableKeyNames;

@end


@implementation Note

+(NSArray*)observableKeyNames
{
    return @[@"name", @"creationDate", @"notebook", @"photo"];
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

@end
