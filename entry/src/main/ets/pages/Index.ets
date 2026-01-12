import { ConstantUI } from '../common/Constants';
import { RawFileManager } from '../common/RawFileManager';

@Entry
@Component
struct Index {
  @State fileLength1: string = 'File 1';
  @State fileLength2: string = 'File 2';
  @State fileLength3: string = 'File 3';
  @State fileLength4: string = 'File 4';
  @State txtFilename: string = 'Empty'
  scroller: Scroller = new Scroller()
  rawFileManager: RawFileManager = RawFileManager.getInstance(this.getUIContext().getHostContext())

  build() {
    Scroll(this.scroller) {
      Column({ space: 10 }) {
        Blank().height(ConstantUI.PERCENT_5)

        Text(this.txtFilename).fontSize(18)

        Divider().height(ConstantUI.PERCENT_5)

        Button($r('app.string.button1'))
          .width(ConstantUI.PERCENT_48)
          .height(ConstantUI.PERCENT_20)
          .onClick(async () => {
            const returnedJson = await this.rawFileManager.readRawFileDeprecated('json1.json')
            if (returnedJson) {
              this.fileLength1 = `length is ${returnedJson.users.length}`
              this.txtFilename = this.fileLength1
            }
          })
        Button($r('app.string.button2'))
          .width(ConstantUI.PERCENT_48)
          .height(ConstantUI.PERCENT_20)
          .onClick(async () => {
            const returnedJson = await this.rawFileManager.readRawFile2('json2.json')
            this.fileLength2 = `length is ${returnedJson.length}`
            this.txtFilename = this.fileLength2
          })
        Button($r('app.string.button3'))
          .width(ConstantUI.PERCENT_48)
          .height(ConstantUI.PERCENT_20)
          .onClick(async () => {
            const returnedJson =
              await this.rawFileManager.readRawFile3('json3.json', this.getUIContext().getHostContext())
            this.fileLength3 = `length is ${returnedJson.length}`
            this.txtFilename = this.fileLength3
          })
        Button($r('app.string.button4'))
          .width(ConstantUI.PERCENT_48)
          .height(ConstantUI.PERCENT_20)
          .onClick(async () => {
            const returnedJson =
              await this.rawFileManager.readRawFile4('audio_file.mp3', this.getUIContext().getHostContext())
            this.fileLength4 = `length is ${returnedJson?.length}`
            this.txtFilename = this.fileLength4
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