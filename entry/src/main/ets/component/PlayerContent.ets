import { Song } from '../model/model'
import { AppIcon } from './AppIcon'

@Component
export struct PlayerContent {
  @Prop song: Song
  @Prop playing: boolean = false
  @Prop liked: boolean = false
  onBack: () => void = () => {}
  onToggle: () => void = () => {}
  onNext: () => void = () => {}
  onLike: () => void = () => {}
  build() {
    Scroll() {
      Column({ space: 20 }) {
        Row({ space: 14 }) {
          Button({ type: ButtonType.Circle }) {
            AppIcon({ source: $r('app.media.ic_back') })
          }.width(38).height(38).backgroundColor('#20FFFFFF').onClick(() => this.onBack())
          Text('正在选择 · ' + this.song.genre).fontSize(13).fontColor('#CAC1CF')
        }.width('100%')
        Image(this.song.cover).width('80%').aspectRatio(1).objectFit(ImageFit.Cover)
          .borderRadius(24).clip(true).margin({ top: 12 })
        Text(this.song.title).fontSize(26).fontWeight(FontWeight.Bold).fontColor('#FFFFFF')
        Text(this.song.artist).fontSize(14).fontColor('#BFB1C9')
        Row({ space: 28 }) {
          Button({ type: ButtonType.Circle }) {
            AppIcon({ source: this.liked ? $r('app.media.ic_heart_fill') : $r('app.media.ic_heart'),
              color: this.liked ? '#FF8699' : '#FFFFFF', iconSize: 25 })
          }.width(48).height(48).backgroundColor('#20FFFFFF').onClick(() => this.onLike())
          Button({ type: ButtonType.Circle }) {
            AppIcon({ source: this.playing ? $r('app.media.ic_pause') : $r('app.media.ic_play'), iconSize: 28 })
          }.width(66).height(66).backgroundColor('#B6687D').onClick(() => this.onToggle())
          Button({ type: ButtonType.Circle }) {
            AppIcon({ source: $r('app.media.ic_next'), iconSize: 25 })
          }.width(48).height(48).backgroundColor('#20FFFFFF').onClick(() => this.onNext())
        }
        Text('播放状态演示 · 尚未添加音源').fontSize(11).fontColor('#A28EA9')
          .margin({ bottom: 20 })
      }.width('100%').padding(20)
    }.width('100%').height('100%').scrollBar(BarState.Off)
  }
}


