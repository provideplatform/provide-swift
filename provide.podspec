#
# Be sure to run `pod lib lint provide.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'provide'
  s.version          = '0.1.0'
  s.summary          = 'Provide Swift client library'
  s.swift_version    = '4.2'

# Library for interacting with the Provide services from Swift.

  s.description      = <<-DESC
Provide Swift client library.
                       DESC

  s.homepage         = 'https://github.com/provideservices/provide-swift'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'kthomas' => 'kyle@provide.services', 'muncman' => 'kevin@provide.services' }
  s.source           = { :git => 'https://github.com/provideservices/provide-swift.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.3'

  s.source_files = 'provide/Classes/**/*.swift'
  
  # s.resource_bundles = {
  #   'provide' => ['provide/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Alamofire', '~> 4.0'
  s.dependency 'AlamofireObjectMapper', '~> 5.0'
  s.dependency 'ObjectMapper', '~> 3.0'
  s.dependency 'JWTDecode', '~> 2.0'
  s.dependency 'UICKeyChainStore', '~> 2.1'
end
