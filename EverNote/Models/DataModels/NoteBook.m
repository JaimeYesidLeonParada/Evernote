#import "NoteBook.h"


@interface NoteBook ()

+(NSArray *)observableKeyNames;

@end


@implementation NoteBook

+(NSArray *)observableKeyNames
{
    return @[@"creationDate", @"name", @"notes"];
}


+ (instancetype)notebookWithName:(NSString *)name
                         context:(NSManagedObjectContext *)context{
    
    NoteBook *nb = [NSEntityDescription insertNewObjectForEntityForName:[NoteBook entityName] inManagedObjectContext:context];
    
    nb.name = name;
    nb.creationDate = [NSDate date];
    nb.modificationDate = [NSDate date];
    
    return nb;
}


@end
