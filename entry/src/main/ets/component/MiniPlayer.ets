import { Song } from '../model/model'
import { AppIcon } from './AppIcon'

@Component
export struct MiniPlayer {
  @Prop song: Song
  @Prop playing: boolean = false
  onToggle: () => void = () => {}
  onNext: () => void = () => {}
  onOpen: () => void = () => {}

  build() {
    Row({ space: 11 }) {
      Stack() {
        Image(this.song.cover).width(42).height(42).objectFit(ImageFit.Cover)
          .borderRadius(21).clip(true)
        Circle().width(7).height(7).fill('#202027')
      }.width(48).height(48).backgroundColor('#232229').borderRadius(24)
        .onClick(() => this.onOpen())
      Column({ space: 3 }) {
        Text(this.song.title).fontSize(13).fontColor('#FFFFFF').maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
        Text(this.song.artist).fontSize(10).fontColor('#C7C3CE').maxLines(1)
      }.alignItems(HorizontalAlign.Start).layoutWeight(1).onClick(() => this.onOpen())
      Button({ type: ButtonType.Circle }) {
        AppIcon({ source: this.playing ? $r('app.media.ic_pause') : $r('app.media.ic_play'), iconSize: 22 })
      }.width(38).height(38).backgroundColor('#16FFFFFF')
        .accessibilityText(this.playing ? '暂停' : '播放')
        .onClick(() => this.onToggle())
      Button({ type: ButtonType.Circle }) {
        AppIcon({ source: $r('app.media.ic_next'), iconSize: 23 })
      }.width(36).height(38).backgroundColor(Color.Transparent)
        .accessibilityText('下一首').onClick(() => this.onNext())
    }.width('100%').height(62).padding({ left: 8, right: 12 })
      .backgroundColor('#803D3B45').borderRadius(32).clip(true)
  }
}


