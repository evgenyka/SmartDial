//
//  Model.h
//  myContacts
//
//  Created by Evgeny Karasik on 12/7/13.
//  Copyright (c) 2013 Evgeny Karasik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Contact.h"

@interface Model : NSObject

@property (nonatomic)  sqlite3 *myDatabase;

+(Model *)getInstance;

-(NSMutableArray*)getAllContacts;
-(bool)addContact:(Contact*)contact;
-(bool)deleteContact:(Contact*)contact;

@end
