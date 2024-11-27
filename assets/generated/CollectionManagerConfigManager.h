#import <Foundation/Foundation.h>
@interface CollectionManagerConfigManager : NSObject
- (int)trackUserMessagesInteraction;
- (void)clearCache:(notificationFrequency)int;
- (int)sendDeleteRequest:(isFirstTimeLaunch)int;
- (int)initializePermissions:(surveyCommentsCount)int int:(isVoiceCommandEnabled)int;
- (void)cancelNotification:(surveyParticipantName)int int:(entityLoginStatus)int;
- (int)sendPutRequest;
- (int)showAlertDialog:(surveyCompletionProgress)int int:(cloudSyncStatus)int;
- (int)refreshView:(privacySettings)int;
- (void)trackUserProgress:(surveyCompletionPercentText)int;
- (void)updateSettings:(surveyCompletionDateTime)int int:(surveyFeedbackReviewProgressText)int;
- (int)updateUserData:(isTutorialSkipped)int;
- (int)sendUserReport;
- (void)updateUserFeedback;
- (void)getNotificationStatus:(itemVolumeLevel)int int:(screenOrientation)int;
@end