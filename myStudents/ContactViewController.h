//
//  ContactViewController.h
//  myContacts
//
//  Created by Evgeny Karasik on 12/7/13.
//  Copyright (c) 2013 Evgeny Karasik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"

@interface ContactViewController : UIViewController

@property Contact* contact;

@property (weak, nonatomic) IBOutlet UILabel *txtName;
@property (weak, nonatomic) IBOutlet UILabel *txtSmartName;
@property (weak, nonatomic) IBOutlet UILabel *txtPhone;
@property (weak, nonatomic) IBOutlet UILabel *txtSequence;

@property (weak, nonatomic) IBOutlet UIImageView *imgContactImage;
- (IBAction)callPhone:(id)sender;

@end
