import 'package:flutter/material.dart';
import 'package:ali_auth/ali_auth.dart';
import 'dart:io';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

/// 获取token成功
const PNSCodeSuccess = "600000";

/// 点击切换按钮，⽤户取消免密登录
const NSCodeLoginControllerClickChangeBtn = "700001";

/// 唤起授权页失败
const PNSCodeFail = "600002";

class _MyAppState extends State<MyApp> {
  BuildContext mContext;

  @override
  void initState() {
    super.initState();
    // 初始化插件
    if (Platform.isAndroid) {
      AliAuthPlugin.initSdk(
          'GZ5k7qMv4HioOw3jLpFmnzC+CXuZCPJJFTfbNrgE6WFi0oFSoEe3QofR7en1dhpKruYGWPqL7kDuSksaYL6MhYRtQYlD6gnAPmwKy11Q4FzS/MuOen9Pv9vmJNYED7I2EZXTHHFklbD8KVRFXjxYNTDWnKBZFVYaa36BmM5A3t17yNBa5kZSdCTl+w+np4fSLnB7p2VT9ZPlgitON9XRaTz/aCTBi508SBvCS88MnoxT5pOWMElyrGulsaRpHCMuzLX+LlKkmCBSdvZcArYt+9BinwnE+gxkvzzWvzGwiOK/HGDevROJ9kunPp0WfJzk');
    } else {
      AliAuthPlugin.initSdk(
          'WP0wOo/XxQLBvUKk20ODR7dPQGADL3C8UqWwY18yVeqf+6DAQ9EzNJZlObAqKBCqT2jg0CbPDVjXAzPTKP5ic6v5V1UonmuVTCh5MvqIakJrcRJVwZfvyoqE/7WyTk++XEhNd7GT/Mn80NtrkUskBWaIaCk5ktfQOFPb1zLlLabTyznQLxbUUfdkVBBwPInrbSBZFwKCJyZ5ry4139bsXeTY6IR/41uZ8kW7jTNFJv0BIIfNmWKTRXUGvEuQJhIScqzf80VrVrax4SCxaW2jgg==');
    }
  }

  /// login 跳转到账号密码登录页
  void _doLogin() {}

  void _quickLogin() async {
    bool checkVerifyEnable = true;

    // try {
    //   checkVerifyEnable = await AliAuthPlugin.checkVerifyEnable;
    // } catch (e) {
    //   print('sdk error $e');
    // }

    // if (!checkVerifyEnable) {
    //   _doLogin();
    //   return;
    // }

    if (checkVerifyEnable) {
      Map _result;

      try {
        _result = await AliAuthPlugin.login;
      } catch (e) {
        print('sdk error $e');
      }

      if (_result == null || _result['returnCode'] == PNSCodeFail) {
        _doLogin();
        return;
      }

      if (_result['returnCode'] == PNSCodeSuccess) {
        String _accessToken = _result['returnData'];

        /// 获取调token后走快速登录的的逻辑
      } else if (_result['returnCode'] == NSCodeLoginControllerClickChangeBtn) {
        /// 点击其他登录
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    mContext = context;
    return Scaffold(
      appBar: AppBar(
        title: const Text('阿里云一键登录'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () async {
            _quickLogin();
          },
          child: Text('登录'),
        ),
      ),
    );
  }
}
