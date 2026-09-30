import { Song } from '../model/model'
import { musicRepository } from '../model/MusicRepository'
import { SongRow } from './SongRow'

@Component
export struct DiscoverContent {
  @Link genre: string
  @Prop likedIds: string[] = []
  @Prop currentId: string = ''
  @State keyword: string = ''
  onPlay: (song: Song) => void = () => {}
  onLike: (id: string) => void = () => {}
  private genres: string[] = ['全部', '流行', '说唱', '轻音乐']

  build() {
    Column({ space: 16 }) {
      Column({ space: 6 }) {
        Text('发现你的下一首').fontSize(26).fontWeight(FontWeight.Bold).fontColor('#FFFFFF')
        Text('用名字寻找，或跟着心情出发').fontSize(12).fontColor('#B4AAB9')
      }.alignItems(HorizontalAlign.Start).width('100%')
      TextInput({ text: this.keyword, placeholder: '搜索歌曲、歌手' })
        .height(46).fontSize(14).fontColor('#FFFFFF').placeholderColor('#A59CA9')
        .backgroundColor('#25FFFFFF').borderRadius(14)
        .onChange((value: string) => { this.keyword = value })
      Row({ space: 8 }) {
        ForEach(this.genres, (item: string) => {
          Button(item).fontSize(12).fontColor(this.genre === item ? '#21171E' : '#D8CCD9')
            .backgroundColor(this.genre === item ? '#F4C6D1' : '#20FFFFFF')
            .layoutWeight(1).height(34)
            .onClick(() => { this.genre = item })
        }, (item: string) => item)
      }.width('100%')
      Row() {
        Text(this.keyword ? '搜索结果' : '全部好音乐').fontSize(16).fontColor('#FFFFFF')
          .fontWeight(FontWeight.Bold).layoutWeight(1)
        Text(musicRepository.searchSongs(this.keyword, this.genre).length.toString() + ' 首')
          .fontSize(11).fontColor('#B4AAB9')
      }.width('100%')
      if (musicRepository.searchSongs(this.keyword, this.genre).length === 0) {
        Column({ space: 12 }) {
          Text('还没有找到这首歌').fontSize(17).fontColor('#E5DDE8')
          Text('试试歌名的一部分，或切换分类').fontSize(12).fontColor('#AFA2B7')
          Button('查看全部').fontSize(12).backgroundColor('#754553').onClick(() => {
            this.keyword = ''
            this.genre = '全部'
          })
        }.layoutWeight(1).width('100%').justifyContent(FlexAlign.Center)
      } else {
        List({ space: 2 }) {
          ForEach(musicRepository.searchSongs(this.keyword, this.genre), (song: Song) => {
            ListItem() {
              SongRow({ song: song, liked: this.likedIds.includes(song.id),
                active: this.currentId === song.id, onSelect: this.onPlay, onLike: this.onLike })
            }
          }, (song: Song) => song.id)
        }.layoutWeight(1).width('100%').scrollBar(BarState.Off)
      }
    }.width('100%').height('100%').padding({ left: 20, right: 20, top: 22 })
  }
}


