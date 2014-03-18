//
//  TemplatesViewController.h
//  SmartDial
//
//  Created by Evgeny Karasik on 1/8/14.
//  Copyright (c) 2014 Evgeny Karasik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Template.h"
#import "TemplateViewController.h"
#import "SequenceViewController.h"
#import <Parse/Parse.h>


@protocol  TemplatesViewControllerDelegate <NSObject>

-(void) didDone:(NSString*)sequence Image:(NSData *)sequenceImage;

@end

@interface TemplatesViewController : PFQueryTableViewController<SequenceViewControllerDelegate,PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@property NSMutableArray* templates;
@property id<TemplatesViewControllerDelegate> delegate;

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;
-(void)didSave:(Template *)template;
-(NSDictionary *) indexKeyedDictionaryFromArray:(NSArray *)array;
- (IBAction)SignOut:(id)sender;

@end
