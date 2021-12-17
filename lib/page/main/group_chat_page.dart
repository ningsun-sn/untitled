import 'dart:async';
import 'dart:io' as io;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';

import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled/entity/chat_bean.dart';
import 'package:untitled/utils/color_utils.dart';
import 'package:untitled/utils/toast_utils.dart';
import 'package:untitled/utils/widget_utils.dart';
class GroupChatPage extends StatefulWidget {
  @override
  GroupChatSate createState() => GroupChatSate();
}

class GroupChatSate extends State<GroupChatPage>
    with SingleTickerProviderStateMixin {
  bool _value = false;
  bool _hasStr = false;
  List<Widget> widgets = <Widget>[];
  var content = "";
  TextEditingController controller = TextEditingController();
  ScrollController _controller = ScrollController();
  bool _isRecord = false;
  late Animation animationTalk;
  late AnimationController animationController;
  int _directionLeft = 1;
  int _directionRight = 2;
  int _typeText = 1;
  int _typeAudio = 2;

  List<String> images = [
    "images/school_icon_voice1.png",
    "images/school_icon_voice2.png",
    "images/school_icon_voice3.png",
    "images/school_icon_voice4.png",
    "images/school_icon_voice5.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        resizeToAvoidBottomInset: false,
      appBar: AppBar(
//        leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.white,), onPressed: null),
        title: Constants.titleStyle("群聊"),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                //这种刷新有问题? widgets = new List.from(widgets)
//              child: ListView(children: widgets,semanticChildCount: widgets.length),
                child: ListView.builder(
                    controller: _controller,
                    itemBuilder: (BuildContext context, int position) {
                      return widgets[position];
                    },
                    itemCount: widgets.length),
              ),
              Container(
                color: Colors.white,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _value = !_value;
                          });
                        },
                        child: Align(
                          child: _value
                              ? Image.asset(
                                  'images/btn_voice.png',
                                  width: 33,
                                  height: 33,
                                )
                              : Image.asset(
                                  'images/map_btn_keyboard.png',
                                  width: 33,
                                  height: 33,
                                ),
                          alignment: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 5, bottom: 10, right: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              color: ColorUtils.grayDeepBackground,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: _value
                              ? GestureDetector(
                                  child: Container(
                                    height: 33,
                                    child: const Align(
                                      child: Text(
                                        "按住 说话",
                                        style: TextStyle(
                                          color: ColorUtils.grayText,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                  ),
                                  onLongPress: () async {
                                    print("_isRecord" + _isRecord.toString());
                                    setState(() {
                                      if (!_isRecord) {
//                                        recorder.initialized;
//                                        recorder.start();
//                                        var recording = recorder.current(channel: 0);
                                        _start();
                                        animationController.forward();
//                                        AudioRecorder.start();
                                        _isRecord = true;
                                      }
                                    });
                                  },
                                  onLongPressUp: () async {
//                                    animationController.reset();
//                                    animationController.stop();
                                    print("onLongPressUp");
                                    _stop();
//                                    var recording = await AudioRecorder.stop();
//                                    print("录音时长${recording.duration}");
//                                    var result = await recorder.stop();
//                                    print(result.path);
//                                    File file = widget.localFileSystem.file(result.path);
                                    setState(() {
                                      _isRecord = false;
                                      widgets.add(getRow("", _typeAudio, _directionRight));
                                      //这样是倒数第二个
                                      _controller.jumpTo(
                                          _controller.position.maxScrollExtent);
                                    });
                                  },
                                )
                              : TextField(
                                  controller: controller,
                                  style: const TextStyle(
                                      color: ColorUtils.blackText, fontSize: 14),
                                  minLines: 1,
                                  maxLines: 5,
                                  decoration: const InputDecoration(
                                      hintText: "请输入消息内容",
                                      border: InputBorder.none,
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10, 5, 0, 5)),
                                  onChanged: (String str) {
                                    content = str;
                                    setState(() {
                                      if (str.length > 0) {
                                        _hasStr = true;
                                      } else {
                                        _hasStr = false;
                                      }
                                    });
                                  },
                                ),
                        ),
                      ),
                    ),
                    _value
                        ? Container()
                        : _hasStr
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    right: 10, bottom: 10),
                                child: Container(
                                  width: 50,
                                  height: 33,
                                  child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        widgets.add(getRow(content, _typeText, _directionRight));
                                        controller.text = "";
                                        //这样是倒数第二个
                                        _controller.jumpTo(_controller
                                            .position.maxScrollExtent);
                                      });
                                    },
                                    child: const Text(
                                      "发送",
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
                            : Container()
                  ],
                ),
              ),
            ],
          ),
          Offstage(
              offstage: !_isRecord,
              child: Center(
                child: SizedBox(width: 150, height: 150,

                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
//                    color: Constants.grayDeepBackground,
                    child:
                  Container(
                    alignment: Alignment.center,
                    width: 150,
                    height: 170.0,
                    child: AnimatedBuilder(
                      animation: animationTalk,
                      builder: (_, child) {
                        return CircleAvatar(
                          radius: animationTalk.value * 30,
//                          backgroundColor: Color(0x306b6aba),
                          child: const Center(
                            child: Icon(Icons.keyboard_voice,
                                size: 30.0, color: Color(0xFF6b6aba)),
                          ),
                        );
                      },
                    ),),

//                    Column(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      children: <Widget>[
//                        Row(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: <Widget>[
//                            Icon(
//                              Icons.keyboard_voice,
//                              size: 30,
//                              color: Colors.white,
//                            ),
//                            FrameAnimationImage(
//                              images,
//                              width: 30,
//                              height: 30,
//                            ),
//                          ],
//                        ),
//                        Text("录音中……")
//                      ],
//                    ),
                  ),
                ),
              ),
    ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

// Get the state of the recorder
  var isRecording = false;
  double _dbLevel = 0.0;
  FlutterSoundRecorder recorderModule = FlutterSoundRecorder();
  FlutterSoundPlayer playerModule = FlutterSoundPlayer();
  // FlutterAudioRecorder _recorder;
  // Recording _current;
  // RecordingStatus _currentStatus = RecordingStatus.Unset;
  var _path = "";
  var _duration = 0.0;
  var _maxLength = 59.0;
  _init() async {
    try {
      recorderModule.openAudioSession(
          focus: AudioFocus.requestFocusTransient,
          category: SessionCategory.playAndRecord,
          mode: SessionMode.modeDefault,
          device: AudioDevice.speaker);
       _initializeExample(false);
      // if (await FlutterAudioRecorder.hasPermissions) {
        String customPath = '/flutter_audio_recorder_';
        io.Directory appDocDirectory;
//        io.Directory appDocDirectory = await getApplicationDocumentsDirectory();
        if (io.Platform.isIOS) {
          appDocDirectory = await getApplicationDocumentsDirectory();
        } else {
          appDocDirectory = (await getExternalStorageDirectory())!;
        }

        // can add extension like ".mp4" ".wav" ".m4a" ".aac"
        customPath = appDocDirectory.path +
            customPath +
            DateTime.now().millisecondsSinceEpoch.toString();
        // _recorder = FlutterAudioRecorder(customPath, audioFormat: AudioFormat.AAC);
        // await _recorder.initialized;
        // after initialization
        // var current = await _recorder.current(channel: 0);
        // print(current);
        // should be "Initialized", if all working fine
        setState(() {
          // _current = current;
          // _currentStatus = current.status;
          // print(_currentStatus);
        });
      // } else {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //       new SnackBar(content: new Text("You must accept permissions")));
      // }
    } catch (e) {
      print(e);
    }
  }
  _start() async {
    try {
      // await _recorder.start();
      // var recording = await _recorder.current(channel: 0);
      // setState(() {
      //   _current = recording;
      // });
      //
      // const tick = const Duration(milliseconds: 50);
      // new Timer.periodic(tick, (Timer t) async {
      //   if (_currentStatus == RecordingStatus.Stopped) {
      //     t.cancel();
      //   }
      //
      //   var current = await _recorder.current(channel: 0);
      //    print(current.duration);
      //
      //   setState(() {
      //     _current = current;
      //     _currentStatus = _current.status;
      //     animationController.duration = current.duration;
      //   });
      // });
    } catch (e) {
      print(e);
    }
  }
  _stop() async {
    // var result = await _recorder.stop();
    // print("Stop recording: ${result.path}");
    // print("Stop recording: ${result.duration}");
//    File file = widget.localFileSystem.file(result.path);
//    print("File length: ${await file.length()}");
    setState(() {
      // _current = result;
      // _currentStatus = _current.status;
    });
  }
//  void onPlayAudio() async {
//    AudioPlayer audioPlayer = AudioPlayer();
//    await audioPlayer.play(_current.path, isLocal: true);
//  }
  @override
  Future<void> initState()  async {
    super.initState();
    animationController = AnimationController(
        duration:  const Duration(seconds: 1), vsync: this);
    animationTalk =
        Tween(begin: 1.0, end: 2.0).animate(animationController);
    animationController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        animationController.forward(from: 0.0);
      }
    });

    for (int i = 0; i < 3; i++) {
      widgets.add(getRow(i.toString(),_typeText, _directionLeft));
    }
    _init();
  }
  void initAudio() async {
    // bool hasPermission = await FlutterAudioRecorder.hasPermissions;
    // print("权限"+hasPermission.toString());

//    new Timer.periodic(new Duration(seconds: 1), (Timer t) async {
//      var current = await recorder.current(channel: 0);
//      //
//      setState(() {
//        print(current.status.toString() + "----"+ current.metering.toString());
//
//      });
//    });
  }

  Widget getRow(String text, int type, int direction) {
    ChatBean chatBean = ChatBean();
    chatBean.direction = direction;
    chatBean.text = text;
    chatBean.type = type;
    if(direction == _directionRight) {
      return  Container(child:Wrap(children: <Widget>[getItem(chatBean.type, chatBean.text,_directionRight)]),alignment: Alignment.centerRight,);
    } else {
      return
        Padding(
            padding: const EdgeInsets.only(right:50,top: 10,left: 15),
            child: Container(child:Wrap(children: <Widget>[getItem(chatBean.type, chatBean.text,_directionLeft)]),alignment: Alignment.centerLeft,));
    }
  }
  Widget getItem(type,text,direction){
    if (type == _typeText) {
      return Card(shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)), color:  (direction == _directionRight)? Colors.green: Colors.grey,
          child: Padding(padding: const EdgeInsets.all(10),
              child: Text(text)
          ));

    } else {
      return  GestureDetector(child:Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                    color: Colors.green,
          child: Icon(Icons.record_voice_over,color: Colors.white,)),  onTap: () {},);
    }
  }

  Future<void> _initializeExample(bool withUI) async{
    await playerModule.closeAudioSession();
    await playerModule.openAudioSession(
      focus: AudioFocus.requestFocusTransient,
      category: SessionCategory.playAndRecord,
      mode: SessionMode.modeDefault,
      device: AudioDevice.speaker,
    );
    await playerModule.setSubscriptionDuration(const Duration(milliseconds: 30));
    await recorderModule.setSubscriptionDuration(const Duration(milliseconds: 30));
    initializeDateFormatting();
  }
  /// 开始录音
  _startRecorder() async {
    try {
      bool microphoneStatus = await Permission.microphone.status.isGranted;
      bool storageStatus = await Permission.storage.status.isGranted;

      if(microphoneStatus && storageStatus) {

      } else {
        Map<Permission, PermissionStatus> map = await[Permission.microphone, Permission.storage].request();
        map.forEach((key, value) {
          if(!value.isGranted){
            if(key == Permission.microphone){
              ToastUtils.show("未获取到麦克风权限");
            } else {
              ToastUtils.show("未获取到存储权限");
            }
          }
        });
      }
      print('===>  获取了权限');

      io.Directory tempDir = await getTemporaryDirectory();
      var time = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      String path =
          '${tempDir.path}/${recorderModule.slotNo}-$time${ext[Codec.aacADTS.index]}';
      print('===>  准备开始录音');
      await recorderModule.startRecorder(
        toFile: path,
        codec: Codec.aacADTS,
        bitRate: 8000,
        sampleRate: 8000,
      );
      print('===>  开始录音');

      /// 监听录音
      _recorderSubscription = recorderModule.onProgress.listen((e) {
        if (e != null && e.duration != null) {
          DateTime date = new DateTime.fromMillisecondsSinceEpoch(
              e.duration.inMilliseconds,
              isUtc: true);
          String txt = DateFormat('mm:ss:SS', 'en_GB').format(date);
          if (date.second >= _maxLength) {
            _stopRecorder();
          }
          setState(() {
            _recorderTxt = txt.substring(0, 8);
            _dbLevel = e.decibels;
            print("当前振幅：$_dbLevel");
          });
        }
      });
      this.setState(() {
        _state = RecordPlayState.recording;
        _path = path;
        print("path == $path");
      });
    } catch (err) {
      setState(() {
        _stopRecorder();
        _state = RecordPlayState.record;
        _cancelRecorderSubscriptions();
      });
    }
  }

  /// 结束录音
  _stopRecorder() async {
    try {
      await recorderModule.stopRecorder();
      print('stopRecorder');
      _cancelRecorderSubscriptions();
      _getDuration();
    } catch (err) {
      print('stopRecorder error: $err');
    }
    setState(() {
      _dbLevel = 0.0;
      _state = RecordPlayState.play;
    });
  }

  /// 取消录音监听
  void _cancelRecorderSubscriptions() {
    if (_recorderSubscription != null) {
      _recorderSubscription.cancel();
      _recorderSubscription = null;
    }
  }

  /// 取消播放监听
  void _cancelPlayerSubscriptions() {
    if (_playerSubscription != null) {
      _playerSubscription.cancel();
      _playerSubscription = null;
    }
  }

  /// 释放录音和播放
  Future<void> _releaseFlauto() async {
    try {
      await playerModule.closeAudioSession();
      await recorderModule.closeAudioSession();
    } catch (e) {
      print('Released unsuccessful');
      print(e);
    }
  }
}




