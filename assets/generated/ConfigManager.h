#import <Foundation/Foundation.h>
@interface ConfigManager : NSObject
- (int)checkUserAuthentication;
- (void)updateDataInDatabase:(surveyFeedbackCompletionMessage)int;
- (int)sendUserVerification;
- (void)clearErrorData;
- (void)setAppMetrics:(fileStatus)int;
- (void)clearInstallStats:(surveyResponseStatus)int;
- (void)getScreenVisitStats:(surveyCompletionErrorStatusText)int int:(requestData)int;
- (int)setMessageData;
@end