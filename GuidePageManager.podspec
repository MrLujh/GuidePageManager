Pod::Spec.new do |s|
s.name        = 'GuidePageManager'
s.version     = '0.0.2'
s.authors     = { 'Mrlujh' => '287929070@qq.com' }
s.homepage    = 'https://github.com/MrLujh/GuidePageManager'
s.summary     = 'a dropdown menu for ios like wechat homepage.'
s.source      = { :git => 'https://github.com/MrLujh/GuidePageManager.git',
:tag => s.version.to_s }
s.license     = { :type => "MIT", :file => "LICENSE" }
s.platform = :ios, '9.0'
s.requires_arc = true
s.source_files = 'GuidePageManager/**/*.{h,m}'
s.ios.deployment_target = '8.0'
s.frameworks   =  'QuartzCore', 'Security', 'UIKit', 'Foundation', 'CoreGraphics','CoreTelephony'
end