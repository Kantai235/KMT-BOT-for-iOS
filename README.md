# KMN BOT for iOS 的一些筆記跟教學

### 這是用 Cocoapods 管理第三方套件的教學：

根據官方是說打開終端機，然後 sudo gem install cocoapods 就沒事了 ...<br />
但是天底下哪有那麼好的事情啊！如果那麼簡單，網路上就不會哀鴻遍野了～～～<br />

一，如果您的 OSX 版本為 10.10 以上，請不要使用下面這項指令：<br />

```sh
sudo gem install cocoapods
```

請改服用：

```sh
sudo gem install -n /usr/local/bin cocoapods
```

二，在 pod install 的時候，他會跑出 setting up cocoapods master repo<br />
    這項訊息，接下來終端機完全都沒有任何回應，這不代表系統掛了！<br />
    而是天殺的正在下載以及更新 cocoapods ＝＝<br />
    請您等待他十幾分鐘，因為檔案真的很大 ... 我下載完後是 1.2G 的容量大小<br />
    請注意喔！這段時間內，終端機都不會有任何反應。<br />

PS: 不過倒是有另外一種方法可以判斷妳的 pod 是否死掉，<br />
就是請再開一個終端機畫面，然後請輸入下面的那些指令<br />
這目的是用來檢查下載進度，如果檔案好像都沒有再增加的話，那你可以考慮重新安裝 Cocoapods 了。

```sh
cd ~/.cocoapods
du -sh *
```

三，請善用 pod init，使用方法為在終端機 cd 到您的專案目錄底下執行這項指令，<br />
他可以幫你快速建構 Podfile 檔案，並將基礎語法設定好，然後就可以看表演了。<br />

PS:三補充：pod init 預設會將 platform 給註解掉，你必須記得 un# 掉<br />

```sh
#platform :ios, ‘8.0’<br />
```

建構完 Podfile 檔案後，打開來大致內容如下：<br />

```sh
# Uncomment the next line to define a global platform for your project
#platform :ios, '8.0'
target '專案名稱' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  # Pods for 專案名稱
end
```

我們必須把 platform 給開啟，並開始引入自己需要的第三方套件：

```sh
# Uncomment the next line to define a global platform for your project
platform :ios, '8.0'

target '專案名稱' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for 專案名稱
  pod 'OAuthSwift', '~> 0.5.0'

end
```

之後在終端機當中啟用 pod install 指令，讓 pod 幫忙下載第三方套件，並引入。

```sh
pod install
```

等程式跑好之後，專案會多出一個 專案名稱.xcworkspace，<br />
以往是用 專案名稱.xcodeproj 來啟動專案，<br />
但以後請利用 xcworkspace 來啟動專案，但以後請利用這個來啟動。<br />
<br />
啟動後請記得參考自己引入的第三方套件(ex: OAuthSwift.frameworks)<br />
要引用時也記得 inport 需要的套件。例如：<br />

```Swift
inport OAuthSwift
```
完。

### OAuthSwift 簡單應用
待補

### 其他東西的教學
待補