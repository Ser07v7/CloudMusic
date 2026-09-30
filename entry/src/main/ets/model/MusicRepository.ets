import { Song, Playlist, Banner, MusicRepository } from './model'

// 本地数据实现。以后接入网络时可替换此类，保持页面的数据接口不变。
export class LocalMusicRepository implements MusicRepository {
  getSongs(): Song[] {
    return [
      { id: 's1', title: 'Fire', artist: 'G-DRAGON', cover: $r('app.media.Fire'), duration: '03:24', genre: '流行' },
      { id: 's2', title: 'Popstar', artist: '流行精选', cover: $r('app.media.Popstar'), duration: '02:58', genre: '流行' },
      { id: 's3', title: 'Meet the Woo', artist: 'Pop Smoke', cover: $r('app.media.PopSmoke'), duration: '03:10', genre: '说唱' },
      { id: 's4', title: '夜间巡航', artist: '城市音乐企划', cover: $r('app.media.car'), duration: '04:12', genre: '说唱' },
      { id: 's5', title: 'Kiss Me', artist: '心动收藏', cover: $r('app.media.kiss'), duration: '03:46', genre: '流行' },
      { id: 's6', title: 'Red Moon', artist: 'Lil Uzi Vert', cover: $r('app.media.Red_Moon'), duration: '02:51', genre: '说唱' },
      { id: 's7', title: '午后来信', artist: 'Acoustic Sessions', cover: $r('app.media.ts'), duration: '04:06', genre: '轻音乐' },
      { id: 's8', title: '末班地铁', artist: 'City Sounds', cover: $r('app.media.metro'), duration: '03:35', genre: '轻音乐' },
      { id: 's9', title: '向光而行', artist: 'Sunday Studio', cover: $r('app.media.ladder'), duration: '04:28', genre: '轻音乐' }
    ]
  }
  getBanners(): Banner[] {
    return [
      { id: 'b1', eyebrow: 'EDITOR’S PICK / 本周主打', title: '把音量交给\n今晚的自己', subtitle: 'Fire · 跟随节奏，开启今日歌单', cover: $r('app.media.Fire'), color: '#452A25', songId: 's1' },
      { id: 'b2', eyebrow: 'NEW SOUND / 新声放映', title: '此刻心动\n不必设限', subtitle: 'Popstar · 发现你的下一首偏爱', cover: $r('app.media.Popstar'), color: '#443440', songId: 's2' },
      { id: 'b3', eyebrow: 'HIP-HOP / 节奏现场', title: '让低音\n接管夜晚', subtitle: 'Pop Smoke · 街头节奏精选', cover: $r('app.media.PopSmoke'), color: '#283641', songId: 's3' }
    ]
  }
  getPlaylists(): Playlist[] {
    return [
      { id: 'p1', title: '夜间巡航', description: '霓虹亮起，低音同行', cover: $r('app.media.car'), count: '12.8万', songIds: ['s4', 's3', 's1'] },
      { id: 'p2', title: '心动收集站', description: '把喜欢藏进每段旋律', cover: $r('app.media.kiss'), count: '8.6万', songIds: ['s5', 's2', 's7'] },
      { id: 'p3', title: '月色频率', description: '独属于深夜的氛围', cover: $r('app.media.Red_Moon'), count: '23.1万', songIds: ['s6', 's8', 's9'] }
    ]
  }
  searchSongs(keyword: string, genre: string): Song[] {
    const query: string = keyword.trim().toLowerCase()
    return this.getSongs().filter((song: Song) =>
      (genre === '全部' || song.genre === genre) &&
      (song.title.toLowerCase().includes(query) || song.artist.toLowerCase().includes(query)))
  }
}
export const musicRepository: MusicRepository = new LocalMusicRepository()

