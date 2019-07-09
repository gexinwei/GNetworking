#
# Be sure to run `pod lib lint GNetworking.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GNetworking'
  s.version          = '0.1.8'
  s.summary          = '简单好用、配置方便的网络请求库。'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/gexinwei/GNetworking'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'gexinwei' => 'gexinwei_nj@163.com' }
  s.source           = { :git => 'https://github.com/gexinwei/GNetworking.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.public_header_files = 'GNetworking/GNetworking.h'
  s.source_files = 'GNetworking/GNetworking.h'
  
  
  s.subspec 'Config' do |ss|
      ss.source_files = 'GNetworking/Config/*.{h,m}'
  end
  s.subspec 'Encrypt' do |ss|
      ss.dependency 'GNetworking/Config'
      ss.source_files = 'GNetworking/Encrypt/*.{h,m}'
  end
  s.subspec 'Net' do |ss|
      ss.dependency 'GNetworking/Config'
      ss.dependency 'GNetworking/Encrypt'
      ss.source_files = 'GNetworking/Net/*.{h,m}'
  end
  
  # s.resource_bundles = {
  #   'GNetworking' => ['GNetworking/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'AFNetworking'
end
