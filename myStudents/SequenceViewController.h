//
//  SequenceViewController.h
//  SmartDial
//
//  Created by Evgeny Karasik on 1/8/14.
//  Copyright (c) 2014 Evgeny Karasik. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  SequenceViewControllerDelegate <NSObject>

-(void) didDone:(NSString*)sequence Image:(UIImage*)sequenceImage;

@end



@interface SequenceViewController : UITableViewController<UIAlertViewDelegate>

@property NSMutableArray*  sequenceArray;
@property NSMutableArray*  sequenceHelperArray;
@property NSDictionary*    sequenceDictionary;
@property UIImage*         sequenceImage;
@property id<SequenceViewControllerDelegate> delegateTo;

@end
