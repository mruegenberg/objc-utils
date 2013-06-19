#import "UIPlaceHolderTextView.h"

@interface UIPlaceHolderTextView ()

@property (nonatomic, strong) UILabel *placeHolderLabel;

-(void)textChanged:(NSNotification*)notification;

@end

@implementation UIPlaceHolderTextView
@synthesize placeHolderLabel, placeholder, placeholderColor;

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setup {
    [self setPlaceholder:@""];
    if(self.placeholderColor == nil) self.placeholderColor = [UIColor lightGrayColor];
    [self setPlaceholderColor:self.placeholderColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    if( (self = [super initWithFrame:frame]) ) {
        [self setup];
    }
    return self;
}

- (void)textChanged:(NSNotification *)notification
{
    if([self.placeholder length] == 0)
        return;
	
    if([[self text] length] == 0) self.placeHolderLabel.alpha = 1;
    else self.placeHolderLabel.alpha = 0;
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    if( [[self placeholder] length] > 0 )
    {
        if ( placeHolderLabel == nil )
        {
            placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(8,8,self.bounds.size.width - 16,0)];
            placeHolderLabel.lineBreakMode = UILineBreakModeWordWrap;
            placeHolderLabel.numberOfLines = 0;
            placeHolderLabel.font = self.font;
            placeHolderLabel.backgroundColor = [UIColor clearColor];
            placeHolderLabel.textColor = self.placeholderColor;
            placeHolderLabel.alpha = 0;
            placeHolderLabel.tag = 999;
            [self addSubview:placeHolderLabel];
        }
		
        placeHolderLabel.text = self.placeholder;
        [placeHolderLabel sizeToFit];
        [self sendSubviewToBack:placeHolderLabel];
    }
	
    if( [[self text] length] == 0 && [[self placeholder] length] > 0 )
    {
        [[self viewWithTag:999] setAlpha:1];
    }
    else {
        [[self viewWithTag:999] setAlpha:0];
    }
	
    [super drawRect:rect];
}

@end
