//
//  NewContactViewController.h
//  myContacts
//
//  Created by Evgeny Karasik on 12/7/13.
//  Copyright (c) 2013 Evgeny Karasik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"
#import "TemplatesViewController.h"

@protocol NewContactViewControllerDelegate <NSObject>

-(void)didSave:(Contact*)contact;
-(void)didCancel;
-(IBAction)unwindToNewContact:(UIStoryboardSegue*)segue;

@end

@interface NewContactViewController : UITableViewController <TemplatesViewControllerDelegate> //<UITextFieldDelegate>

@property id<NewContactViewControllerDelegate> delegate;

@property UIImage *Image;

@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtSmartName;
@property (weak, nonatomic) IBOutlet UITextField *txtPhone;
@property (weak, nonatomic) IBOutlet UITextField *txtSequence;

@end