//
//  NewTemplateViewController.h
//  SmartDial
//
//  Created by Evgeny Karasik on 1/8/14.
//  Copyright (c) 2014 Evgeny Karasik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Template.h"
#import "NewTemplateViewController.h"

@protocol NewTemplateViewControllerDelegate <NSObject>

-(void)didSave:(Template*)template;
-(void)didCancel;

@end

@interface NewTemplateViewController : UITableViewController<UITextFieldDelegate>

@property id<NewTemplateViewControllerDelegate> delegate;

@end
