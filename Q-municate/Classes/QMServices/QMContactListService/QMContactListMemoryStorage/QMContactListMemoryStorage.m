//
//  QMContactListMemoryStorage.m
//  QMServices
//
//  Created by Injoit on 25.11.14.
//  Copyright © 2015 QuickBlox. All rights reserved.
//

#import "QMContactListMemoryStorage.h"

@interface QMContactListMemoryStorage()

@property (strong, nonatomic) NSMutableDictionary *contactsMemoryStorage;

@end

@implementation QMContactListMemoryStorage

// MARK: Construction

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        _contactsMemoryStorage = [NSMutableDictionary dictionary];
    }
    
    return self;
}

// MARK: Public

- (void)updateWithContactList:(QBContactList *)contactList {
    
    [self.contactsMemoryStorage removeAllObjects];

    [contactList.contacts enumerateObjectsUsingBlock:^(QBContactListItem *contactListItem,
                                                       NSUInteger idx,
                                                       BOOL *stop) {
        
        self.contactsMemoryStorage[@(contactListItem.userID)] = contactListItem;
    }];
    
    [contactList.pendingApproval enumerateObjectsUsingBlock:^(QBContactListItem *contactListItem,
                                                              NSUInteger idx,
                                                              BOOL *stop) {
        
        self.contactsMemoryStorage[@(contactListItem.userID)] = contactListItem;
    }];
}

- (void)updateWithContactListItems:(NSArray *)contactListItems {
    
    [self.contactsMemoryStorage removeAllObjects];
    [contactListItems enumerateObjectsUsingBlock:^(QBContactListItem *contactListItem,
                                                   NSUInteger idx,
                                                   BOOL *stop) {
        
        self.contactsMemoryStorage[@(contactListItem.userID)] = contactListItem;
    }];
}

- (QBContactListItem *)contactListItemWithUserID:(NSUInteger)userID {
    
    return self.contactsMemoryStorage[@(userID)];
}

- (NSArray *)userIDsFromContactList {
    
    return self.contactsMemoryStorage.allKeys;
}

- (NSArray *)allContactListItems {
    
    return self.contactsMemoryStorage.allValues;
}

// MARK: QMMemoryStorageProtocol

- (BOOL)isEmpty {
    
    return self.contactsMemoryStorage.count == 0;
}

- (void)free {
    
    [self.contactsMemoryStorage removeAllObjects];
}

@end
