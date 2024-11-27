#import <Foundation/Foundation.h>
@interface ConfirmDialogUpdater : NSObject
- (void)sendUpdateData;
- (void)sendUserVisitStats:(appInMemoryUsage)int;
- (int)sendSystemErrorReport:(surveyFeedbackSubmissionTime)int;
- (int)loadAppState:(uploadError)int int:(notificationFrequency)int;
- (void)fetchAppVersion:(menuItems)int int:(taskType)int;
- (void)updateInitialData:(entityConsentStatus)int int:(appLanguage)int;
- (void)clearNotificationData;
- (void)hideErrorMessage:(surveyAnswerCompletionProgressTime)int;
- (int)sendAppMetrics:(favoriteItems)int;
- (void)sendUpdateRequest:(surveyStatusMessageText)int;
- (int)logMessageNotification:(surveyCompletionReviewMessageTimeText)int int:(surveyQuestionText)int;
- (void)sendUserInteractionData;
- (void)hideAlertDialog:(themePreference)int;
@end