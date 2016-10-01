# Uncomment this line to define a global platform for your project
platform :ios, ‘9.0’
# Uncomment this line if you're using Swift
# Podfile
use_frameworks!

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
      config.build_settings['MACOSX_DEPLOYMENT_TARGET'] = '10.10'
    end
  end
end


target 'BrowserApp' do
pod 'Spring', :git => 'https://github.com/MengTo/Spring.git', :branch => 'swift3'
pod 'DZNEmptyDataSet'		#データがなにもないときに表示するページ
pod 'RealmSwift'	#real(DB)のswiftライブラリ
#pod "AsyncKit"		複数の非同期処理をする	RxSwiftを使用するので不要
pod “BWWalkthrough”	#ウォークスルー
pod 'NVActivityIndicatorView'		#ロードアイコン
pod 'SnapKit', '~> 3.0.1’		#オートレイアウトを簡単にswiftで記述できる
pod 'PermissionScope'		#許可聞くアラート
pod "KCFloatingActionButton", "~> 2.1.0"		#タッチしたら上に出るメニュー
pod "PocketAPI"			#PocketのAPI
pod "Evernote-SDK-iOS"		#EverNoteのAPI
pod "LINEActivity", "~> 0.2.0"		#UIActivity(共有メニュー)にLINEで送るを追加

pod 'RxSwift',    '~> 3.0.0-beta.1'
pod 'RxCocoa',    '~> 3.0.0-beta.1'
pod "RxRealm"		#Realm for RxSwift
#pod 'RxWebKit'		#WKWebView for RxSwift
#pod "RxSegue"		#Segue for Rxswift

end

target 'BrowserAppTests' do
pod 'RxBlocking', '~> 3.0.0-beta.1'
pod 'RxTests',    '~> 3.0.0-beta.1'

end

target 'BrowserAppUITests' do

end
