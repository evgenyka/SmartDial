//
//  ContactViewController.m
//  myContacts
//
//  Created by Evgeny Karasik on 12/7/13.
//  Copyright (c) 2013 Evgeny Karasik. All rights reserved.
//

#import "ContactViewController.h"

@interface ContactViewController ()

@end

@implementation ContactViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //self.txtSID.text = self.contact.sId;
    self.txtName.text = self.contact.Name;
    self.txtSmartName.text = self.contact.SmartName;
    self.txtPhone.text = self.contact.Phone;
    self.txtSequence.text = self.contact.Sequence;
    
    [self.imgContactImage setImage:self.contact.Image];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)callPhone:(id)sender {
    NSString *DialString = [self.contact.Phone stringByAppendingString: self.contact.Sequence];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:DialString]];
}

@end
