//
//  Template.h
//  SmartDial
//
//  Created by Evgeny Karasik on 1/8/14.
//  Copyright (c) 2014 Evgeny Karasik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Template : NSObject

@property NSString *sid;
@property NSString *Name;
@property UIImage *Image;
@property NSMutableArray *Sequence;
@property NSMutableArray *SequenceHelper;
@property NSMutableDictionary *SequenceDictionary;

-(id)init:(NSString *)_sid Name:(NSString *)_name Sequence:(NSMutableArray *)_sequence SequenceHelper:(NSMutableArray *)_sequenceHelper Image:(UIImage *)_image;

@end

