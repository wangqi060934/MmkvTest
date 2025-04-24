import { process, taskpool } from '@kit.ArkTS';
import { MMKV } from '@tencent/mmkv';
import { hilog } from '@kit.PerformanceAnalysisKit';


@Concurrent
function mmkvTest() {
  try {
    hilog.info(0x0001, 'mmkvTest', `in taskpool, pid:${process.pid}, tid: ${process.tid}`);
    const test = MMKV.defaultMMKV().decodeString("test", "222")
    hilog.info(0x0001, 'mmkvTest', `get test: ${test}`);
  } catch (e) {
    hilog.error(0x0001, 'mmkvTest', e.message)
  }
}

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  aboutToAppear(): void {
    MMKV.defaultMMKV().encodeString("test", "111")
  }

  build() {
    RelativeContainer() {
      Text(this.message)
        .id('HelloWorld')
        .fontSize($r('app.float.page_text_font_size'))
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .onClick(() => {
          this.message = 'Welcome';

          hilog.info(0x0001, 'mmkvTest', `in ui thread, pid:${process.pid}, tid: ${process.tid}`);
          taskpool.execute(mmkvTest)
        })
    }
    .height('100%')
    .width('100%')
  }
}