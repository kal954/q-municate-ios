//
//  QMChatGroupService.h
//  Qmunicate
//
//  Created by Andrey Ivanov on 02.07.14.
//  Copyright (c) 2014 Quickblox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QMBaseService.h"

@interface QMChatDialogsService : QMBaseService

- (void)fetchAllDialogs:(QBDialogsPagedResponseBlock)completion;
- (void)fetchDialogsWithLastActivityFromDate:(NSDate *)date completion:(QBDialogsPagedResponseBlock)completionBlock;
- (void)fetchDialogWithID:(NSString *)dialogID completion:(void (^)(QBChatDialog *dialog))block;
- (void)fetchDialogsWithIDs:(NSArray *)dialogIDs completion:(QBDialogsPagedResponseBlock)completion;

- (void)createChatDialog:(QBChatDialog *)chatDialog completion:(QBChatDialogResponseBlock)completion;

- (void)createPrivateChatDialogIfNeededWithOpponent:(QBUUser *)opponent completion:(void(^)(QBChatDialog *chatDialog))completion;
- (void)createPrivateDialogIfNeededWithNotification:(QBChatMessage *)notification completion:(void(^)(QBChatDialog *chatDialog))completion;
- (void)createGroupChatDialog:(QBChatDialog *)chatDialog completion:(void(^)(QBChatDialog *chatDialog))block;

- (void)updateChatDialog:(QBChatDialog *)dialog completion:(QBChatDialogResponseBlock)completion;

- (void)updateOrCreateDialogWithMessage:(QBChatMessage *)message isMine:(BOOL)isMine;

- (NSArray *)dialogHistory;
- (void)addDialogToHistory:(QBChatDialog *)chatDialog;
- (void)addDialogs:(NSArray *)dialogs;

- (QBChatDialog *)privateDialogWithOpponentID:(NSUInteger)opponentID;
- (QBChatDialog *)chatDialogWithID:(NSString *)dialogID;

- (void)deleteLocalDialog:(QBChatDialog *)dialog;
- (void)deleteChatDialog:(QBChatDialog *)dialog completion:(void(^)(BOOL success))completionHanlder;

- (void)leaveFromRooms;
- (void)joinRooms;

@end
