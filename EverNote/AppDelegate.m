//
//  AppDelegate.m
//  EverNote
//
//  Created by Yesid Leon on 27/07/14.
//  Copyright (c) 2014 Yesid Leon. All rights reserved.
//

#import "AppDelegate.h"
#import "AGTSimpleCoreDataStack.h"
#import "Note.h"
#import "NoteBook.h"
#import "NotebooksViewController.h"
#import "UIViewController+Navigation.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //Crear instancia de stack CoreData
    self.model = [AGTSimpleCoreDataStack coreDataStackWithModelName:@"ModelNotas"];
    
    [self trastearConDatos];
    //[self autosave];
    
    //[self predicateTest];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[NoteBook entityName]];
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:NamedEntityAttributes.modificationDate
                                                          ascending:NO],
                            [NSSortDescriptor sortDescriptorWithKey:NamedEntityAttributes.name
                                                          ascending:YES]];
    req.fetchBatchSize = 20;
    
    NSFetchedResultsController *results = [[NSFetchedResultsController alloc] initWithFetchRequest:req
                                                                              managedObjectContext:self.model.context
                                                                                sectionNameKeyPath:nil
                                                                                         cacheName:nil];
    
    NotebooksViewController *nbVC = [[NotebooksViewController alloc] initWithFetchedResultsController:results
                                                                                                style:UITableViewStylePlain];
    
    self.window.rootViewController = [nbVC wrappedInNavigation];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [self save];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [self save];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - Utils
- (void)trastearConDatos{
    
    [self.model zapAllData];
    
    NoteBook *novias = [NoteBook notebookWithName:@"Ex-novias para el recuerdo"
                                          context:self.model.context];
    
    [Note noteWithName:@"Camila Davalos"
              notebook:novias
               context:self.model.context];
    
     [Note noteWithName:@"Pampita"
              notebook:novias
               context:self.model.context];
    
    NoteBook *modelos = [NoteBook notebookWithName:@"Modelos"
                                          context:self.model.context];
    
    [Note noteWithName:@"Natalia Paris"
              notebook:modelos
               context:self.model.context];
    
    [Note noteWithName:@"Tatiana de los Rios"
              notebook:modelos
               context:self.model.context];
    
    
    
    /*
    
    //Eliminar
    [self.model.context deleteObject:pampita];

    
    
    //Buscar
    NSFetchRequest *req = [[NSFetchRequest alloc] initWithEntityName:[Note entityName]];
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:NamedEntityAttributes.name ascending:YES], [NSSortDescriptor sortDescriptorWithKey:NamedEntityAttributes.modificationDate ascending:NO]];
    
    NSError *error = nil;
    
    NSArray *results = [self.model.context executeFetchRequest:req
                                                         error:&error];
    
    if (results == nil) {
        NSLog(@"Error al buscar: %@", results);
    }else{
        NSLog(@"Results: %@", results);
    }
    */
    
    
    //Guardamos
    [self save];
}

- (void)save{
    [self.model saveWithErrorBlock:^(NSError *error) {
        NSLog(@"Error al guardar %s  \n\n  %@", __func__ , error);
    }];
}

- (void)autosave {
    
    if (AUTO_SAVE) {
        NSLog(@"Autoguardando");
        [self save];
        [self performSelector:@selector(autosave)
                   withObject:nil
                   afterDelay:AUTO_SAVE_DELAY_IN_SECONS];
    }
    
}

#pragma mark -Predicate Playground
/*
- (void)predicateTest
{
    NSPredicate *novias = [NSPredicate predicateWithFormat:@"notebook.name ==[cd] 'Ex-novias para el recuerdo'"];
    NSPredicate *davalos = [NSCompoundPredicate andPredicateWithSubpredicates:@[novias,[NSPredicate predicateWithFormat:@"name ENDSWITH[cd] 'davalos'"]]];
    NSPredicate *pampita = [NSCompoundPredicate andPredicateWithSubpredicates:@[novias, [NSPredicate predicateWithFormat:@"name CONTAINS[cd] 'pampita'"]]];
    
    
    
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[Note entityName]];
    NSArray *result = nil;
    
    req.predicate = novias;
    result = [self.model executeRequest:req
                              withError:^(NSError *error)
    {
        NSLog(@"Error buscando %@", req);
    }];
    //NSLog(@"Results: \n %@", result);
    
    req.predicate = davalos;
    result = [self.model executeRequest:req withError:^(NSError *error) {
        NSLog(@"Error buscando %@", req);
    }];
    //NSLog(@"Results: \n %@", result);
    
    req.predicate = pampita;
    result = [self.model executeRequest:req withError:^(NSError *error) {
        NSLog(@"Error buscando %@", req);
    }];
    NSLog(@"Results: \n %@", result);
}


- (void)samplePredicate{
    
    NSPredicate *test = [NSPredicate predicateWithFormat:@"surname == 'Dávalos'"];
    NSPredicate *test2 = [NSPredicate predicateWithFormat:@"surname == %@", @"Dávalos"];
    NSPredicate *test3 = [NSPredicate predicateWithFormat:@"isGeolocalized == YES"];
    NSPredicate *sithWannabe = [NSPredicate predicateWithFormat:@"jedi.laserSabre.color = %@", [UIColor redColor]];
    NSPredicate *earlier = [NSPredicate predicateWithFormat:@"dateOfBirth < %@",  [NSDate date]];
    
    NSString *key = NamedEntityAttributes.modificationDate;
    NSDate *value = [NSDate date];
    NSPredicate *t4 = [NSPredicate predicateWithFormat:@"%K == %@", key, value];
    
    NSDictionary *substVars = @{@"LAST_ACCESS" : [NSDate date]};
    
    
    
}
*/













@end
