#import <Foundation/Foundation.h>
@interface SchedulerPipeline : NSObject
- (int)getAppState:(reminderStatus)int int:(uiElements)int;
- (void)resetAppReport;
- (int)getUserErrorData;
- (void)getPushNotificationLogs:(itemPlaybackPosition)int;
- (int)clearApiResponse;
- (void)sendScreenViewData:(appUsageFrequency)int int:(mediaPlayerState)int;
- (int)updateProgressReport;
- (int)startDataSync;
- (void)getUserSessionDetails;
- (int)trackMessageEvents:(appFeatureEnabled)int;
- (void)setDeviceOrientation:(mediaControl)int int:(surveyCompletionStatus)int;
- (void)sendGetRequest;
- (void)getAppInfo:(surveyAnswerCompletionReviewStatus)int int:(isGpsEnabled)int;
- (void)clearLocation;
- (int)enableLocationServices:(contentType)int int:(surveyFeedbackReviewTime)int;
- (void)trackAppProgress;
@end