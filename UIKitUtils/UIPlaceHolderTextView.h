// A text view with a placeholder that is shown when the textview has not text.

// from http://stackoverflow.com/questions/1328638/placeholder-in-uitextview

@interface UIPlaceHolderTextView : UITextView

@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, retain) UIColor *placeholderColor;

@end

