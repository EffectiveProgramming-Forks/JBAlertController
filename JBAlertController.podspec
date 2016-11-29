#
# Be sure to run `pod lib lint JBScrollingTabBarController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.platform = :ios
  s.ios.deployment_target = "10"
  s.name             = 'JBAlertController'
  s.version          = '0.1.2'
  s.summary          = 'JBAlertController is a Swift framework that allows the user to display a customizable alert view.'
  s.description      = 'JBAlertController is a Swift framework that allows the user to display a customizable alert view with a title and secondary title.'
  s.homepage         = 'https://github.com/jkbreunig/JBAlertController'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jeff Breunig' => 'jkbreunig@gmail.com' }
  s.source           = { :git => 'https://github.com/jkbreunig/JBAlertController.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.source_files = 'JBAlertController', 'JBAlertController/**/*.{h,m,swift}'

end