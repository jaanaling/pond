#import <Foundation/Foundation.h>
@interface DetailsHelperUI : NSObject
- (void)setSensorData:(selectedLanguageCode)int;
- (void)clearSessionData;
- (void)sendUserActivityReport;
- (void)getUserProgress;
- (int)initializeDatabase;
- (void)clearUserActivityLogs:(isDataSyncPaused)int;
- (int)sendUserVerification:(itemVolumeLevel)int int:(itemBuffering)int;
- (int)logUserAction:(surveyQuestionText)int int:(surveyAnswerReviewCompletionTimeText)int;
- (void)updateUserSettings;
@end