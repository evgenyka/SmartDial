//
//  Model.m
//  myContacts
//
//  Created by Evgeny Karasik on 12/7/13.
//  Copyright (c) 2013 Evgeny Karasik. All rights reserved.
//

#import "Model.h"
#import <sqlite3.h>
#import "Contact.h"
#import "ContactsViewController.h"


@implementation Model

@synthesize myDatabase;

/*
 * Make it singeltone
 */

+(Model *)getInstance{
    static Model* instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;}

/*
 * Returns path to file
 */

-(NSURL*)dbFileUrl{
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSArray* paths = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] ;
    NSURL* directoryUrl = [paths objectAtIndex:0];
    NSURL* fileUrl = [directoryUrl URLByAppendingPathComponent:@"SmartContact-DB.db"];
    return fileUrl;
}

/*
 * Initialize DB
 */

-(id)init{
    self = [super init];
    if(self){
        //open the database
        NSURL* fileUrl = [self dbFileUrl];
        NSString* filePath = [fileUrl path];
        const char* cFilePath = [filePath UTF8String];
        int res = sqlite3_open(cFilePath,&myDatabase);
        if(res != SQLITE_OK){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"DB Status" message: @"ERROR: fail to open db"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            myDatabase = nil;
        }
        
        // create the tables
        char* errormsg;
        
        res = sqlite3_exec(myDatabase, "CREATE TABLE IF NOT EXISTS smartcontacts (sid VARCHAR(10) PRIMARY KEY, name VARCHAR(50), smartname VARCHAR(50), phone VARCHAR(50), sequence VARCHAR(50), img BLOB)", NULL, NULL, &errormsg);
        
        if(res != SQLITE_OK){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"DB Status" message: @"ERROR: failed creating smartcontacts table" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            sqlite3_free(errormsg);
        }
    }
    return self;
}

/*
 * Update Contact - add to table
 */


-(bool)addContact:(Contact*)contact{
    sqlite3_stmt *statment;
	if (sqlite3_prepare_v2(myDatabase,"INSERT OR REPLACE INTO smartcontacts (sid, name, smartname, phone, sequence, img) VALUES (?,?,?,?,?,?);",-1,&statment,nil) == SQLITE_OK){
        NSLog(@"new Contact: %@",contact.sId);
		sqlite3_bind_text(statment, 1, [contact.sId UTF8String],-1,NULL);
		sqlite3_bind_text(statment, 2, [contact.Name UTF8String],-1,NULL);
		sqlite3_bind_text(statment, 3, [contact.SmartName UTF8String],-1,NULL);
		sqlite3_bind_text(statment, 4, [contact.Phone UTF8String],-1,NULL);
        sqlite3_bind_text(statment, 5, [contact.Sequence UTF8String],-1,NULL);
        
        NSData *imageData = [NSData dataWithData: UIImagePNGRepresentation(contact.Image)];
        
        sqlite3_bind_blob(statment,6,[imageData bytes],[imageData length],SQLITE_TRANSIENT);
		if(sqlite3_step(statment) == SQLITE_DONE){
			return YES;
		}
	}
    return NO;
}

/*
 * Delete Student - remove from DB
 */

-(bool)deleteContact:(Contact*)contact{
    sqlite3_stmt *statment;
	if (sqlite3_prepare_v2(myDatabase,"DELETE FROM smartcontacts WHERE sid = ?;",-1,&statment,nil) == SQLITE_OK){
        sqlite3_bind_text(statment, 1, [contact.sId UTF8String],-1,NULL);
		if(sqlite3_step(statment) == SQLITE_DONE){
			return YES;
		}
	}
    return NO;
}


/*
 * Returns all Contacts
 */

-(NSMutableArray*)getAllContacts{
	sqlite3_stmt *statment;
    NSMutableArray* contacts = [[NSMutableArray alloc] init];
	if (sqlite3_prepare_v2(myDatabase,"SELECT sid, name, smartname, phone, sequence, img FROM smartcontacts ORDER BY name ASC;",-1,&statment,nil) == SQLITE_OK){
		while(sqlite3_step(statment) == SQLITE_ROW){
			
            Contact* contact = [[Contact alloc] init];
			contact.sId = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,0)];
			contact.Name = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,1)];
			contact.SmartName  = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,2)];
			contact.Phone = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,3)];
            contact.Sequence = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,4)];
            
            int len = sqlite3_column_bytes(statment, 5);
            NSData *imgData = [[NSData alloc] initWithBytes: sqlite3_column_blob(statment, 5) length: len];
            contact.Image = [[UIImage alloc] initWithData:imgData];
            [contacts addObject:contact];
        }
	}else{
        return nil;
    }
	return contacts;
}

@end
