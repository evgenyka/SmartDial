//
//  NewContactViewController.m
//  myContacts
//
//  Created by Evgeny Karasik on 12/7/13.
//  Copyright (c) 2013 Evgeny Karasik. All rights reserved.
//

#import "NewContactViewController.h"
#import "Contact.h"
#import "TemplatesViewController.h"

@interface NewContactViewController ()

@end

@implementation NewContactViewController


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)unwindToNewContact:(UIStoryboardSegue*)segue{
    
}


-(void)didDone:(NSString *)sequence Image:(UIImage *)sequenceImage{
    NSString* fullNumber = [NSString stringWithFormat:@"%@%@", self.txtPhone.text,sequence];
    self.txtSequence.text =   fullNumber;
    self.Image = sequenceImage;
    [self.tableView reloadData];
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SaveNewContact"])
    {
        // Use unique ID
        NSUUID  *UUID = [NSUUID UUID];
        NSString* stringUUID = [UUID UUIDString];
        Contact *ct = [[Contact alloc] init:stringUUID Name:self.txtName.text SmartName:self.txtSmartName.text phone:self.txtPhone.text Sequence:self.txtSequence.text Image:self.Image];
        
        [self.delegate didSave:ct];
        
    }
    
    else if ([segue.identifier isEqualToString:@"SequencesList"])
    {
        
        TemplatesViewController *TemplatesController = [segue destinationViewController];
        TemplatesController.delegate = self;
    
    }
}

@end
