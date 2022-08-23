//
//  BaseViewController.m
//
//  Created by XQ on 2022/1/24.
//

#import "BaseViewController.h"
#import "RouterHeader.h"
#import "DebugHeader.h"

#import <Masonry/Masonry.h>

@interface BaseViewController ()

@property (nonatomic, strong) ViewControllerContext *context;
@property (nonatomic, strong) VIEW *rootContainer;
@property (nonatomic, strong) NSMutableArray<ViewModel *> *viewModels;

@end

@implementation BaseViewController

+ (void)initialize {
    NSString *scheme = [self scheme];
    if (!scheme || scheme.length <= 0) {
        return;
    }
    [[Router share] registerScheme:[self scheme] withClass:[self class]];
}

- (ViewControllerContext *)context {
    if (_context) return _context;
    _context = [ViewControllerContext new];
    return _context;
}

#pragma mark - ViewProtocol

+ (CGSize)viewSize {
    return CGSizeMake(800, 600);
}

- (void)addSubview:(VIEW *)view {
    [self.rootContainer addSubview:view];
}

- (VIEW *)rootContainer {
    if (_rootContainer) {
        return _rootContainer;
    }
    _rootContainer = [VIEW new];
    [self.view addSubview:_rootContainer];
#if TARGET_OS_IPHONE
    _rootContainer.backgroundColor = [COLOR clearColor];
    // 安全区域
    [_rootContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
        make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
    }];
#endif
    
#if TARGET_OS_OSX
    _rootContainer.layer.backgroundColor = [COLOR clearColor].CGColor;
    // 安全区域
    [_rootContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.view);
    }];
#endif
    return _rootContainer;
}

#pragma mark - RoutableProtocol

+ (NSString *)scheme {
    return @"";
}

#pragma mark - Life circle

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initProperties];
    }
    return self;
}

#if TARGET_OS_OSX
- (void)loadView {
    CGSize size = [[self class] viewSize];
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    self.view = [[VIEW alloc] initWithFrame:rect];
}
#endif

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LoggerInfo(@"[%@] -> %@", [self class], self.params);
#if TARGET_OS_IPHONE
    self.view.backgroundColor = [COLOR colorNamed:@"BackgroundColor"];
#endif
    [self initDefaultViews];
}

#if TARGET_OS_IPHONE
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    BOOL hideNavigationBar = self.hideNavigationBar;
    BOOL hideTabBar = self.hideTabBar;
    self.navigationController.navigationBar.hidden = hideNavigationBar;
    self.tabBarController.tabBar.hidden = hideTabBar;
    
    [self setupData];
    [self setupViews];
    [self loadData:^(BOOL success) {
        [self updateViews];
    }];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
#endif

#if TARGET_OS_OSX

- (void)viewWillAppear {
    [super viewWillAppear];
    [self setupData];
    [self setupViews];
    [self loadData:^(BOOL success) {
        [self updateViews];
    }];
}

- (void)viewWillLayout {
    [super viewWillLayout];
}

- (void)viewDidLayout {
    [super viewDidLayout];
}

- (void)viewDidAppear {
    [super viewDidAppear];
}

- (void)viewWillDisappear {
    [super viewWillDisappear];
}

- (void)viewDidDisappear {
    [super viewDidDisappear];
}

#endif

- (void)dealloc {
    LoggerInfo(@"[%@] -> %@", [self class], @"销毁");
}


#if TARGET_OS_IPHONE

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.statusBarStyle;
}

- (BOOL)prefersStatusBarHidden {
    return self.hideStatusBar;
}

#pragma mark - Origientation

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

#endif

#pragma mark - ViewModelProtocol

- (void)bindViewModel:(ViewModel *)viewModel {
    if (!viewModel) {
        return;
    }
    viewModel.delegate = self;
    [viewModel bind];
    [self.viewModels addObject:viewModel];
}

#pragma mark - private method

- (void)initProperties {
    self.viewControllerName = @"ViewControllerName";
    self.params = @{};
    
#if TARGET_OS_IPHONE
    self.hideStatusBar = NO;
    self.statusBarStyle = UIStatusBarStyleDefault;
    
    self.hideTabBar = NO;
    self.tabBarTitle = @"TabBarTitle";
    self.tabBarIcon = @"";
    
    self.navigationTitle = @"NavigationTitle";
    self.hideNavigationBar = YES;
#endif
    
}

- (NSArray<ViewModel *> *)viewModels {
    if (_viewModels) {
        return _viewModels;
    }
    _viewModels = [NSMutableArray array];
    return _viewModels;
}

#pragma mark - LogicProtocol

- (void)initDefaultViews {
    
}

- (void)setupData {
    
}

- (void)setupViews {
    
}

- (void)loadData:(void (^)(BOOL))callback {
    callback(YES);
}

- (void)updateViews {
    [self.view updateConstraints];
}

#if TARGET_OS_IPHONE

#pragma mark - Shake

/// 摇一摇弹出debug面板
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    [[DebugBubble share] show];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
}

#endif

@end
