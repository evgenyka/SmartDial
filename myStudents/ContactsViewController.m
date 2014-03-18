//
//  ContactsViewController.m
//  myContacts
//
//  Created by Evgeny Karasik on 12/7/13.
//  Copyright (c) 2013 Evgeny Karasik. All rights reserved.
//

#import "ContactsViewController.h"
#import "Contact.h"
#import "NewContactViewController.h"
#import "ContactViewController.h"
#import "Model.h"

@interface ContactsViewController ()

@end

@implementation ContactsViewController

@synthesize contacts;
@synthesize searchResults;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    contacts = [[Model getInstance] getAllContacts];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Count the Search results
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [searchResults count];
        
    } else {
        return [contacts count];
        
    }
}

// Interact with selection in Search results
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        [self performSegueWithIdentifier: @"ContactDetails" sender: self];
    }
}

// Shows DELETE on swipe and delete the row
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    Contact *contact = [contacts objectAtIndex:indexPath.row];
    [[Model getInstance] deleteContact:contact];
    contacts = [[Model getInstance] getAllContacts];
    [self.tableView reloadData];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ContactCell";

    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    Contact *contact;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        // Search results
        contact = [searchResults objectAtIndex:indexPath.row];
    } else {
        contact = [contacts objectAtIndex:indexPath.row];
    }
    
	cell.textLabel.text =  [NSString stringWithFormat:@"%@", contact.Name];
	cell.detailTextLabel.text = [NSString stringWithFormat:@"(%@)",contact.SmartName];
    cell.imageView.image = contact.Image;
    
    NSLog(@"description = %@",[cell description]);
    return cell;
}

-(IBAction)unwindToContacts:(UIStoryboardSegue*)segue{

}

-(IBAction)unwindToNewContact:(UIStoryboardSegue*)segue{
    
}

-(void)didSave:(Contact *)contact{
    // Save to DB
    [[Model getInstance] addContact:contact];
    // Reload from DB to get sorted list
    contacts = [[Model getInstance] getAllContacts];
    // Bind to view by reload
    [self.tableView reloadData];
}

-(void)didCancel{
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"NewContactSegue"])
    {
        NewContactViewController *newContactController = [segue destinationViewController];
        
        newContactController.delegate = self;
        
    }else if ([segue.identifier isEqualToString:@"ContactDetails"])
    {
        
        ContactViewController *ContactController = [segue destinationViewController];
        NSIndexPath *myIndexPath = nil;
        
        if ([self.searchDisplayController isActive]) {
            // Search results
            myIndexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            ContactController.contact = [searchResults objectAtIndex:myIndexPath.row];
        } else {
            myIndexPath = [self.tableView indexPathForSelectedRow];
            ContactController.contact = [contacts objectAtIndex:myIndexPath.row];
        }
    }
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF.Name contains[cd] %@",
                                    searchText];
    
    searchResults = [contacts filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}



@end
