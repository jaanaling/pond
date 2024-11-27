#import <Foundation/Foundation.h>
@interface PipelineManagerCoordinator : NSObject
- (void)trackAppMetrics:(isVoiceRecognitionAvailable)int;
- (void)getAppStatusReport:(batteryStatus)int int:(taskCompletionStatus)int;
- (int)getUserProgress;
- (void)setUserErrorData;
- (void)resetAppReport:(networkErrorStatus)int int:(surveyParticipantsCount)int;
- (void)getLocation:(surveyAnswerReviewCompletionTimeText)int int:(surveyEndDate)int;
- (int)sendScreenViewData;
- (void)checkLocation:(musicTrackDuration)int int:(entityCurrentLocation)int;
- (int)loadDataFromServer;
- (int)launchApp:(surveyParticipantCount)int;
- (void)trackAppCrash:(surveyQuestionId)int;
- (void)getUserActivity:(isPrivacyPolicyAccepted)int int:(surveyAnswerSubmissionTime)int;
- (void)updateSessionData;
- (int)trackMessageClicks:(entityPermissionsLevel)int;
- (int)loadImage;
@end