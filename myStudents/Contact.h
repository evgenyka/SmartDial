//
//  Student.h
//  myStudents
//
//  Created by Evgeny Karasik on 12/7/13.
//  Copyright (c) 2013 Evgeny Karasik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject

@property NSString *Name;
@property NSString *SmartName;
@property NSString *sId;
@property NSString *Phone;
@property NSString *Sequence;
@property UIImage *Image;

-(id)init:(NSString *)_sid Name:(NSString *)_name SmartName:(NSString *)_smartname phone:(NSString *)_phone Sequence:(NSString *)_sequence Image:(UIImage *)_image;

@end
