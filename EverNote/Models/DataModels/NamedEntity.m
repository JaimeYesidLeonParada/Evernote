#import "NamedEntity.h"


@interface NamedEntity ()

+ (NSArray *)observableKeyNames;

@end


@implementation NamedEntity

#pragma mark - Class Methos
+ (NSArray *)observableKeyNames
{
    return @[@"name", @"creationDate"];
}


#pragma mark - KVO
- (void)setupKVO
{
    
    [[[self class] observableKeyNames] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self addObserver:self
               forKeyPath:obj
                  options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                  context:NULL];
    }];
}


- (void)tearDownKVO
{
    
    [[[self class] observableKeyNames] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self removeObserver:self
                  forKeyPath:obj];
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    self.modificationDate = [NSDate date];
}


#pragma mark - LifeCicle

- (void)awakeFromInsert
{
    [super awakeFromInsert];
    [self setupKVO];
}

- (void)awakeFromFetch
{
    [super awakeFromFetch];
    [self setupKVO];
}

- (void)willTurnIntoFault
{
    [super willTurnIntoFault];
    [self tearDownKVO];
}


@end
