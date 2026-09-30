import { Playlist } from '../model/model'
import { AppIcon } from './AppIcon'

@Component
export struct AlbumCard {
  @Prop playlist: Playlist
  onOpen: (playlist: Playlist) => void = () => {}
  build() {
    Column({ space: 7 }) {
      Stack({ alignContent: Alignment.BottomEnd }) {
        Image(this.playlist.cover).width('100%').aspectRatio(1).objectFit(ImageFit.Cover)
        Row({ space: 4 }) {
          AppIcon({ source: $r('app.media.ic_play'), iconSize: 10 })
          Text(this.playlist.count).fontSize(9).fontColor('#FFFFFF')
        }.padding(5).backgroundColor('#66000000').borderRadius(10).margin(6)
      }.width('100%').aspectRatio(1).borderRadius(12).clip(true)
      Text(this.playlist.title).fontSize(13).fontColor('#F4F2F6')
        .fontWeight(FontWeight.Medium).maxLines(1)
      Text(this.playlist.description).fontSize(10).fontColor('#ADA8B5').maxLines(1)
    }.alignItems(HorizontalAlign.Start).width('100%')
      .onClick(() => this.onOpen(this.playlist))
  }
}


