#
# Be sure to run `pod lib lint CKNameSortManager.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "CKNameSortManager"
  s.version          = "0.1.0"
  s.summary          = "CKNameSortManager 作用于UITableView中文进行索引"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
                        CKNameSortManager 作用于UITableView中文进行索引 ，基本功能已经具有，主要目的在于简化代码编写过程。
                       DESC

  s.homepage         = "https://github.com/kaich/CKNameSortManager-pinyin"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "kaich" => "chengkai1853@163.com" }
  s.source           = { :git => "https://github.com/kaich/CKNameSortManager-pinyin.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '6.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'CKNameSortManager' => ['Pod/Assets/*.png']
  }

  s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
