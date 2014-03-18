//
//  TemplatesViewController.m
//  SmartDial
//
//  Created by Evgeny Karasik on 1/8/14.
//  Copyright (c) 2014 Evgeny Karasik. All rights reserved.
//

#import "TemplatesViewController.h"
#import "NewTemplateViewController.h"

@implementation TemplatesViewController

@synthesize templates;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

/* Parse login */
////////////////////////////////////////////////////////////////////////////
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([PFUser currentUser]) {
        //self.welcomeLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Welcome %@!", nil), [[PFUser currentUser] username]];
    } else {
        //self.welcomeLabel.text = NSLocalizedString(@"Not logged in", nil);
    }
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (![PFUser currentUser]) { // No user logged in
        
        //self.navigationItem.rightBarButtonItem = nil;
        // Create the log in view controller
        PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
        [logInViewController setDelegate:self]; // Set ourselves as the delegate
        
        // Create the sign up view controller
        PFSignUpViewController *signUpViewController = [[PFSignUpViewController alloc] init];
        [signUpViewController setDelegate:self]; // Set ourselves as the delegate
        
        // Assign our sign up controller to be displayed from the login controller
        [logInViewController setSignUpController:signUpViewController];
        
        // Present the log in view controller
        [self presentViewController:logInViewController animated:YES completion:NULL];
    }
}

/*
 / Sign In to Parse
 */
#pragma mark - PFLogInViewControllerDelegate

// Sent to the delegate to determine whether the log in request should be submitted to the server.
- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password {
    // Check if both fields are completed
    if (username && password && username.length && password.length) {
        return YES; // Begin login process
    }
    
    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Missing Information", nil) message:NSLocalizedString(@"Make sure you fill out all of the information!", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil] show];
    return NO; // Interrupt login process
}

// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    NSLog(@"Failed to log in...");
}

// Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    NSLog(@"User dismissed the logInViewController");
    [logInController dismissViewControllerAnimated:YES completion:NULL];
}


/*
 / Sign Up to Parse
 */
#pragma mark - PFSignUpViewControllerDelegate

// Sent to the delegate to determine whether the sign up request should be submitted to the server.
- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController shouldBeginSignUp:(NSDictionary *)info {
    BOOL informationComplete = YES;
    
    // loop through all of the submitted data
    for (id key in info) {
        NSString *field = [info objectForKey:key];
        if (!field || !field.length) { // check completion
            informationComplete = NO;
            break;
        }
    }
    
    // Display an alert if a field wasn't completed
    if (!informationComplete) {
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Missing Information", nil) message:NSLocalizedString(@"Make sure you fill out all of the information!", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil] show];
    }
    
    return informationComplete;
}

// Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when the sign up attempt fails.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error {
    NSLog(@"Failed to sign up...");
}

// Sent to the delegate when the sign up screen is dismissed.
- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController {
    NSLog(@"User dismissed the signUpViewController");
}

- (IBAction)SignOut:(id)sender {
    [PFUser logOut];
    [self.navigationController popViewControllerAnimated:YES];
}


////////////////////////////////////////////////////////////////////////////////////////

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
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

// Shows DELETE on swipe and delete the row async
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    PFObject *object = [self.objects objectAtIndex:indexPath.row];
    [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [self loadObjects];
    }];
}


- (id)initWithCoder:(NSCoder *)aCoder
{
    self = [super initWithCoder:aCoder];
    if (self) {
        self.parseClassName = @"DilingTemplate";
        self.textKey = @"Name";
        self.imageKey = @"Thumbnail";
        self.pullToRefreshEnabled = YES;
        self.paginationEnabled = YES;
        self.objectsPerPage = 25;
    }
    return self;
}


- (PFQuery *)queryForTable
{
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    if (self.objects.count == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    [query orderByDescending:@"createdAt"];
    
    return query;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    static NSString *identifier = @"TemplateCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [object objectForKey:self.textKey];
    cell.imageView.image = [UIImage imageNamed:@"na.png"];
    
    
    PFFile *thumbnail = [object objectForKey:self.imageKey];
    [thumbnail getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        // Now that the data is fetched, update the cell's image property.
        cell.imageView.image = [UIImage imageWithData:data];
    }];
    
    //cell.imageView.file = thumbnail;

    return cell;
}

-(IBAction)unwindToStudentList:(UIStoryboardSegue*)segue{
    
}

/*
 * Delegate for Save new template - async
 */
-(void)didSave:(Template *)template{
    
    PFObject *object = [PFObject objectWithClassName:self.textKey];
    object[@"Name"] = template.Name;
    object[@"Sequence"] = template.Sequence;
    object[@"SequenceHelper"] = template.SequenceHelper;
    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [self loadObjects];
    }];
}

-(void)didCancel{
    
}


-(void)didDone:(NSString *)sequence Image:(NSData *)sequenceImage{
    [self.delegate didDone:sequence Image:sequenceImage];
}


- (NSDictionary *) indexKeyedDictionaryFromArray:(NSArray *)array
{
    id objectInstance;
    
    NSMutableDictionary *mutableDictionary = [[NSMutableDictionary alloc] init];
    for (objectInstance in array)
        [mutableDictionary setObject:@"Empty" forKey:objectInstance];
    return mutableDictionary;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    if ([segue.identifier isEqualToString:@"NewTemplateSegue"])
    {
        //NewTemplateViewController *newTemplateController =
        //[segue destinationViewController];
        //newTemplateController.delegate = self;
        
    }else if ([segue.identifier isEqualToString:@"SequenceDetails"])
    {
        
        SequenceViewController *sequenceController = [segue destinationViewController];
        
        NSIndexPath *myIndexPath = [self.tableView
                                    indexPathForSelectedRow];
        
        PFObject *object = [self.objects objectAtIndex:myIndexPath.row];
        Template *curTemplate = [[Template alloc]init];
        curTemplate.Name = [object objectForKey:@"Name"];
        curTemplate.Sequence = [object objectForKey:@"Sequence"];
        curTemplate.SequenceHelper = [object objectForKey:@"SequenceHelper"];
        
        PFFile *thumbnail = [object objectForKey:self.imageKey];
        [thumbnail getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!error) {
                sequenceController.sequenceImage = [UIImage imageWithData:data];

            }
        }];
        
        sequenceController.sequenceArray = [[NSMutableArray alloc] initWithArray: [curTemplate.Sequence copy]];
        sequenceController.sequenceHelperArray = [[NSMutableArray alloc] initWithArray: [curTemplate.SequenceHelper copy]];
        sequenceController.sequenceDictionary = [self indexKeyedDictionaryFromArray:curTemplate.Sequence];
        
        sequenceController.delegateTo = self;
    }
}

@end
