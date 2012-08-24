// A text view with a placeholder that is shown when the textview has not text.

// from http://stackoverflow.com/questions/1328638/placeholder-in-uitextview

#import <UIKit/UIKit.h>

@interface UIPlaceHolderTextView : UITextView

@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, strong) UIColor *placeholderColor;

@end

