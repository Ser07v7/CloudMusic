import { AppIcon } from './AppIcon'

@Component
export struct ProfileContent {
  @Link nickname: string
  @Link wallpaper: boolean
  @Link backgroundLevel: number
  @Prop likedCount: number = 0
  @Prop recentCount: number = 0
  @State editing: boolean = false
  @State draft: string = ''
  @State signature: string = '在自己的节奏里，慢慢发光。'
  onLibrary: () => void = () => {}

  @Styles
  panel() {
    .width('100%')
    .padding(18)
    .backgroundColor('#24FFFFFF')
    .borderRadius(20)
  }

  build() {
    Scroll() {
      Column({ space: 20 }) {
        Text('我的音乐空间').fontSize(25).fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF').width('100%')
        Column({ space: 14 }) {
          Stack() {
            AppIcon({ source: $r('app.media.ic_user'), iconSize: 35, color: '#FFF0D9' })
          }.width(76).height(76).backgroundColor('#695540').borderRadius(38)
          Text(this.nickname).fontSize(23).fontWeight(FontWeight.Bold).fontColor('#FFFFFF')
          Text(this.signature).fontSize(12).fontColor('#C8C0B8')
          Button('编辑昵称').fontSize(11).height(30).backgroundColor('#32FFFFFF')
            .onClick(() => { this.draft = this.nickname; this.editing = !this.editing })
          if (this.editing) {
            Row({ space: 8 }) {
              TextInput({ text: this.draft, placeholder: '你的昵称' }).layoutWeight(1)
                .height(38).fontColor('#FFFFFF').backgroundColor('#25FFFFFF').maxLength(16)
                .onChange((value: string) => { this.draft = value })
              Button('保存').fontSize(12).height(38).backgroundColor('#9F7563')
                .onClick(() => {
                  if (this.draft.trim().length > 0) { this.nickname = this.draft.trim(); this.editing = false }
                })
            }
          }
          Row() {
            Column({ space: 4 }) {
              Text(this.likedCount.toString()).fontSize(23).fontColor('#FFFFFF')
              Text('喜欢').fontSize(11).fontColor('#D3C5BD')
            }.layoutWeight(1)
            Column({ space: 4 }) {
              Text(this.recentCount.toString()).fontSize(23).fontColor('#FFFFFF')
              Text('最近选择').fontSize(11).fontColor('#D3C5BD')
            }.layoutWeight(1)
          }.width('100%').onClick(() => this.onLibrary())
        }.panel()
        Column({ space: 18 }) {
          Text('让空间更像你').fontSize(17).fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF').width('100%')
          Row() {
            Column({ space: 5 }) {
              Text('艺术家背景').fontSize(14).fontColor('#FFFFFF')
              Text('使用 Backdrop 壁纸').fontSize(11).fontColor('#B8ACA9')
            }.alignItems(HorizontalAlign.Start).layoutWeight(1)
            Toggle({ type: ToggleType.Switch, isOn: this.wallpaper })
              .selectedColor('#BC8D7F').onChange((value: boolean) => { this.wallpaper = value })
          }.width('100%')
          Row() {
            Text('背景明暗').fontSize(13).fontColor('#D4C7C4').layoutWeight(1)
            Text(Math.round(this.backgroundLevel) + '%').fontSize(12).fontColor('#BAAAA7')
          }.width('100%')
          Slider({ value: this.backgroundLevel, min: 15, max: 55, step: 1 })
            .selectedColor('#E0A995').trackColor('#35FFFFFF')
            .onChange((value: number) => { this.backgroundLevel = value })
        }.panel()
        Text('CLOUD MUSIC / 你的音乐，你的节奏').fontSize(10)
          .fontColor('#958680').margin({ bottom: 24 })
      }.padding(20).width('100%')
    }.width('100%').height('100%').scrollBar(BarState.Off)
  }
}


