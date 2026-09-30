// 页面和数据源共用的契约；组件只依赖接口，不依赖资源存储方式。
export interface Song {
  id: string
  title: string
  artist: string
  cover: Resource
  duration: string
  genre: string
}
export interface Playlist {
  id: string
  title: string
  description: string
  cover: Resource
  count: string
  songIds: string[]
}
export interface Banner {
  id: string
  eyebrow: string
  title: string
  subtitle: string
  cover: Resource
  color: string
  songId: string
}
export interface NavItem {
  id: number
  name: string
  icon: Resource
}
export interface MusicRepository {
  getSongs(): Song[]
  getPlaylists(): Playlist[]
  getBanners(): Banner[]
  searchSongs(keyword: string, genre: string): Song[]
}

