import { ConstantUI } from '../common/Constants';
import { RawFileManager } from '../common/RawFileManager';

@Entry
@Component
struct Index {
  @State file_length1: string = 'File 1';
  @State file_length2: string = 'File 2';
  @State file_length3: string = 'File 3';
  @State file_length4: string = 'File 4';
  @State txt_filename: string = "Empty"
  scroller: Scroller = new Scroller()
  rawFileManager: RawFileManager = RawFileManager.getInstance()

  build() {
    Scroll(this.scroller) {
      Column({ space: 10 }) {
        Blank().height(ConstantUI.PERCENT_5)

        Text(this.txt_filename).fontSize(18)

        Divider().height(ConstantUI.PERCENT_5)

        Button($r('app.string.button1'))
          .width(ConstantUI.PERCENT_48)
          .height(ConstantUI.PERCENT_20)
          .onClick(async () => {
            const returnedJson = await this.rawFileManager.readRawFileDeprecated('json1.json')
            this.file_length1 = `length is ${returnedJson.users.length}`
            this.txt_filename = this.file_length1
          })
        Button($r('app.string.button2'))
          .width(ConstantUI.PERCENT_48)
          .height(ConstantUI.PERCENT_20)
          .onClick(async () => {
            const returnedJson = await this.rawFileManager.readRawFile2('json2.json')
            this.file_length2 = `length is ${returnedJson.length}`
            this.txt_filename = this.file_length2
          })
        Button($r('app.string.button3'))
          .width(ConstantUI.PERCENT_48)
          .height(ConstantUI.PERCENT_20)
          .onClick(async () => {
            const returnedJson =
              await this.rawFileManager.readRawFile3('json3.json', this.getUIContext().getHostContext())
            this.file_length3 = `length is ${returnedJson.length}`
            this.txt_filename = this.file_length3
          })
        Button($r('app.string.button4'))
          .width(ConstantUI.PERCENT_48)
          .height(ConstantUI.PERCENT_20)
          .onClick(async () => {
            const returnedJson =
              await this.rawFileManager.readRawFile4('audio_file.mp3', this.getUIContext().getHostContext())
            this.file_length4 = `length is ${returnedJson?.length}`
            this.txt_filename = this.file_length4
          })
      }
      .width(ConstantUI.PERCENT_100)
    }
    .width(ConstantUI.PERCENT_100)
    .scrollable(ScrollDirection.Vertical)
    .scrollBar(BarState.Off)
    .scrollBarColor(Color.Gray)
    .scrollBarWidth(0)
  }
}