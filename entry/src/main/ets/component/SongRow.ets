import { Song } from '../model/model'
import { AppIcon } from './AppIcon'

@Component
export struct SongRow {
  @Prop song: Song
  @Prop liked: boolean = false
  @Prop active: boolean = false
  onSelect: (song: Song) => void = () => {}
  onLike: (id: string) => void = () => {}

  build() {
    Row({ space: 12 }) {
      Image(this.song.cover).width(46).height(46).objectFit(ImageFit.Cover)
        .borderRadius(10).clip(true)
        .onClick(() => this.onSelect(this.song))
      Column({ space: 5 }) {
        Text(this.song.title).fontSize(15).fontWeight(FontWeight.Medium)
          .fontColor(this.active ? '#FF7C85' : '#F4F3F5').maxLines(1)
        Text(this.song.artist + ' · ' + this.song.genre).fontSize(11)
          .fontColor('#AAA6B0').maxLines(1)
      }.alignItems(HorizontalAlign.Start).layoutWeight(1)
        .onClick(() => this.onSelect(this.song))
      Text(this.song.duration).fontSize(11).fontColor('#85818D')
      Button({ type: ButtonType.Normal }) {
        AppIcon({ source: this.liked ? $r('app.media.ic_heart_fill') : $r('app.media.ic_heart'),
          color: this.liked ? '#FF7C85' : '#B9B5C1', iconSize: 20 })
      }.width(38).height(44).backgroundColor(Color.Transparent)
        .accessibilityText(this.liked ? '取消收藏' : '收藏歌曲')
        .onClick(() => this.onLike(this.song.id))
    }.width('100%').height(70)
  }
}


