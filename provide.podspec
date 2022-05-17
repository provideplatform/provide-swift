# Copyright 2017-2022 Provide Technologies Inc.
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#
# Be sure to run `pod lib lint Provide.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'provide'
  s.version          = '0.6.0'
  s.summary          = 'Provide Swift client library'
  s.swift_version    = '4.2'

  s.description      = <<-DESC
Provide Swift client library.
                       DESC

  s.homepage         = 'https://github.com/provideservices/provide-swift'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'kthomas' => 'kyle@provide.services', 'muncman' => 'kevin@provide.services' }
  s.source           = { :git => 'https://github.com/provideservices/provide-swift.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.3'

  s.source_files = 'Sources/**/*.swift'

  s.dependency 'Alamofire', '~> 4.0'
  s.dependency 'AlamofireObjectMapper', '~> 5.0'
  s.dependency 'ObjectMapper', '~> 3.0'
  s.dependency 'JWTDecode', '~> 2.0'
  s.dependency 'UICKeyChainStore', '~> 2.1'
end
