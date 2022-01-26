#
# Be sure to run `pod lib lint SSWebView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SSWebView'
  s.version          = '0.1.0'
  s.summary          = 'A short description of SSWebView.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/n893138245/SSWebView' #https://github.com/高光辉/SSWebView $
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '聂秀盛' => '893138245@163.com' }
  # s.author           = { '高光辉' => 'gaoguanghui@sansi.com' }
  s.source           = { :git => 'https://github.com/n893138245/SSWebView.git', :tag => s.version.to_s }
  # s.source           = { :git => 'https://github.com/高光辉/SSWebView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'SSWebView/Classes/**/*'
  
   s.resource_bundles = {
     'SSWebView' => ['SSWebView/Assets/*.{xib,png}']
   }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'SnapKit' #尝试引入第三方依赖库
  s.dependency 'pop' #UVAlertView依赖库
end
