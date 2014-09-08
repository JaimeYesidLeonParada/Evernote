#import "_Note.h"

@interface Note : _Note {}
// Custom logic goes here.
//mogenerator -m ModelNotas.xcdatamodeld/ModelNotas.xcdatamodel/ --template-var arc=yes


@property (nonatomic, readonly) BOOL hasLocation;

+(instancetype) noteWithName:(NSString *)name
                    notebook:(NoteBook *)notebook
                     context:(NSManagedObjectContext *)context;



@end
