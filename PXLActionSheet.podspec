Pod::Spec.new do |spec|
  spec.name = 'PXLActionSheet'
  spec.version  = '1.0.2'
  spec.summary  = 'A new customizable replacement for UIActionSheet.'
  spec.homepage = 'https://github.com/jasonsilberman/pxlactionsheet'
  spec.author = { 'Jason Silberman' => 'j@j99.co' }
  spec.source = { :git => 'https://github.com/jasonsilberman/pxlactionsheet.git', :tag => "v#{spec.version}" }
  spec.requires_arc = true
  spec.license  = { :type => 'MIT', :file => 'LICENSE' }
  spec.frameworks = 'Foundation', 'UIKit'

  spec.platform = :ios, '7.0'
  spec.ios.deployment_target  = '7.0'

  spec.source_files = 'PXLActionSheet/*.{h,m}'
end
