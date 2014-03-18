//
//  Contact.m
//  myContacts
//
//  Created by Evgeny Karasik on 12/7/13.
//  Copyright (c) 2013 Evgeny Karasik. All rights reserved.
//

#import "Contact.h"

@implementation Contact

@synthesize Name;
@synthesize SmartName;
@synthesize sId;
@synthesize Phone;
@synthesize Sequence;
@synthesize Image;

-(id)init:(NSString *)_sid Name:(NSString *)_name SmartName:(NSString *)_smartname phone:(NSString *)_phone Sequence:(NSString *)_sequence Image:(UIImage *)_image{
    self = [super init];
    if(self){
        sId = _sid;
        Name = _name;
        SmartName = _smartname;
        Phone = _phone;
        Sequence = _sequence;
        Image = _image;
    }
    return self;
}



@end
