//
//  Template.m
//  SmartDial
//
//  Created by Evgeny Karasik on 1/8/14.
//  Copyright (c) 2014 Evgeny Karasik. All rights reserved.
//

#import "Template.h"

@implementation Template

@synthesize sid;
@synthesize Name;
@synthesize Sequence;
@synthesize SequenceHelper;
@synthesize SequenceDictionary;
@synthesize Image;

-(id)init:(NSString *)_sid Name:(NSString *)_name Sequence:(NSMutableArray *)_sequence SequenceHelper:(NSMutableArray *)_sequenceHelper Image:(UIImage *)_image{
    self = [super init];
    if(self){
        sid = _sid;
        Name = _name;
        Sequence = _sequence;
        SequenceHelper = _sequenceHelper;
        Image = _image;
    }
    return self;
}

@end
