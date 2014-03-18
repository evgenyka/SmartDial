//
//  SequenceViewController.m
//  SmartDial
//
//  Created by Evgeny Karasik on 1/8/14.
//  Copyright (c) 2014 Evgeny Karasik. All rights reserved.
//

#import "SequenceViewController.h"
#import "Template.h"

@interface SequenceViewController ()

@property (strong, nonatomic) NSIndexPath *indexPathToBeUpdated;

@end

@implementation SequenceViewController

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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.sequenceArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SequenceCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [self.sequenceArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [self.sequenceDictionary valueForKey:[self.sequenceArray objectAtIndex:indexPath.row]];

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.indexPathToBeUpdated = indexPath;
    
    UIAlertView * alert = [[UIAlertView alloc]
                           initWithTitle:[self.sequenceArray objectAtIndex:indexPath.row]
                           message:[self.sequenceHelperArray objectAtIndex:indexPath.row]
                           delegate:self
                           cancelButtonTitle:@"Save"
                           otherButtonTitles:nil];
    
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSString *value =[[alertView textFieldAtIndex:0] text];
    NSIndexPath * indexPath = _indexPathToBeUpdated;
    
    [self.sequenceDictionary setValue:value forKey:[self.sequenceArray objectAtIndex:indexPath.row]];
    
    [self.tableView reloadData];
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SaveNewSequence"])
        {
            // Build sequence dial string
            NSMutableString *sequence = [NSMutableString string];
            // get all keys into array (for sorting)
            NSArray * keys = [self.sequenceDictionary allKeys];
            //Sort all keys in array
            NSArray * sorted_keys = [keys sortedArrayUsingSelector:@selector(compare:)];
            // Append sorted values to string
            for (id key in sorted_keys)
            {
                [sequence appendString:@", "];
                [sequence appendString:[self.sequenceDictionary objectForKey:key]];
            }
            [self.delegateTo didDone:sequence Image:self.sequenceImage];
        }
    }

@end
