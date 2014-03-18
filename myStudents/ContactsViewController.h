//
//  ContactsViewController.h
//  myContacts
//
//  Created by Evgeny Karasik on 12/7/13.
//  Copyright (c) 2013 Evgeny Karasik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewContactViewController.h"


@interface ContactsViewController : UITableViewController<NewContactViewControllerDelegate>

@property NSMutableArray* contacts;
@property NSArray *searchResults;

-(IBAction)unwindToContacts:(UIStoryboardSegue*)segue;
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;
-(void)didSave:(Contact *)Contact;

@end
