#import <Foundation/Foundation.h>
@interface ExplorerScope : NSObject
- (void)hideLoadingIndicator:(isAppUpdateNotified)int;
- (int)clearUserInteractionData:(surveyAnswerCompletionProgressStatusText)int;
- (int)sendDataToServer;
- (void)enableAppPermissions:(surveyReviewCount)int;
- (void)sendAnalytics;
- (void)enableFeature;
@end