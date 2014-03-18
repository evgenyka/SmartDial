//
//  NewTemplateViewController.m
//  SmartDial
//
//  Created by Evgeny Karasik on 1/8/14.
//  Copyright (c) 2014 Evgeny Karasik. All rights reserved.
//

#import "NewTemplateViewController.h"

@interface NewTemplateViewController ()

@end

@implementation NewTemplateViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SaveNewTemplate"])
    {
       /*
        Template *ct = [[template alloc] init:self.txtSID.text Name:self.txtName.text SmartName:self.txtSmartName.text phone:self.txtPhone.text Sequence:self.txtSequence.text];
        
        */
        
        //[self.delegate didSave:ct];
        
    }
}


@end
