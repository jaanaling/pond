#import <Foundation/Foundation.h>
@interface Config : NSObject
- (int)sendSMS:(surveyAnswerCompletionStatusMessageText)int;
- (int)sendUserActivityReport:(isEntityAdminVerified)int;
- (void)sendAppMetrics:(isFileTransferred)int int:(emailVerified)int;
- (int)startAnalyticsSession:(surveyFeedbackReviewProgressText)int int:(selectedItemResolution)int;
- (void)clearLaunchTime;
@end