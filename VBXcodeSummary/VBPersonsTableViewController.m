//
//  VBPersonsTableViewController.m
//  VBXcodeSummary
//
//  Created by Ariel Rodriguez on 09/09/13.
//  Copyright (c) 2013 VolonBolon. All rights reserved.
//

#import "VBPersonsTableViewController.h"
#import "VBPersonViewController.h"
#import "VBPerson.h"

@interface VBPersonsTableViewController ()
@property (nonatomic, strong) NSArray *persons;

- (NSString *)personsArchivePath;
- (void)handleAppDidEnterBackgroundNotification:(NSNotification *)notification;
@end

@implementation VBPersonsTableViewController
- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleAppDidEnterBackgroundNotification:)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
    
    NSString *personsArchivePath = [self personsArchivePath];
    
    if ( ![[NSFileManager defaultManager] fileExistsAtPath:personsArchivePath] ) {
        
        personsArchivePath = [[NSBundle mainBundle] pathForResource:@"persons"
                                                             ofType:@"data"];
        
    } 
    
    NSArray *persons = [NSKeyedUnarchiver unarchiveObjectWithFile:personsArchivePath];
    
    [self setPersons:persons];
    
}

- (void)viewDidLoad {

    [super viewDidLoad];

}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}
    
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
 
    return [[self persons] count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"PersonsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    VBPerson *person = [[self persons] objectAtIndex:[indexPath row]];
    
    NSString *textString = [[NSString alloc] initWithFormat:@"%@ %@", [person firstName], [person lastName]];
    
    [[cell textLabel] setText:textString];
    
    static NSDateFormatter *dateFormatter = nil;
    
    if ( dateFormatter == nil ) {
        
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
        
    }
    
    [[cell detailTextLabel] setText:[dateFormatter stringFromDate:[person dateOfBirth]]];
    
    return cell;
}

- (IBAction)doneAddingPerson:(UIStoryboardSegue *)segue {
    
    VBPersonViewController *sourceViewController = (VBPersonViewController *)[segue sourceViewController];
    VBPerson *person = [sourceViewController person];
    
    NSMutableArray *mutablePersons = [[self persons] mutableCopy];
    [mutablePersons addObject:person];
    [self setPersons:mutablePersons];
    
    [[self tableView] reloadData];
    
}

- (NSString *)personsArchivePath {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = ([paths count]>0)?[paths objectAtIndex:0]:nil;
    NSString *personsPath = [documentsPath stringByAppendingPathComponent:@"persons.data"];
    
    return personsPath;

}

- (void)handleAppDidEnterBackgroundNotification:(NSNotification *)notification {
    
    NSString *personsPath = [self personsArchivePath];
    NSData *personsData = [NSKeyedArchiver archivedDataWithRootObject:[self persons]];
    [personsData writeToFile:personsPath
                  atomically:YES];
    
}

@end
